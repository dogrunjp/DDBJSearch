<result-table>
    <h3>Search Results for {query_params} - {founds} {target} <!-- ex. --></h3>
    <div id="rslt-table"></div>

    <div id="data-container"></div>

    <script type="text/javascript">

        var self = this;
        //var base_url = conf.api_search_base_url;
        var base_url = conf.api_base + "/search/";
        var nfounds;
        var arg = {};
        var q =location.search.substring(1).split('&');
        for(var i=0;q[i];i++) {
            var kv = q[i].split('=');
            arg[kv[0]]=kv[1];
        };
        var search_ops = ["target_db", "rows", "sort", "order", "data_type"];
        var search_option = [];
        var search_keys = [];
        var targetdb = arg["target_db"];
        var data_type = arg["data_type"] ? arg["data_type"] : "";
        var rows = arg["rows"] ? arg["rows"] : 20;
        var sort = arg["sort"] ? arg["sort"] : "Updated";
        var order = arg["order"] ? arg["order"] : "desc";
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


        if (data_type){
            var q = base_url + targetdb + "/" + data_type + "?" + search_keys.join('&') + "&rows=" + rows + "&sort=" + sort + "&order=" + order;
        }else {
            var q = base_url + targetdb + "?" + search_keys.join('&') + "&rows=" + rows + "&sort=" + sort + "&order=" + order;
            //var q = base_url + "target_db="+ targetdb + "&" + search_keys.join('&') + "&sort=" + sort;
        }


        var table_conf = {
            sra:{
                columns:[
                    {title:"ACCESSION", field:"_id", width:100},
                    {title:"TITLE", field:"STUDY_TITLE", minWidth: 350, width: "50%", align:"left"},
                    {title:"ABSTRACT", field:"STUDY_ABSTRACT", width: "20%"},
                    {title:"STUDY_TYPE", field: "existing_study_type", width: "10%"},
                    {title:"UPDATED", field: "Updated", width:"10%"},
                    {title:"", field:"study", width:0 }
                ]},
            study:{
                columns:[
                    {title:"ACCESSION", field:"_id", width:100},
                    {title:"TITLE", field:"STUDY_TITLE", minWidth: 350, width: "50%", align:"left"},
                    {title:"ABSTRACT", field:"STUDY_ABSTRACT", width: "20%"},
                    {title:"STUDY_TYPE", field: "existing_study_type", width: "10%"},
                    {title:"UPDATED", field: "Updated", width:"10%"},
                    {title:"", field:"study", width:0 }
                ]},
            experiment: {
                columns:[
                    {title: "ACCESSION", field: "_id", width: 100},
                    {title:"TITLE", field:"TITLE", minWidth: 300, width: "40%", align:"left"},
                    {title:"INSTRUMENT MODEL", field:"INSTRUMENT_MODEL", width: "15%"},
                    {title:"LIBRARY STRATEGY", field: "LIBRARY_STRATEGY", width: "15%"},
                    {title:"LIBRARY SOURCE", field: "LIBRARY_SOURCE", width: "15%"},
                    {title:"UPDATED", field: "Updated", width:"10%"},
                    {title:"", field:"study", width:0 },
            ]},
            run:{
                columns:[
                    {title: "ACCESSION", field: "_id", width: 100},
                    {title:"TITLE", field:"TITLE", minWidth: 350, width: "50%", align:"left"},
                    {title:"CENTER NAME", field: "center_name", width: "20%"},
                    {title:"UPDATED", field: "Updated", width:"10%"},
                    {title:"", field:"study", width:0 }
                ]
            },
            sample:{
                columns:[
                    {title: "ACCESSION", field: "_id", width: 100},
                    {title: "TITLE", field:"TITLE", minWidth: 350, width: "50%", align:"left"},
                    {title: "SCIENTIFIC NAME", field: "scientific_name", width: "20%"},
                    {title: "TAXON ID", field: "taxon_id", width: "20%"},
                    {title: "UPDATED", field: "Updated", width:"10%"},
                    {title:"", field:"study", width:0 }
                ]
            },
            bioproject:{
                columns:[
                    {title:"BioProject", field:"_id", width:100},
                    {title:"TITLE", field:"Title", width: 300, align:"left", headerSort:false},
                    {title:"ORGANISM NAME", field:"OrganismName", width: 160, sorter:"string"},
                    {title:"ORGANIZATION NAME", field:"Name", width: 160, sorter:"string"},
                    {title:"PROJECT DATATYPE", field:"DataType", width: 150, sorter:"string"},
                    {title:"SUBMISSION DATE", field: "submitted", sorterParams:{format:"DD-MM-YYThh:mm:ssZ"}},
                    {title:"", field:"study", width:0 }
                ]},
            biosample:{
                columns:[
                    {title:"BioSample", field:"_id", width:120},
                    {title:"TITLE", field:"Title", width: 340, align:"left", sorter:"string"},
                    {title:"TAXONOMY NAME", field:"taxonomy_name", width: 180, sorter:"string"},
                    {title:"TAXONOMY ID", field:"taxonomy_id", width: 120, sorter:"number"},
                    {title:"PACKAGE", field:"Package", width: 110, sorter:"string"},
                    {title:"SUBMISSION DATE", field: "submission_date", sorter:"date", sorterParams:{format:"DD-MM-YY"}},
                    {title:"", field:"study", width:0 }
                ]
            }
        };

        this.on("mount", function(){
            //var target = targetdb == "sra" ? table_conf[data_type]["columns"] : table_conf[targetdb]["columns"];
            var target = data_type ? table_conf[data_type]["columns"] : table_conf[targetdb]["columns"];
            $("#rslt-table").tabulator({
                pagination:"remote",
                ajaxURL: q,
                timeout: 5000,
                paginationSize: rows,
                columns:target ,
                dataLoaded: function (datas) {
                    //self.update();
                    nfounds = datas["numfound"] ? datas["numfound"]: nfounds;
                    self.founds = nfounds ? nfounds: "No Hits";
                    self.target = nfounds ? targetdb + " entries" : "";
                    self.query_params = Object.keys(arg) + ': "' + decodeURI(Object.values(arg)) + '"';
                    self.update();

                },
                placeholder: "No Data Available",
                rowClick:function(e, row){
                  var accession = row.row.data._id;
                  var study = row.row.data.study;
                  window.open("details.html?db=" + targetdb + "&accession=" + accession + "&_id=" + study)
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