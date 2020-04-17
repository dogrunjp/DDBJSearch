<detail>
    <div class="details">

        <div class="flex-row"> <h2> Details for {accession} </h2> <span class="file_path"><a href={target_url}> <i class="fa fa-cloud-download" aria-hidden="true"></i> JSON</a></span> </div>

        <table show="{visible.bioproject_top}">
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
                <tr if={publication_id}><td width="180" class="atrb">Publication ID</td><td>{ publication_id }</td></tr>
                <tr if={xref_id}><td width="180" class="atrb">ExternalLink ID</td><td>{ external_db } : {xref_id}</td></tr>
                <tr if={project_datatype}><td width="180" class="atrb">DataType</td><td>{ project_datatype }</td></tr>
            </tbody>
        </table>

        <table show="{visible.STUDY_top}">
            <thead><tr class="table-header"><th colspan="2">STUDY</th></tr></thead>
            <tbody>
            <tr class="sub-header"><th colspan="2">{study}</th></tr>
            <tr if={study_title}><td width="180" class="atrb">Study Title</td><td>{study_title}</td></tr>
            <tr if={abstract}><td width="180" class="atrb">Abstract</td><td>{abstract}</td></tr>
            <tr if={study_type}><td width="180" class="atrb">Study Type</td><td>{study_type}</td></tr>
            <tr if={center_name}><td width="180" class="atrb">Center Name</td><td>{center_name}</td></tr>
            <tr if={center_project_name}><td width="180" class="atrb">Center Project Name</td><td>{center_project_name}</td></tr>
            <tr if={study_link_url}><td width="180" class="atrb">URL Link</td><td>{study_link_url}</td></tr>
            <tr if={publication_id}><td width="180" class="atrb">XREF ID</td><td>{publication_id}</td></tr>
            </tbody>
        </table>

        <div show="{visible.EXPERIMENT_RUN_top}">
            <table>
                <thead>
                <tr class="table-header">
                    <th width="110">EXPERIMENT, RUN, and BioSample</th>
                    <th class="toggle-icon"><a role="button" data-toggle="collapse" data-parent="#accordion" href="#er_table_m" aria-expanded="true" aria-controls="er_table_m">
                        <i class="fa fa-caret-square-o-up" aria-hidden="true"></i></a></th>
                </tr>
                </thead>
            </table>

            <div show="{visible.EXPERIMENT_RUN_top}" id="er_table" class="panel-collapse in" role="tabpanel" aria-labelledby="run_table">
                <table each={er_item in er_items} if={er_item.experiment._id==accession || er_item.run._id==accession || er_item.biosample._id==accession}>
                    <tbody>
                        <tr class="sub-header"><th colspan="2">EXPERIMENT: {er_item.experiment._id}</th></tr>
                        <tr if={er_item.experiment.TITLE}><td width="180" class="atrb">Title</td><td>{er_item.experiment.TITLE}</td></tr>
                        <tr if={er_item.experiment.center_name}><td width="180" class="atrb">Center Name</td><td>{er_item.experiment.center_name}</td></tr>
                        <tr if={er_item.experiment.design_description}><td width="180" class="atrb">Design Description</td><td>{er_item.experiment.design_description}</td></tr>
                        <tr if={er_item.experiment.LIBRARY_LAYOUT}><td width="180" class="atrb">Library Layout</td><td>{er_item.experiment.LIBRARY_LAYOUT}</td></tr>
                        <tr if={er_item.experiment.library_name}><td width="180" class="atrb">Library Name</td><td>{er_item.experiment.library_name}</td></tr>
                        <tr if={er_item.experiment.program}><td width="180" class="atrb">Program</td><td>{er_item.experiment.program}</td></tr>
                        <tr if={er_item.experiment.protocol}><td width="180" class="atrb">Protocol</td><td>{er_item.experiment.protocol}</td></tr>
                        <tr if={er_item.experiment.INSTRUMENT_MODEL}><td width="180" class="atrb">Instrument Model</td><td>{er_item.experiment.INSTRUMENT_MODEL}</td></tr>

                        <tr if={er_item.biosample._id} class="sub-header"><th colspan="2">BioSample: {er_item.biosample._id}</th></tr>
                        <tr if={er_item.biosample.Title}><td width="180" class="atrb">Title</td><td>{er_item.biosample.Title}</td></tr>
                        <tr if={er_item.biosample.taxonomy_id}><td width="180" class="atrb">Taxonomy ID</td><td>{er_item.biosample.taxonomy_id}</td></tr>
                        <tr if={er_item.biosample.taxonomy_name}><td width="180" class="atrb">Taxonomy Name</td><td>{er_item.biosample.taxonomy_name}</td></tr>
                        <tr if={er_item.biosample.Package}><td width="180" class="atrb">Package</td><td>{er_item.biosample.Package}</td></tr>
                        <tr if={er_item.biosample.attributes} ><td colspan="2" class="atrb">Attributes</td></tr>
                        <tr each={attribute in er_item.biosample.attributes || []}><td>{Object.keys(attribute).toString()}</td><td>{Object.values(attribute).toString()}</td></tr>

                        <tr class="sub-header" if={er_item.run.length > 0}><th colspan="2">RUN</th></tr>
                        <tr each={run_item in er_item.run}>
                        <td>{run_item._id}</td>
                        <td class="atrb">
                            <span if={run_item.sra_path} class="file_path"><a href={run_item.sra_path}><i class="fa fa-cloud-download" aria-hidden="true"></i> sra</a></span>
                            <span if={run_item.fastq_path} class="file_path"><a href={base_file_path}{run_item.fastq_path}><i class="fa fa-cloud-download" aria-hidden="true"></i> fastq</a></span>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <table show="{visible.ANALYSIS_top}">
            <thead>
            <tr class="table-header">
                <th width="110">ANALYSIS</th>
                <th class="toggle-icon"><a role="button" data-toggle="collapse" data-parent="#accordion" href="#ana_table" aria-expanded="true" aria-controls="ana_table"><i class="fa fa-caret-square-o-up" aria-hidden="true"></i></a></th>
            </tr>
            </thead>
        </table>
        <div show="{visible.ANALYSIS}" id="ana_table" class="panel-collapse in" role="tabpanel" aria-labelledby="ana_table">
            <table>
                <tbody each={ana_item in ana_items}>
                <tr class="sub-header"><th colspan="2">{ana_item.uid}</th></tr>
                <tr if={ana_item.title}><td width="180" class="atrb">Title</td><td>{ana_item.title}</td></tr>
                <tr if={ana_item.center_name}><td width="180" class="atrb">Center Name</td><td>{ana_item.center_name}</td></tr>
                <tr if={ana_item.analysis_type}><td width="180" class="atrb">Design Description</td><td>{ana_item.design_description}</td></tr>
                </tbody>
            </table>
        </div>

        <table show="{visible.SAMPLE_top}">
            <thead>
            <tr class="table-header">
                <th width="110">SAMPLE</th>
                <th class="toggle-icon"><a role="button" data-toggle="collapse" data-parent="#accordion" href="#s_table" aria-expanded="true" aria-controls="s_table"><i class="fa fa-caret-square-o-up" aria-hidden="true"></i></a></th>
            </tr>
            </thead>
        </table>
        <div show="{visible.SAMPLE_top}"  id="s_table" class="panel-collapse in" role="tabpanel" aria-labelledby="s_table">
            <table>
                <tbody each={smp_item in smp_items}>
                <tr class="sub-header"><th colspan="2">{smp_item.uid}</th></tr>
                <tr if={smp_item.title}><td width="180" class="atrb">Title</td><td>{smp_item.title}</td></tr>
                <tr if={smp_item.scientific_name}><td width="180" class="atrb">Scientific Name</td><td>{smp_item.scientific_name}</td></tr>
                <tr if={smp_item.taxon_id}><td width="180" class="atrb">Taxonomy ID</td><td>{smp_item.taxon_id}</td></tr>
                </tbody>
            </table>
        </div>


        <table show="{visible.SUBMISSION}">
            <thead>
            <tr class="table-header">
                <th width="110">Submission</th><th></th>
            </tr>
            </thead>
            <tbody each={sb_item in sb_items}>
            <tr class="sub-header"><th colspan="2">{sb_item.uid}</th></tr>
            <tr if={sb_item.title}><td width="180" class="atrb">Title</td><td>{sb_item.title}</td></tr>
            <tr if={sb_item.center_name}><td width="180" class="atrb">Center_name</td><td>{sb_item.center_name}</td></tr>
            <tr if={sb_item.lab_name}><td width="180" class="atrb">Lab_name</td><td>{sb_item.lab_name}</td></tr>
            </tbody>
        </table>

        <h2  show="{visible.related}">Related entries</h2>


        <table show="{visible.bioproject}" class="bp">
            <thead><tr></tr></thead>
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
                <tr if={publication_id}><td width="180" class="atrb">Publication ID</td><td>{ publication_id }</td></tr>
                <tr if={xref_id}><td width="180" class="atrb">ExternalLink ID</td><td>{ external_db } : {xref_id}</td></tr>
                <tr if={project_datatype}><td width="180" class="atrb">DataType</td><td>{ project_datatype }</td></tr>
            </tbody>
        </table>

        <table show="{visible.study}">
                <thead><tr class="table-header"><th colspan="2">STUDY</th></tr></thead>
                <tbody>
                <tr class="sub-header"><th colspan="2">{study}</th></tr>
                <tr if={study_title}><td width="180" class="atrb">Study Title</td><td>{study_title}</td></tr>
                <tr if={abstract}><td width="180" class="atrb">Abstract</td><td>{abstract}</td></tr>
                <tr if={study_type}><td width="180" class="atrb">Study Type</td><td>{study_type}</td></tr>
                <tr if={center_name}><td width="180" class="atrb">Center Name</td><td>{center_name}</td></tr>
                <tr if={center_project_name}><td width="180" class="atrb">Center Project Name</td><td>{center_project_name}</td></tr>
                <tr if={study_link_url}><td width="180" class="atrb">URL Link</td><td>{study_link_url}</td></tr>
                <tr if={publication_id}><td width="180" class="atrb">XREF ID</td><td>{publication_id}</td></tr>
                </tbody>
        </table>

        <div id="experiment_run" show="{visible.experiment_group}">
            <table>
                <thead>
                <tr class="table-header">
                    <th width="110">EXPERIMENT, RUN, and BioSample</th>
                    <th class="toggle-icon"><a role="button" data-toggle="collapse" data-parent="#accordion" href="#er_table_m" aria-expanded="true" aria-controls="er_table_m">
                        <i class="fa fa-caret-square-o-up" aria-hidden="true"></i></a></th>
                </tr>
                </thead>
            </table>

            <div id="er_table_m" class="panel-collapse in" role="tabpanel" aria-labelledby="run_table">
                <table each={er_item in er_items} class="er" if={er_item.experiment._id != accession & er_item.run._id != accession} >
                    <tbody>
                        <tr class="sub-header"><th colspan="2">EXPERIMENT: {er_item.experiment._id}</th></tr>
                        <tr if={er_item.experiment.TITLE}><td width="180" class="atrb">Title</td><td>{er_item.experiment.TITLE}</td></tr>
                        <tr if={er_item.experiment.center_name}><td width="180" class="atrb">Center Name</td><td>{er_item.experiment.center_name}</td></tr>
                        <tr if={er_item.experiment.design_description}><td width="180" class="atrb">Design Description</td><td>{er_item.experiment.design_description}</td></tr>
                        <tr if={er_item.experiment.LIBRARY_LAYOUT}><td width="180" class="atrb">Library Layout</td><td>{er_item.experiment.LIBRARY_LAYOUT}</td></tr>
                        <tr if={er_item.experiment.library_name}><td width="180" class="atrb">Library Name</td><td>{er_item.experiment.library_name}</td></tr>
                        <tr if={er_item.experiment.program}><td width="180" class="atrb">Program</td><td>{er_item.experiment.program}</td></tr>
                        <tr if={er_item.experiment.protocol}><td width="180" class="atrb">Protocol</td><td>{er_item.experiment.protocol}</td></tr>
                        <tr if={er_item.experiment.INSTRUMENT_MODEL}><td width="180" class="atrb">Instrument Model</td><td>{er_item.experiment.INSTRUMENT_MODEL}</td></tr>

                        <tr if={er_item.biosample._id} class="sub-header"><th colspan="2">BioSample: {er_item.biosample._id}</th></tr>
                        <tr if={er_item.biosample.Title}><td width="180" class="atrb">Title</td><td>{er_item.biosample.Title}</td></tr>
                        <tr if={er_item.biosample.taxonomy_id}><td width="180" class="atrb">Taxonomy ID</td><td>{er_item.biosample.taxonomy_id}</td></tr>
                        <tr if={er_item.biosample.taxonomy_name}><td width="180" class="atrb">Taxonomy Name</td><td>{er_item.biosample.taxonomy_name}</td></tr>
                        <tr if={er_item.biosample.Package}><td width="180" class="atrb">Package</td><td>{er_item.biosample.Package}</td></tr>
                        <tr if={er_item.biosample.attributes} ><td colspan="2" class="atrb">Attributes</td></tr>
                        <tr each={attribute in er_item.biosample.attributes || []}><td>{Object.keys(attribute).toString()}</td><td>{Object.values(attribute).toString()}</td></tr>

                        <tr class="sub-header" if={er_item.run.length > 0}><th colspan="2">RUN</th></tr>
                        <tr each={run_item in er_item.run}>
                            <td>{run_item._id}</td>
                            <td class="atrb">
                                <span if={run_item.sra_path} class="file_path"><a href={run_item.sra_path}><i class="fa fa-cloud-download" aria-hidden="true"></i> sra</a></span>
                                <span if={run_item.fastq_path} class="file_path"><a href={base_file_path}{run_item.fastq_path}><i class="fa fa-cloud-download" aria-hidden="true"></i> fastq</a></span>
                            </td>
                        </tr>


                    </tbody>
                </table>
            </div>
        </div>

        <!--
        <table show="{visible.biosample}">
            <thead>
                <tr class="table-header">
                    <th width="110">BioSample</th>
                    <th class="toggle-icon"><a role="button" data-toggle="collapse" data-parent="#accordion" href="#bs_table_m" aria-expanded="true" aria-controls="bs_table_m">
                        <i class="fa fa-caret-square-o-up" aria-hidden="true"></i></a></th>
                </tr>
            </thead>
        </table>
        <div id="bs_table_m" class="panel-collapse in" role="tabpanel" aria-labelledby="bs_table">
            <table show="{visible.biosample}" >
                <tbody each={bs_item in bs_items} {bs_item.uid != accession}>
                    <tr class="sub-header"><th colspan="2">{bs_item.uid}</th></tr>
                    <tr if={bs_item.title}><td width="180" class="atrb">Title</td><td>{bs_item.title}</td></tr>
                    <tr if={bs_item.taxonomy_id}><td width="180" class="atrb">Taxonomy ID</td><td>{bs_item.taxonomy_id}</td></tr>
                    <tr if={bs_item.taxonomy_name}><td width="180" class="atrb">Taxonomy Name</td><td>{bs_item.taxonomy_name}</td></tr>
                    <tr if={bs_item.package}><td width="180" class="atrb">Package</td><td>{bs_item.package}</td></tr>
                    <tr if={bs_item.env_package}><td width="180" class="atrb">Env Package</td><td>{bs_item.env_package}</td></tr>
                </tbody>
            </table>
        </div>
        -->

        <!--
        <table show="{visible.ANALYSIS}">
            <thead>
            <tr class="table-header">
                <th width="110">ANALYSIS</th>
                <th class="toggle-icon"><a role="button" data-toggle="collapse" data-parent="#accordion" href="#ana_table" aria-expanded="true" aria-controls="ana_table"><i class="fa fa-caret-square-o-up" aria-hidden="true"></i></a></th>
            </tr>
            </thead>
        </table>
        -->
        <div id="ana_table" class="panel-collapse in" role="tabpanel" aria-labelledby="ana_table">
            <table show="{visible.ANALYSIS}" >
                <tbody each={ana_item in ana_items}>
                <tr class="sub-header"><th colspan="2">{ana_item.uid}</th></tr>
                <tr if={ana_item.title}><td width="180" class="atrb">Title</td><td>{ana_item.title}</td></tr>
                <tr if={ana_item.center_name}><td width="180" class="atrb">Center Name</td><td>{ana_item.center_name}</td></tr>
                <tr if={ana_item.analysis_type}><td width="180" class="atrb">Design Description</td><td>{ana_item.design_description}</td></tr>
                </tbody>
            </table>
        </div>

        <!--
        <table show="{visible.SAMPLE}">
            <thead>
            <tr class="table-header">
                <th width="110">SAMPLE</th>
                <th class="toggle-icon"><a role="button" data-toggle="collapse" data-parent="#accordion" href="#s_table" aria-expanded="true" aria-controls="s_table"><i class="fa fa-caret-square-o-up" aria-hidden="true"></i></a></th>
            </tr>
            </thead>
        </table>
        -->

        <div id="s_table" class="panel-collapse in" role="tabpanel" aria-labelledby="s_table">
            <table show="{visible.SAMPLE}" >
                <tbody each={smp_item in smp_items}>
                <tr class="sub-header"><th colspan="2">{smp_item.uid}</th></tr>
                <tr if={smp_item.title}><td width="180" class="atrb">Title</td><td>{smp_item.title}</td></tr>
                <tr if={smp_item.scientific_name}><td width="180" class="atrb">Scientific Name</td><td>{smp_item.scientific_name}</td></tr>
                <tr if={smp_item.taxon_id}><td width="180" class="atrb">Taxonomy ID</td><td>{smp_item.taxon_id}</td></tr>
                </tbody>
            </table>
        </div>

    </div>
    <script type="text/javascript">
        this.visible = {
            bioproject: false,
            bioproject_top: false,
            biosample: false,
            bopsample_top: false,
            STUDY: false,
            STUDY_top: false,
            RUN:false,
            RUN_top: false,
            EXPERIMENT: false,
            EXPERIMENT_top: false,
            SAMPLE: false,
            SAMPLE_top: false,
            ANALYSIS: false,
            ANALYSIS_top: false,
            SUBMISSION: false,
            related: false,
            experiment_group: false,
            experiment_group_top: false

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
        var study = arg["_id"];
        // BioProjectに変換する必要有り
        self.accession = uid;
        var base_url = conf.api_base + "/details?db=";
        self.base_file_path = "ftp://ftp.ddbj.nig.ac.jp";
        // _id（study）を追加
        if (study){
            var target_url = base_url + db + "&id=" + uid + "&_id=" + study;
            // whole metada を取得するためのapi path
            self.target_url = conf.api_base + "/metadata/" + study;
        }else{
            var target_url = base_url + db + "&id=" + uid;
        }


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
                if (d.bioproject){
                    self.bioproject = d.bioproject._id;
                    self.title = d.bioproject.Title;
                    self.description = d.bioproject.Description;
                    self.organism_name = d.bioproject.OrganismName;
                    self.organization_name = d.bioproject.Name;
                    self.archive = d.bioproject.archive;
                    self.locus_tag_prefix = d.bioproject.LocusTagPrefix;
                    self.organization = d.bioproject.Name;
                    self.external_db = d.bioproject.db;
                    self.publication_id = d.bioproject.id;
                    self.bp_submitted = d.bioproject.submitted;
                    self.project_datatype = d.bioproject.DataType;
                }

                if (d.study){
                    self.study = d.study._id;
                    self.study_title = d.study.STUDY_TITLE;
                    self.study_type =d.study.existing_study_type;
                    self.abstract = d.study.STUDY_ABSTRACT;
                    self.center_name = d.study.center_name;
                    self.center_project_name = d.study.CENTER_PROJECT_NAME;
                    self.study_link_url = d.study.URL;
                    self.publication_id = d.study.ID;

                }


                // 要らないのでは
                function a2str_obj(obj) {
                    // visbleを設定するため、typeごとのkeyを取得
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

                //self.st_item = d.study;
                //a2str_obj(self.st_items);

                /*
                 取得したJSONからSTUDY[0]["uid"]を取得し、whole metadata のAPIのパラメータとする
                 /metadata API!
                */
                self.target_url = conf.api_base + "/metadata/" + self.study;
                /*
                self.ex_items = d.experiment;
                a2str_obj(self.ex_items);

                self.run_items = d.run;
                a2str_obj(self.run_items);

                self.bs_items = d.biosample;
                a2str_obj(self.bs_items);

                self.smp_items = d.sample;
                a2str_obj(self.smp_items);

                self.ana_items = d.analysis;
                a2str_obj(self.ana_items);

                self.sb_items = d.submission;
                a2str_obj(self.sb_items);
                */

                //experiment_groupのオブジェクトをtype別にまとめる
                var types = ["experiment", "biosample", "run"];
                self.er_items = [];
                if (d.experiment_group){
                    d.experiment_group.forEach(function (obj) {
                        // groupごとの処理
                        var item = {}
                        types.forEach(function (t) {
                            // typeごとの処理
                            var tmp_d = obj.filter(function (e) {
                                return e._index == t
                            });
                            item[t] = tmp_d.length == 1 && t != "run" ? tmp_d[0] : tmp_d
                        });
                        self.er_items.push(item)
                    });
                }
                //a2str_obj(self.er_items)
                self.update();

            });

        function set_show(d) {
            // visible.kの値を変更しタグをupdateする
            // self.visible.bioproject = self.visible.study = self.visible.experiment = true;
            var types = Object.keys(d);
            types.forEach(function(x){
                self.visible[x] = true;
                // experiment_groupにexperimentとrun,biosampleが内包される。
                if(x == "experiment_group"){
                    self.visible.experiment_group = true;
                    self.visible.EXPERIMENT = true;
                    self.visible.RUN = true;
                    self.visible.BioSample = true;
                }

            });

            //dbの値に寄ってテーブルの表示順を変更する。details~, related~
            // project, study, sample をdetailsとrelatedに併記し、排他的にshow のtrue, falseを決める
            // ただし、[true, false]または[false, false]の可能性もある。
            f = {};
            f["sra"] = function () {
                // テーブルの最上部に表示するメタデータのタイプの設定
                // typeを取得し,x_top = trueに設定する
                if (arg.accession){
                    var T = {};
                    T = {
                        "P": function () {
                            self.visible.STUDY_top = true;
                            self.visible.study = false;
                        },
                        "X": function () {
                            // 配列オブジェクトとなるメタデータはクエリのaccessionと一致するオブジェクトのみ"details"に表示する
                            self.visible.EXPERIMENT_RUN_top = true;
                            self.visible.EXPERIMENT_RUN = true;
                        },
                        "S": function () {
                            self.visible.SAMPLE_top = true;
                            self.visible.SAMPLE = false;
                        },
                        "R": function() {
                            // 配列オブジェクトとなるメタデータはクエリのaccessionと一致するオブジェクトのみ"details"に表示する
                            self.visible.EXPERIMENT_RUN_top = true;
                            self.visible.EXPERIMENT_RUN = true;
                        },
                        "Z": function () {
                            self.visible.ANALYSIS_top = true;
                            self.visible.ANALYSIS = false;
                        },
                        "A": function () {
                            self.visible.SUBMISSION = true
                        }
                    };
                    uid = arg.accession;
                    T[uid.substr(2, 1)]();

                }else{
                    // study以外のバラメータでなければstudyをdetailsに表示する
                    self.visible.STUDY_top = true;
                    self.visible.study = false;
                }

                <!--
                if(self.visible.SUBMISSION) {
                    self.visible.STUDY_top = false;
                    self.visible.STUDY = true;
                }else{
                    self.visible.STUDY_top = true;
                    self.visible.STUDY = false;
                    self.visible.SUBMISSION = false
                }
                -->
            };
            f["bioproject"] = function () {
                self.visible.bioproject_top = true;
                self.visible.bioproject = false
            };
            f["biosample"] = function () {
                self.visible.EXPERIMENT_RUN_top = true;
                self.visible.EXPERIMENT_RUN_top = true;
            };

            // 設定を呼ぶ
            f[db]();

            if (self.visible.EXPERIMENT || self.visible.STUDY || self.visible.RUN || self.visible.bioproject || self.visible.analysis) {
                self.visible.related = true;
            }

            if(self.visible.EXPERIMENT == true || self.visible.RUN == true)
            {
                self.visible.exp_run = true;
            }

            self.update()
        }

        function get_type(uid) {
            const T = {
                "P": "study",
                "X": "experiment",
                "S": "sample",
                "R": "run",
                "Z": "analysis",
                "A": "submission"
            };
            return T[uid];
        }


        var args = location.search;
        var props = args.slice(1).split('&');
        var targetdb = props[0].split('=')[1];
        obs.trigger("targetSelected", targetdb);

    </script>
</detail>