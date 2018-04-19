<detail>
    <div class="details">
        <div class="flex-row"> <h2> Details for {accession} </h2> <span class="file_path"><a href={target_url}> <i class="fa fa-cloud-download" aria-hidden="true"></i> JSON</a></span> </div>
        <table show="{visible.bioproject}">
            <thead><tr class="table-header"><th colspan="2">BioProject: {bioproject}</th></tr></thead>
            <tbody>
                <tr if={title}><td width="180" class="atrb">Title</td><td>{title}</td></tr>
                <tr if={description}><td width="180" class="atrb">Description</td><td>{description}</td></tr>
                <tr if={organism_name}><td width="180" class="atrb">Organism name</td><td>{organism_name}</td></tr>
                <tr if={tax_id}><td width="180" class="atrb">Tax id</td><td>{ tax_id }</td></tr>
                <tr if={archive}><td width="180" class="atrb">Archive</td><td>{ archive }</td></tr>
                <tr if={locus_tag_prefix}><td width="180" class="atrb">LocusTagPrefix</td><td> { locus_tag_prefix }</td></tr>
                <tr if={organization}><td width="180" class="atrb">Organization name</td><td>{ organization}</td></tr>
                <tr if={bp_submitted}><td width="180" class="atrb">Submitted</td><td>{ bp_submitted }</td></tr>
                <tr if={xref_id}><td width="180" class="atrb">ExternalLink ID</td><td>{ external_db } : {xref_id}</td></tr>
                <tr if={prject_datatype}><td width="180" class="atrb">DataType</td><td>{ prject_datatype }</td></tr>
            </tbody>
        </table>
        <h2  show="{visible.related}">Related entries</h2>
        <table show="{visible.STUDY}">
                <thead><tr class="table-header"><th colspan="2">Study</th></tr></thead>
                <tbody each={st_item in st_items}>
                    <tr class="sub-header"><th colspan="2">{st_item.uid}</th></tr>
                    <tr if={st_item.study_title}><td width="180" class="atrb">Study Title</td><td>{st_item.study_title}</td></tr>
                    <tr if={st_item.abstract}><td width="180" class="atrb">Abstract</td><td>{st_item.abstract}</td></tr>
                    <tr if={st_item.study_type}><td width="180" class="atrb">Study Type</td><td>{st_item.study_type}</td></tr>
                    <tr if={st_item.center_name}><td width="180" class="atrb">Center Name</td><td>{st_item.center_name}</td></tr>
                    <tr if={st_item.center_project_name}><td width="180" class="atrb">Center Project Name</td><td>{st_item.center_project_name}</td></tr>
                    <tr if={st_item.study_link_url}><td width="180" class="atrb">URL Link</td><td>{st_item.study_link_url}</td></tr>
                    <tr if={st_item.publication_id}><td width="180" class="atrb">XREF ID</td><td>{st_item.publication_id}</td></tr>
                </tbody>
        </table>

        <table show="{visible.EXPERIMENT}">
            <thead>
                <tr class="table-header">
                    <th width="110">EXPERIMENT</th>
                    <th class="toggle-icon"><a role="button" data-toggle="collapse" data-parent="#accordion" href="#ex_table" aria-expanded="true" aria-controls="ex_table"><i class="fa fa-caret-square-o-up" aria-hidden="true"></i></a></th>
                </tr>
            </thead>
        </table>
        <div id="ex_table" class="panel-collapse in" role="tabpanel" aria-labelledby="ex_table">
            <table show="{visible.EXPERIMENT}" >
                <tbody each={ex_item in ex_items}>
                    <tr class="sub-header"><th colspan="2">{ex_item.uid}</th></tr>
                    <tr if={ex_item.title}><td width="180" class="atrb">Title</td><td>{ex_item.title}</td></tr>
                    <tr if={ex_item.center_name}><td width="180" class="atrb">Center Name</td><td>{ex_item.center_name}</td></tr>
                    <tr if={ex_item.design_description}><td width="180" class="atrb">Design Description</td><td>{ex_item.design_description}</td></tr>
                    <tr if={ex_item.library_layout}><td width="180" class="atrb">Library Layout</td><td>{ex_item.library_layout}</td></tr>
                    <tr if={ex_item.library_name}><td width="180" class="atrb">Library Name</td><td>{ex_item.library_name}</td></tr>
                    <tr if={ex_item.program}><td width="180" class="atrb">Program</td><td>{ex_item.program}</td></tr>
                    <tr if={ex_item.platform}><td width="180" class="atrb">Platform</td><td>{ex_item.platform}</td></tr>
                    <tr if={ex_item.protocol}><td width="180" class="atrb">Protocol</td><td>{ex_item.protocol}</td></tr>
                    <tr if={ex_item.instrument_model}><td width="180" class="atrb">Instrument Model</td><td>{ex_item.instrument_model}</td></tr>
                </tbody>
            </table>
        </div>

        <table show="{visible.biosample}">
            <thead>
                <tr class="table-header">
                    <th width="110">BioSample</th>
                    <th class="toggle-icon"><a role="button" data-toggle="collapse" data-parent="#accordion" href="#bs_table" aria-expanded="true" aria-controls="bs_table"><i class="fa fa-caret-square-o-up" aria-hidden="true"></i></a></th>
                </tr>
            </thead>
        </table>
        <div id="bs_table" class="panel-collapse in" role="tabpanel" aria-labelledby="bs_table">
            <table show="{visible.biosample}" >
                <tbody each={bs_item in bs_items}>
                    <tr class="sub-header"><th colspan="2">{bs_item.uid}</th></tr>
                    <tr if={bs_item.title}><td width="180" class="atrb">Title</td><td>{bs_item.title}</td></tr>
                    <tr if={bs_item.taxonomy_id}><td width="180" class="atrb">Taxonomy ID</td><td>{bs_item.taxonomy_id}</td></tr>
                    <tr if={bs_item.taxonomy_name}><td width="180" class="atrb">Taxonomy Name</td><td>{bs_item.taxonomy_name}</td></tr>
                    <tr if={bs_item.package}><td width="180" class="atrb">Package</td><td>{bs_item.package}</td></tr>
                    <tr if={bs_item.env_package}><td width="180" class="atrb">Env Package</td><td>{bs_item.env_package}</td></tr>
                </tbody>
            </table>
        </div>

        <table show="{visible.SAMPLE}">
            <thead>
            <tr class="table-header">
                <th width="110">SAMPLE</th>
                <th class="toggle-icon"><a role="button" data-toggle="collapse" data-parent="#accordion" href="#s_table" aria-expanded="true" aria-controls="s_table"><i class="fa fa-caret-square-o-up" aria-hidden="true"></i></a></th>
            </tr>
            </thead>
        </table>
        <div id="s_table" class="panel-collapse in" role="tabpanel" aria-labelledby="s_table">
            <table show="{visible.SAMPLE}" >
                <tbody each={smp_item in smp_items}>
                <tr class="sub-header"><th colspan="2">{smp_item.uid}</th></tr>
                <tr if={mp_item.title}><td width="180" class="atrb">Title</td><td>{smp_item.title}</td></tr>
                <tr if={mp_item.scientific_name}><td width="180" class="atrb">Scientific Name</td><td>{mp_item.scientific_name}</td></tr>
                <tr if={mp_item.taxon_id}><td width="180" class="atrb">Taxonomy ID</td><td>{mp_item.taxon_id}</td></tr>
                </tbody>
            </table>
        </div>

        <table show="{visible.RUN}">
            <thead>
            <tr class="table-header">
                <th width="110">RUN</th>
                <th class="toggle-icon"><a role="button" data-toggle="collapse" data-parent="#accordion" href="#run_table" aria-expanded="true" aria-controls="run_table"><i class="fa fa-caret-square-o-up" aria-hidden="true"></i></a></th>
            </tr>
            </thead>
        </table>
        <div id="run_table" class="panel-collapse in" role="tabpanel" aria-labelledby="run_table">
            <table show="{visible.RUN}">
                <tbody each={run_item in run_items}>
                    <tr class="sub-header">
                        <th>{run_item.uid}</th>
                        <th>
                            <span if={run_item.sra_path} class="file_path"><a href={base_file_path}{run_item.sra_path}><i class="fa fa-cloud-download" aria-hidden="true"></i> sra</a></span>
                            <span if={run_item.fastq_path} class="file_path"><a href={base_file_path}{run_item.fastq_path}><i class="fa fa-cloud-download" aria-hidden="true"></i> fastq</a></span>
                        </th>
                    </tr>
                    <tr if={run_item.prefix}><td width="180" class="atrb">Submission</td><td>{run_item.prefix}</td></tr>
                    <tr if={run_item.program}><td width="180" class="atrb">Program</td><td>{run_item.program}</td></tr>
                </tbody>
            </table>
        </div>


    </div>
    <script type="text/javascript">
        this.visible = {
            bioproject: false,
            biosample: false,
            STUDY: false,
            RUN:false,
            EXPERIMENT: false,
            SAMPLE: false,


            ANALYSIS: false,



            related: false




        };
        var self = this;
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
            if (self.visible.EXPERIMENT || self.visible.STUDY || self.visible.biosample || self.visible.RUN) {
                self.visible.related = true;
            }

            self.update()
        }

        var args = location.search;
        var props = args.slice(1).split('&');
        var targetdb = props[0].split('=')[1];

        obs.trigger("targetSelected", targetdb);

    </script>
</detail>