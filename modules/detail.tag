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
            <tr if={prject_datatype}><td width="180" class="atrb">DataType</td><td>{ prject_datatype }</td></tr>
            </tbody>
        </table>

        <table show="{visible.STUDY_top}">
            <thead><tr class="table-header"><th colspan="2">STUDY</th></tr></thead>
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

        <div show="{visible.EXPERIMENT_RUN_top}">
            <table>
                <thead>
                <tr class="table-header">
                    <th width="110">EXPERIMENT & RUN</th>
                    <th class="toggle-icon"><a role="button" data-toggle="collapse" data-parent="#accordion" href="#er_table_m" aria-expanded="true" aria-controls="er_table_m">
                        <i class="fa fa-caret-square-o-up" aria-hidden="true"></i></a></th>
                </tr>
                </thead>
            </table>

            <div show="{visible.EXPERIMENT_RUN_top}" id="er_table" class="panel-collapse in" role="tabpanel" aria-labelledby="run_table">
                <table each={er_item in er_items} if={er_item.EXPERIMENT.uid==accession || er_item.RUN.uid==accession}>
                    <tbody>
                    <tr class="sub-header"><th colspan="2">EXPERIMENT: {er_item.EXPERIMENT.uid}</th></tr>
                    <tr if={er_item.EXPERIMENT.title}><td width="180" class="atrb">Title</td><td>{er_item.EXPERIMENT.title}</td></tr>
                    <tr if={er_item.EXPERIMENTcenter_name}><td width="180" class="atrb">Center Name</td><td>{er_item.EXPERIMENT.center_name}</td></tr>
                    <tr if={er_item.EXPERIMENT.design_description}><td width="180" class="atrb">Design Description</td><td>{er_item.EXPERIMENT.design_description}</td></tr>
                    <tr if={er_item.EXPERIMENT.library_layout}><td width="180" class="atrb">Library Layout</td><td>{er_item.EXPERIMENT.library_layout}</td></tr>
                    <tr if={er_item.EXPERIMENT.library_name}><td width="180" class="atrb">Library Name</td><td>{er_item.EXPERIMENT.library_name}</td></tr>
                    <tr if={er_item.EXPERIMENT.program}><td width="180" class="atrb">Program</td><td>{er_item.EXPERIMENT.program}</td></tr>
                    <tr if={er_item.EXPERIMENT.platform}><td width="180" class="atrb">Platform</td><td>{er_item.EXPERIMENT.platform}</td></tr>
                    <tr if={er_item.EXPERIMENTprotocol}><td width="180" class="atrb">Protocol</td><td>{er_item.EXPERIMENTprotocol}</td></tr>
                    <tr if={er_item.EXPERIMENT.instrument_model}><td width="180" class="atrb">Instrument Model</td><td>{er_item.EXPERIMENT.instrument_model}</td></tr>

                    <tr class="sub-header">
                        <th>RUN: {er_item.RUN.uid}</th>
                        <th>
                            <span if={er_item.RUN.sra_path} class="file_path"><a href={er_item.RUN.sra_path}><i class="fa fa-cloud-download" aria-hidden="true"></i> sra</a></span>
                            <span if={er_item.RUN.fastq_path} class="file_path"><a href={base_file_path}{er_item.RUN.fastq_path}><i class="fa fa-cloud-download" aria-hidden="true"></i> fastq</a></span>
                        </th>
                    </tr>

                    <tr if={er_item.BioSample.uid} class="sub-header"><th colspan="2">BioSample: {er_item.BioSample.uid}</th></tr>
                    <tr if={er_item.BioSample.title}><td width="180" class="atrb">Title</td><td>{er_item.BioSample.title}</td></tr>
                    <tr if={er_item.BioSample.taxonomy_id}><td width="180" class="atrb">Taxonomy ID</td><td>{er_item.BioSample.taxonomy_id}</td></tr>
                    <tr if={er_item.BioSample.taxonomy_name}><td width="180" class="atrb">Taxonomy Name</td><td>{er_item.BioSample.taxonomy_name}</td></tr>
                    <tr if={er_item.BioSample.package}><td width="180" class="atrb">Package</td><td>{er_item.BioSample.package}</td></tr>
                    <tr if={er_item.BioSample.env_package}><td width="180" class="atrb">Env Package</td><td>{er_item.BioSample.env_package}</td></tr>
                    <tr if={er_item.BioSample.attributes} ><td colspan="2" class="atrb">Attributes</td></tr>
                    <tr each={attribute in er_item.BioSample.attributes || []}><td>{Object.keys(attribute).toString()}</td><td>{Object.values(attribute).toString()}</td></tr>

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


        <table show="{visible.biosample_top}">
            <thead>
            <tr class="table-header">
                <th width="110">BioSample</th>
                <th class="toggle-icon"><a role="button" data-toggle="collapse" data-parent="#accordion" href="#bs_table" aria-expanded="true" aria-controls="bs_table"><i class="fa fa-caret-square-o-up" aria-hidden="true"></i></a></th>
            </tr>
            </thead>
        </table>
        <div id="bs_table" class="panel-collapse in" role="tabpanel" aria-labelledby="bs_table">
            <table show="{visible.biosample_top}" >
                <tbody each={bs_item in bs_items}   if={bs_item.uid==accession}>
                <tr class="sub-header"><th colspan="2">{bs_item.uid}</th></tr>
                <tr if={bs_item.title}><td width="180" class="atrb">Title</td><td>{bs_item.title}</td></tr>
                <tr if={bs_item.taxonomy_id}><td width="180" class="atrb">Taxonomy ID</td><td>{bs_item.taxonomy_id}</td></tr>
                <tr if={bs_item.taxonomy_name}><td width="180" class="atrb">Taxonomy Name</td><td>{bs_item.taxonomy_name}</td></tr>
                <tr if={bs_item.package}><td width="180" class="atrb">Package</td><td>{bs_item.package}</td></tr>
                <tr if={bs_item.env_package}><td width="180" class="atrb">Env Package</td><td>{bs_item.env_package}</td></tr>
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


        <table show="{visible.bioproject}">
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
            <tr if={prject_datatype}><td width="180" class="atrb">DataType</td><td>{ prject_datatype }</td></tr>
            </tbody>
        </table>

        <table show="{visible.STUDY}">
            <thead><tr class="table-header"><th colspan="2">STUDY</th></tr></thead>
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

        <div id="experiment_run" show="{visible.EXPERIMENT_RUN}">
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
                <table each={er_item in er_items}  if={er_item.EXPERIMENT.uid != accession & er_item.RUN.uid != accession}>
                    <tbody>
                    <tr class="sub-header"><th colspan="2">EXPERIMENT: {er_item.EXPERIMENT.uid}</th></tr>
                    <tr if={er_item.EXPERIMENT.title}><td width="180" class="atrb">Title</td><td>{er_item.EXPERIMENT.title}</td></tr>
                    <tr if={er_item.EXPERIMENTcenter_name}><td width="180" class="atrb">Center Name</td><td>{er_item.EXPERIMENT.center_name}</td></tr>
                    <tr if={er_item.EXPERIMENT.design_description}><td width="180" class="atrb">Design Description</td><td>{er_item.EXPERIMENT.design_description}</td></tr>
                    <tr if={er_item.EXPERIMENT.library_layout}><td width="180" class="atrb">Library Layout</td><td>{er_item.EXPERIMENT.library_layout}</td></tr>
                    <tr if={er_item.EXPERIMENT.library_name}><td width="180" class="atrb">Library Name</td><td>{er_item.EXPERIMENT.library_name}</td></tr>
                    <tr if={er_item.EXPERIMENT.program}><td width="180" class="atrb">Program</td><td>{er_item.EXPERIMENT.program}</td></tr>
                    <tr if={er_item.EXPERIMENT.platform}><td width="180" class="atrb">Platform</td><td>{er_item.EXPERIMENT.platform}</td></tr>
                    <tr if={er_item.EXPERIMENTprotocol}><td width="180" class="atrb">Protocol</td><td>{er_item.EXPERIMENTprotocol}</td></tr>
                    <tr if={er_item.EXPERIMENT.instrument_model}><td width="180" class="atrb">Instrument Model</td><td>{er_item.EXPERIMENT.instrument_model}</td></tr>

                    <tr class="sub-header">
                        <th>RUN: {er_item.RUN.uid}</th>
                        <th>
                            <span if={er_item.RUN.sra_path} class="file_path"><a href={er_item.RUN.sra_path}><i class="fa fa-cloud-download" aria-hidden="true"></i> sra</a></span>
                            <span if={er_item.RUN.fastq_path} class="file_path"><a href={base_file_path}{er_item.RUN.fastq_path}><i class="fa fa-cloud-download" aria-hidden="true"></i> fastq</a></span>
                        </th>
                    </tr>

                    <tr if={er_item.BioSample.uid} class="sub-header"><th colspan="2">BioSample: {er_item.BioSample.uid}</th></tr>
                    <tr if={er_item.BioSample.title}><td width="180" class="atrb">Title</td><td>{er_item.BioSample.title}</td></tr>
                    <tr if={er_item.BioSample.taxonomy_id}><td width="180" class="atrb">Taxonomy ID</td><td>{er_item.BioSample.taxonomy_id}</td></tr>
                    <tr if={er_item.BioSample.taxonomy_name}><td width="180" class="atrb">Taxonomy Name</td><td>{er_item.BioSample.taxonomy_name}</td></tr>
                    <tr if={er_item.BioSample.package}><td width="180" class="atrb">Package</td><td>{er_item.BioSample.package}</td></tr>
                    <tr if={er_item.BioSample.env_package}><td width="180" class="atrb">Env Package</td><td>{er_item.BioSample.env_package}</td></tr>
                    <tr if={er_item.BioSample.attributes} ><td colspan="2" class="atrb">Attributes</td></tr>
                    <tr each={attribute in er_item.BioSample.attributes || []}><td>{Object.keys(attribute).toString()}</td><td>{Object.values(attribute).toString()}</td></tr>

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

        <table show="{visible.ANALYSIS}">
            <thead>
            <tr class="table-header">
                <th width="110">ANALYSIS</th>
                <th class="toggle-icon"><a role="button" data-toggle="collapse" data-parent="#accordion" href="#ana_table" aria-expanded="true" aria-controls="ana_table"><i class="fa fa-caret-square-o-up" aria-hidden="true"></i></a></th>
            </tr>
            </thead>
        </table>
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
            EXPERIMENT_RUN: false,
            EXPERIMENT_RUN_top: false

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
        this.accession = uid;
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
                self.publication_id = bpval.get("publication_id")
                self.bp_submitted = bpval.get("submitted");


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

                self.st_items = d.STUDY;
                a2str_obj(self.st_items);
                // 取得したJSONからSTUDY[0]["uid"]を取得し、whole metadata のAPIのパラメータとする
                self.target_url = conf.api_base + "/metadata/" + self.st_items[0]["uid"];

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

                self.er_items = d.EXPERIMENT_RUN;
                a2str_obj(self.er_items)

                self.update();

            });

        function set_show(d) {
            // visible.kの値を変更しタグをupdateする
            // self.visible.bioproject = self.visible.study = self.visible.experiment = true;
            var types = Object.keys(d);
            types.forEach(function(x){
                if(d[x].length > 0){
                    self.visible[x] = true;
                    // EXPAERIMENT_RUNにexperimentとrunが内包される。
                    if(x == "EXPERIMENT_RUN"){
                        self.visible.EXPERIMENT = true;
                        self.visible.RUN = true;
                    }
                }
            });

            //dbの値に寄ってテーブルの表示順を帰る。details~, related~
            // project, study, sample をdetailsとrelatedに併記し、排他的にshow のtrue, falseを決める
            // ただし、[true, false]または[false, false]の可能性もある。
            f = {};
            f["sra"] = function () {
                // typeを取得し,x_top = trueに設定する
                if (arg.accession){
                    var T = {};
                    T = {
                        "P": function () {
                            self.visible.STUDY_top = true;
                            self.visible.STUDY = false;
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
                    self.visible.STUDY = false;
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
                self.visible.biosample_top = true;
                self.visible.biosample = true;
            };

            f[db]();

            if (self.visible.EXPERIMENT || self.visible.STUDY || self.visible.biosample || self.visible.RUN || self.visible.bioproject || self.visible.analysis) {
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