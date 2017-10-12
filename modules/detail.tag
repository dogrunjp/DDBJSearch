<detail>
    <div class="details">
        <div class="flex-row"> <h2> {accession}</h2> <span class="header-element"> <a href="#"><i class="fa fa-cloud-download" aria-hidden="true"></i> FTP</a> </span></div>
        <table>
            <thead><tr class="table-header"><th colspan="2">Project Detail</th></tr></thead>

            <tbody>
                <tr><td width="180" class="atrb">Title</td><td>{title}</td></tr>
                <tr><td width="180" class="atrb">Description</td><td>{description}</td></tr>
                <tr><td width="180" class="atrb">Organism name</td><td>{organism_name}</td></tr>
                <tr><td width="180" class="atrb">Tax id</td><td>{ tax_id }</td></tr>
                <tr><td width="180" class="atrb">Archive</td><td>{ archive }</td></tr>
                <tr><td width="180" class="atrb">LocusTagPrefix</td><td> { locus_tag_prefix }</td></tr>
                <tr><td width="180" class="atrb">Organization name</td><td>{ organization}</td></tr>
                <tr><td width="180" class="atrb">Submitted</td><td>{ submitted }</td></tr>
                <tr><td width="180" class="atrb">DataType</td><td>{ prject_datatype }</td></tr>
            </tbody>
        </table>
    </div>
    <script type="text/javascript">
        var self = this;
        var arg = {};
        var q =location.search.substring(1).split('&');
        for(var i=0;q[i];i++) {
            var kv = q[i].split('=');
            arg[kv[0]]=kv[1];
        }
        var k = Object.keys(arg);
        var v = Object.values(arg);
        this.accession = v;

        function get_data(x) {
            return $.getJSON('http://52.193.211.138/bioproject/' + x)
        }

        get_data(v)
            .done(function(d){
                var obj = {
                    accession : d["Package"]["Project"]["Project"]["ProjectID"]["ArchiveID"]["@accession"],
                    title : d["Package"]["Project"]["Project"]["ProjectDescr"]["Title"],
                    description : d["Package"]["Project"]["Project"]["ProjectDescr"]["Description"],
                    organization : get_name(d["Package"]["Project"]["Submission"]["Description"]["Organization"]),
                    submitted : d["Package"]["Project"]["Submission"]["@submitted"],
                    organism: d["Package"]["Project"]["Project"]["ProjectType"]["ProjectTypeSubmission"]["Target"]["Organism"],
                    organism_name: d["Package"]["Project"]["Project"]["ProjectType"]["ProjectTypeSubmission"]["Target"]["Organism"]["OrganismName"],
                    archive: d["Package"]["Project"]["Project"]["ProjectID"]["ArchiveID"]["@archive"],
                    locus_tag_prefix: d["Package"]["Project"]["Project"]["ProjectDescr"]["LocusTagPrefix"],
                    project_datatype: d["Package"]["Project"]["Project"]["ProjectType"]["ProjectTypeSubmission"]["ProjectDataTypeSet"]["DataType"]
                };

                self.title = obj.title;
                self.description = obj.description;
                self.organism_name = obj.organism_name;
                self.tax_id = defaultJson(obj.organism, "@taxID");
                self.archive = obj.archive;
                self.locus_tag_prefix = defaultJson(obj.locus_tag_prefix, "#text");
                self.organization = obj.organization;
                self.submitted = obj.submitted;
                self.prject_datatype = obj.project_datatype;

                self.update();

                function get_name(v) {
                    if (is_array(v)){
                        var elem = v.filter(function (obj) {return (obj["@role"] == "owner")})[0];
                        if (is_string(elem)){
                            return elem["Name"]
                        }else{
                            return elem["Name"]["@abbr"]
                        }
                    }else{
                        if(is_string(v)){
                            return v["Name"]
                        }else{
                            return v["Name"]["@abbr"]
                        }
                    }
                }

                function is_array(v){
                    var res = v instanceof Array;
                    return res
                }

                function is_string(v){
                    var res = typeof v["Name"] == 'string';
                    return res
                }

                function defaultJson(obj, k) {
                    try{
                        return obj[k]
                    }
                    catch (e){
                        return obj
                    }
                }

            })





    </script>
</detail>