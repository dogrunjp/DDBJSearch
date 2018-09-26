<result-table>
    <h3>Search Results for {query_params}, {founds} {target} <span show='{visible_sra}'>(total {total} sra entries)</span><!-- ex. --></h3>
    <div id="rslt-table"></div>

    <div id="data-container"></div>

    <script type="text/javascript">

        var self = this;
        var base_url = conf.api_search_base_url;
        var nfounds;
        var arg = {};
        var q =location.search.substring(1).split('&');
        for(var i=0;q[i];i++) {
            var kv = q[i].split('=');
            arg[kv[0]]=kv[1];
        };
        var search_ops = ["target_db", "rows", "sort"];
        var search_option = [];
        var search_keys = [];
        var targetdb = arg["target_db"];
        var rows = arg["rows"] ? arg["rows"] : 20;
        var sort = arg["sort"] ? arg["sort"] + "%20desc" : "uid%20desc";
        this.founds = "";

        obs.trigger("targetSelected", targetdb);

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

        var q = base_url + "target_db="+ targetdb + "&" + search_keys.join('&') + "&rows=" + rows + "&sort=" + sort;
        //var q = base_url + "target_db="+ targetdb + "&" + search_keys.join('&') + "&sort=" + sort;

        var table_conf = {
            sra:{
                columns:[
                    {title:"ACCESSION", field:"uid", width:110},
                    {title:"TITLE", field:"study_title", minWidth: 350, width: "50%", align:"left"},
                    {title:"ABSTRACT", field:"abstract", width: "20%"},
                    {title:"STUDY_TYPE", field: "study_type", width: "20%"}
                ]},
            bioproject:{
                columns:[
                    {title:"BioProject", field:"uid", width:100},
                    {title:"TITLE", field:"title", width: 300, align:"left", headerSort:false},
                    {title:"ORGANISM NAME", field:"organism_name", width: 160, sorter:"string"},
                    {title:"ORGANIZATION NAME", field:"organization_name", width: 160, sorter:"string"},
                    {title:"PROJECT DATATYPE", field:"project_datatype", width: 150, sorter:"string"},
                    {title:"SUBMISSION DATE", field: "submitted", sorterParams:{format:"DD-MM-YYThh:mm:ssZ"}}
                ]},
            biosample:{
                columns:[
                    {title:"BioSample", field:"uid", width:120},
                    {title:"TITLE", field:"title", width: 340, align:"left", sorter:"string"},
                    {title:"TAXONOMY NAME", field:"taxonomy_name", width: 180, sorter:"string"},
                    {title:"TAXONOMY ID", field:"taxonomy_id", width: 120, sorter:"number"},
                    {title:"PACKAGE", field:"package", width: 110, sorter:"string"},
                    {title:"SUBMISSION DATE", field: "submission_date", sorter:"date", sorterParams:{format:"DD-MM-YY"}}
                ]
            }
        };

        this.on("mount", function(){
            self.visible_sra = targetdb == "sra" ? true: false;
            $("#rslt-table").tabulator({
                pagination:"remote",
                ajaxURL: q,
                timeout: 5000,
                paginationSize: rows,
                columns:table_conf[targetdb]["columns"],
                dataLoaded: function (datas) {
                    nfounds = datas["numFound"] ? datas["numFound"]: nfounds;
                    ttl = datas["total"] ? datas["total"]: ttl;
                    console.log(ttl)
                    self.founds = nfounds ? nfounds: 0;
                    self.total = ttl ? ttl: 0;
                    self.target = targetdb == "sra" ?  "Study entries": targetdb + " entries";
                    self.query_params = Object.keys(arg) + ": " +decodeURI(Object.values(arg));
                    self.update();
                },
                placeholder: "No Data Available",
                rowClick:function(e, row){
                  const accession = row.row.data.uid;
                  window.open("details.html?db=" + targetdb + "&accession=" + accession)
                }

            });
            $("#rslt-table").tabulator("setFilter", "numFound", "==", 0);
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

        //pagenation
        function showPasger() {
            var pg_total = Math.ceil(self.founds / rows)
            self.page_head = 1;
            self.page_prev
            self.page_current
            self.page_next
            self.page_end = pg_total;
        }

        //-->
    </script>

</result-table>