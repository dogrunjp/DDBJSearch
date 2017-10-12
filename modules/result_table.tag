<result-table>
    <h3>Search Results : {founds} {target} <!-- ex. --></h3>
    <div id="bptable"></div>
    <script type="text/javascript">
        var self = this;
        var base_url = "http://localhost:8080/search?";
        var arg = {};
        var q =location.search.substring(1).split('&');
        for(var i=0;q[i];i++) {
            var kv = q[i].split('=');
            arg[kv[0]]=kv[1];
        };
        var search_ops = ["target_db", "rows", "sort_key"];
        var search_option = [];
        var search_keys = [];
        var targetdb = arg["target_db"];
        var rows = arg["rows"] ?  arg["rows"] : 20;
        this.founds = "";

        Object.keys(arg)
            .filter((function (k) {return search_ops.indexOf(k) != -1}))
            .forEach(function (k){
                var obj = {};
                obj[k] = arg[k];
                search_option.push(obj);
            });
        // 検索optionとして設定されたキーをargより外すinplace処理
        Object.keys(arg)
            .filter(function (k) { return search_ops.indexOf(k) != -1})
            .forEach(function(k){ delete arg[k]});

        Object.keys(arg)
            .forEach(function(k){ search_keys.push(
                k + "=" + arg[k]
            )});

        var q = base_url + "target_db="+ targetdb + "&" + search_keys.join('&') + "&rows=" + rows;
        console.log(q)

        var table_conf = {
            sra:{
                columns:[
                    {title:"ACCESSION", field:"uid", width:110, cellClick:function(e, cell){ window.location.href = "detail.html?accession=" + cell.getValue()}},
                    {title:"TITLE", field:"study_title", width: 350, align:"left"},
                    {title:"ABSTRACT", field:"abstract", width: 420},
                    {title:"STUDY TYPE", field:"study_type", width: 135}
                ]},
            bioproject:{
                columns:[
                    {title:"BioProject", field:"uid", width:100, cellClick:function(e, cell){ window.location.href = "detail.html?accession=" + cell.getValue()}},
                    {title:"TITLE", field:"title", width: 300, align:"left"},
                    {title:"ORGANISM NAME", field:"organism_name", width: 160},
                    {title:"ORGANIZATION NAME", field:"organization_name", width: 160},
                    {title:"PROJECT DATATYPE", field:"project_datatype", width: 150},
                    {title:"SUBMISSION DATE", field: "submitted"}
                ]},
            biosample:{
                columns:[
                    {title:"BioSample", field:"uid", width:120, cellClick:function(e, cell){ window.location.href = "detail.html?accession=" + cell.getValue()}},
                    {title:"TITLE", field:"title", width: 340, align:"left"},
                    {title:"TAXONOMY NAME", field:"taxonomy_name", width: 180},
                    {title:"TAXONOMY ID", field:"taxonomy_id", width: 120},
                    {title:"PACKAGE", field:"package", width: 120},
                    {title:"SUBMISSION DATE", field: "submission_date"}
                ]
            }
        };

        function get_list() {
            return $.getJSON(q);
        }

        get_list()
            .done(function (datas) {
                self.founds = datas["numFound"];
                self.target = targetdb + " entries";
                self.update();
                $("#bptable").tabulator(table_conf[targetdb]);
                $("#bptable").tabulator("setData", datas["docs"]);
            });


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

        //-->
    </script>

</result-table>