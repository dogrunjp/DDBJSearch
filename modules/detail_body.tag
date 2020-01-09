<!-- 現在つかっていない -->
<detail>
    <detail_table name="tbl"></detail_table>
    <script type="text/javascript">
        this.visible = {
            bioproject: false,
            bioproject_top: false,
            biosample: false,
            bopsample_top: false,
            STUDY: false,
            STUDY_top: false,
            RUN:false,
            EXPERIMENT: false,
            SAMPLE: false,
            ANALYSIS: false,
            SUBMISSION: false,
            related: false

        };
        var self = this, child;
        var arg = {};
        var q =location.search.substring(1).split('&');
        for(var i=0;q[i];i++) {
            var kv = q[i].split('=');
            arg[kv[0]]=kv[1];
        }
        var db = arg["db"];
        var uid = arg["accession"];
        // BioProjectに変換する必要有り
        this.accession = uid;
        var base_url = conf.api_details_base_url;
        self.base_file_path = "ftp://ftp.ddbj.nig.ac.jp";
        var target_url = base_url + db + "&id=" + uid;
        self.target_url = target_url;

        function get_data(db, uid) {
            return $.ajax({
                type: "GET",
                url: target_url,
                timeout: 5000
            });
        }

        get_data(db, uid)
            .done(function(d){
                set_show(d);
                set_details();
                function default_val(k) {
                    this.k = k;
                }
                default_val.prototype.get = function (p) {
                    try{
                        var el = d[this.k][0][p];
                        if (Array.isArray(el)){
                            return el.join()
                        }else{
                            return el
                        }
                    }
                    catch (e){
                        return null
                    }
                };

                bpval = new default_val("bioproject");
                self.bioproject = bpval.get("uid");
                self.title = bpval.get("title");
                self.description = bpval.get("description");
                self.organism_name = bpval.get("organism_name");
                self.tax_id = bpval.get("tax_id");
                self.archive = bpval.get("archive");
                self.locus_tag_prefix = bpval.get( "locus_tag_prefix");
                self.organization = bpval.get("organization_name");
                self.xref_id = bpval.get("xref_id");
                self.external_db = bpval.get("external_db");
                self.bp_submitted = bpval.get("submitted");


                function a2str_obj(obj) {
                    try{
                        obj.forEach(function (d) {
                            Object.keys(d).forEach(function (g) {
                                if (Array.isArray(d[g])) {
                                    d[g] = d[g][0]

                                }
                            })
                        });
                    }catch (d){}
                }

                self.st_items = d.STUDY;
                a2str_obj(self.st_items);

                self.ex_items = d.EXPERIMENT;
                a2str_obj(self.ex_items);

                self.run_items = d.RUN;
                a2str_obj(self.run_items);

                self.bs_items = d.biosample;
                a2str_obj(self.bs_items);

                self.smp_items = d.SAMPLE;
                a2str_obj(self.smp_items);

                self.ana_items = d.ANALYSIS;
                a2str_obj(self.ana_items);

                self.sb_items = d.SUBMISSION;
                a2str_obj(self.sb_items);

                self.update();

            });

        function set_show(d) {
            // visible.kの値を変更しタグをupdateする
            //self.visible.bioproject = self.visible.study = self.visible.experiment = true;
            var types = Object.keys(d);
            types.forEach(function(x){
                if(d[x].length > 0){
                    self.visible[x] = true;
                }
            });


            //dbの値に寄ってテーブルの表示順を帰る。details~, related~
            // project, study, sample をdetailsとrelatedに併記し、排他的にshow のtrue, falseを決める
            // ただし、[true, false]または[false, false]の可能性もある。
            f = {};
            f["sra"] = function () {
                // Submission検索のケースでは
                if(self.visible.SUBMISSION) {
                    self.visible.STUDY_top = false;
                    self.visible.STUDY = true;
                }else{
                    self.visible.STUDY_top = true;
                    self.visible.STUDY = false;
                    self.visible.SUBMISSION = false
                }
            };
            f["bioproject"] = function () {
                self.visible.bioproject_top = true;
                self.visible.bioproject = false
            };
            f["biosample"] = function () {
                self.visible.biosample_top = true;
                self.visible.biosample = false;
            };

            f[db]();

            if (self.visible.EXPERIMENT || self.visible.STUDY || self.visible.biosample || self.visible.RUN || self.visible.bioproject || self.visible.analysis) {
                self.visible.related = true;
            }

            self.update()
        }

        function set_details(){
            riot.compile('./modules/detail_table.tag', function () {
                riot.mount('detail_table');
                self.update();
                console.log(this.tags)

            })

        }
        this.on('mount',function () {
            console.log(this.tags)
        })


        var args = location.search;
        var props = args.slice(1).split('&');
        var targetdb = props[0].split('=')[1];
        obs.trigger("targetSelected", targetdb);

    </script>
</detail>