<publication-table>
    <form id="queryform" name="queryform">
        <div id="input_accession">
            <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="term">Article Title :</label></span>
            <input type="text" id="article_title" class="input-box1" name="article_title" size="50" value="" />
        </div>

        <div id="input_keyword">
            <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="uid">Journal :</label></span>
            <input type="text" class="input-box1" id="journal" name="journal" size="50" value="" />
        </div>

        <div id="input_pmid">
            <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="uid">BioProject Title :</label></span>
            <input type="text" class="input-box1" id="bp_title" name="bp_title" size="50" value="" />
        </div>

        <div id="input_articlt_title">
            <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="uid">Year :</label></span>
            <input type="text" class="input-box1" id="year" name="year" size="50" value=""/>
        </div>


        <div>
            <label for="view_count">Show
                <select id="view_count" class="select-box1" name="rows">
                    <option value="25">25</option>
                    <option value="50">50</option>
                    <option value="100">100</option>
                </select>
                records
            </label>

            <label for="sra_sort_key">Sort by
                <select id="sra_sort_key" class="select-box1" name="sort">
                    <option value="bioproject" selected>BioProject</option>
                    <option value="pmid" selected>PMID</option>
                    <option value="journal">Journal</option>
                    <option value="year">Year</option>
                </select>
            </label>



            <input type="button" id="search" class="input-box1" value="Search" onclick={keywordsearch} />
            <input type="button" id="clear" class="input-box1" value="Clear" onclick={formrst} />
        </div>
    </form>

    <h3 class="rslt">Search Results for {query_params} - {founds} {target} <!-- ex. --></h3>
    <div id="rslt_table"></div>

    <script>
        var vals = [],acc, api, nfounds, table;
        var base_url = conf.api_base + "/publication/search";


        // tableを描画
        var table_columns = [
            {title:"BioProject", field:"BioProject", width:120, cellClick:function(e, cell){ if(cell.getValue() != "NA") {window.open("http://sra.dbcls.jp/details.html?db=bioproject&accession=" + cell.getValue())}}},
            {title:"Title", field:"Title", minWidth: 300, width: "25%"},
            {title:"PMID", field:"PMID", width: 100, cellClick:function(e, cell){ if(cell.getValue() != "NA") {window.open("https://pubmed.ncbi.nlm.nih.gov/" + cell.getValue())}}},
            {title:"Journal", field: "Journal", width: 150},
            {title:"ArticleTitle", field: "ArticleTitle", width:"25%"},
            {title:"Year", field:"Year", width:80 }
        ];

        this.on("mount", function () {
            table  = new Tabulator("#rslt_table", {
                layout: 'fitColumns',
                columns: table_columns,
                placeholder: "No Data Available",
                rowClick: function (e, row) {
                    var accession = row.row.data._id;
                    var study = row.row.data.study;
                    window.open("details.html?db=" + targetdb + "&accession=" + accession + "&_id=" + study)

                }
            });

        });


        keywordsearch()
        {
            // 検索URL生成
            var forms = document.getElementById('queryform').elements;

            // formをk:vにパースしarray valsに追加する
            $.each(forms, function (i, x) {
                var k = x.name;
                var v = x.value;
                //var types = x.dataset.type;

                // valueが空で無いformのオブジェクトを取得する
                if (["", "Search", "Clear"].indexOf(v) == -1) {
                    var obj = [k, v];
                    // accessionが入力された場合のみaccに値を入れる
                    if (obj[0] === "uid"){
                        acc = obj;
                    }
                    vals.push(obj);
                }
            });

            var types = [];
            var q = vals.map(function(l){
                var s = l[0] + "=" +l[1];
                // 入力されたdata_typeを取得
                t = types.push($("#"+l[0]).data('type'));
                return s
            });
            var t = types.filter(function(s){
                if(s != undefined) {
                    q.push("data_type=" + s)
                }
            });

            api = base_url + "?" + q.join('&');

            fetch(api)
                .then(function(r){
                    return r.json();
                })
                .then(function(d){
                    table.setData(d["data"])
                })

        }





        formrst()
        {
            document.queryform.reset()
        }

    </script>



</publication-table>