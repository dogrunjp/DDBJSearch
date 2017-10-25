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
        <table show="{visible.STUDY}">
            <thead><tr class="table-header"><th colspan="2">Study: {study}</th></tr></thead>
            <tbody>
                <tr if={study_title}><td width="180" class="atrb">Study Title</td><td>{study_title}</td></tr>
                <tr if={abstract}><td width="180" class="atrb">Abstract</td><td>{abstract}</td></tr>
                <tr if={study_type}><td width="180" class="atrb">Study Type</td><td>{study_type}</td></tr>
                <tr if={center_name}><td width="180" class="atrb">Center Name</td><td>{center_name}</td></tr>
                <tr if={center_project_name}><td width="180" class="atrb">Center Project Name</td><td>{center_project_name}</td></tr>
                <tr if={study_link_url}><td width="180" class="atrb">URL Link</td><td>{study_link_url}</td></tr>
                <tr if={publication_id}><td width="180" class="atrb">XREF ID</td><td>{publication_id}</td></tr>
            </tbody>
        </table>

        <table show="{visible.EXPERIMENT}">
            <thead>
                <tr class="table-header">
                    <th width="110">Experiment</th>
                    <th class="toggle-icon"><a role="button" data-toggle="collapse" data-parent="#accordion" href="#ex_table" aria-expanded="true" aria-controls="ex_table"><i class="fa fa-caret-square-o-up" aria-hidden="true"></i></a></th>
                </tr>
            </thead>
        </table>
        <div id="ex_table" class="panel-collapse in" role="tabpanel" aria-labelledby="ex_table">
            <table show="{visible.EXPERIMENT}" >
                <tbody each={ex_items}>
                    <tr class="sub-header"><th colspan="2">{uid}</th></tr>
                    <tr if={title}><td width="180" class="atrb">Title</td><td>{title}</td></tr>
                    <tr if={center_name}><td width="180" class="atrb">Center Name</td><td>{center_name}</td></tr>
                    <tr if={instrumental_model}><td width="180" class="atrb">Instrumental Model</td><td>{instrumental_model}</td></tr>
                    <tr if={design_description}><td width="180" class="atrb">Design Description</td><td>{design_description}</td></tr>
                    <tr if={library_layout}><td width="180" class="atrb">Library Layout</td><td>{library_layout}</td></tr>
                    <tr if={library_name}><td width="180" class="atrb">Library Name</td><td>{library_name}</td></tr>
                    <tr if={program}><td width="180" class="atrb">Program</td><td>{program}</td></tr>
                    <tr if={platform}><td width="180" class="atrb">Platform</td><td>{platform}</td></tr>
                    <tr if={protocol}><td width="180" class="atrb">Protocol</td><td>{protocol}</td></tr>
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
                <tbody each={bs_items}>
                    <tr class="sub-header"><th colspan="2">{uid}</th></tr>
                    <tr if={title}><td width="180" class="atrb">Title</td><td>{title}</td></tr>
                    <tr if={taxonomy_id}><td width="180" class="atrb">Taxonomy ID</td><td>{taxonomy_id}</td></tr>
                    <tr if={taxonomy_name}><td width="180" class="atrb">Taxonomy Name</td><td>{taxonomy_name}</td></tr>
                    <tr if={package}><td width="180" class="atrb">Package</td><td>{package}</td></tr>
                    <tr if={env_package}><td width="180" class="atrb">Env Package</td><td>{env_package}</td></tr>
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
                <tbody each={bs_items}>
                <tr class="sub-header"><th colspan="2">{uid}</th></tr>
                <tr if={title}><td width="180" class="atrb">Title</td><td>{title}</td></tr>
                <tr if={scientific_name}><td width="180" class="atrb">Scientific Name</td><td>{scientific_name}</td></tr>
                <tr if={taxon_id}><td width="180" class="atrb">Taxonomy ID</td><td>{taxon_id}</td></tr>
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
                <tbody each={run_items}>
                    <tr class="sub-header">
                        <th>{uid}</th>
                        <th>
                            <span if={sra_path} class="file_path"><a href={base_file_path}{sra_path}><i class="fa fa-cloud-download" aria-hidden="true"></i> sra</a></span>
                            <span if={fastq_path} class="file_path"><a href={base_file_path}{fastq_path}><i class="fa fa-cloud-download" aria-hidden="true"></i> fastq</a></span>
                        </th>
                    </tr>
                    <tr if={prefix}><td width="180" class="atrb">Submission</td><td>{prefix}</td></tr>
                    <tr if={program}><td width="180" class="atrb">Program</td><td>{program}</td></tr>
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
            SAMPLE: false
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
        var base_url = "http://localhost:8080/details?db=";
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
                //console.log(d);
                set_show(Object.keys(d));
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

                sval = new default_val("STUDY");
                self.study = sval.get("uid");
                self.study_title = sval.get("study_title");
                self.abstract = sval.get("abstract");
                self.study_type = sval.get("study_type");
                self.study_link_url = sval.get("study_link_url");
                self.publication_id = sval.get("publication_id");
                self.prefex = sval.get("prefix");
                self.center_name = sval.get("center_name");
                self.center_project_name = sval.get("center_project_name");

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

                self.ex_items = d.EXPERIMENT;
                a2str_obj(self.ex_items);

                self.run_items = d.RUN;
                a2str_obj(self.run_items);

                self.bs_items = d.biosample;
                a2str_obj(self.bs_items);

                self.s_items = d.SAMPLE;
                a2str_obj(self.s_items);


                self.update();

            });

        function set_show(l) {
            // visible.kの値を変更しタグをupdateする
            //self.visible.bioproject = self.visible.study = self.visible.experiment = true;
            l.forEach(function(x){
                self.visible[x] = true;
            });
            self.update()

        }



    </script>
</detail>