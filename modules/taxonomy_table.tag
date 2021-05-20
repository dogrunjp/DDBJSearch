<taxonomy-table>
    <form id="queryform" name="queryform">
        <div class="flex-row">
            <div id="input_accession" class="flex-item">
                <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="taxonomy_id">Taxonomy ID :</label></span>
                <input type="text" id="taxonomy_id" class="input-box1" name="taxonomy_id" size="20" value="" />
            </div>

            <div class="flex-item"> OR </div>

            <div id="input_keyword">
                <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="scientific_name">Scientific Name :</label></span>
                <input type="text" class="input-box1" id="scientific_name" name="scientific_name" size="20" value="" />
            </div>
        </div>

        <div class="flex-item">
            <!--
            <label for="view_count">Show
                <select id="view_count" class="select-box1" name="rows">
                    <option value="25">25</option>
                    <option value="50">50</option>
                    <option value="100">100</option>
                </select>
                records
            </label>
            -->

            <label for="sra_sort_key">Sort by
                <select id="sra_sort_key" class="select-box1" name="sort">
                    <option value="scientificname" selected>ScientificName</option>
                    <option value="taxonomyid" selected>TaxonomyID</option>
                </select>
            </label>

            <input type="button" id="search" class="input-box1" value="Search" onclick={keywordsearch} />
            <input type="button" id="clear" class="input-box1" value="Clear" onclick={formrst} />
        </div>
    </form>

    <div id="rslt_content">
        <h3 class="rslt">Search Results for {query_params} - total {founds} entries<!-- ex. --></h3>
        <div >
            Terms: {taxonomy}  {name}
            <a class="btn btn-link" href="./result.html?target_db=biosample&taxonomy_id={ids}">
                <i class="fa fa-external-link"></i> Show all Taxonomies
            </a>
        </div>
        <h4 class="rslt">Parent</h4>
        <div id="p_table"></div>
        <h4 class="rslt">Children</h4>
        <div id="c_table"></div>
    </div>

    <script>
        var self = this;
        var vals = [],acc, api, nfounds, parent_table, child_table, taxonomy, name;
        var taxonomy_base = conf.api_base + "/taxonomyid/";
        var exp_taxonomy_base = conf.api_base + "/exp_taxonomy/";
        var scientific_name_base = conf.api_base + "/scientific_name/"


        // tableを描画
        var table_columns = [
            {title:"Taxonomy ID", field:"taxid", width:"15%", cellClick:function(e, cell){ if(cell.getValue() != "NA") {window.open("http://sra.dbcls.jp/details.html?db=bioproject&accession=" + cell.getValue())}}},
            {title:"Scientific Name", field:"label", minWidth: 300, width: "85%"},
        ];

        this.on("mount", function () {
            parent_table  = new Tabulator("#p_table", {
                layout: 'fitColumns',
                columns: table_columns,
                placeholder: "No Data Available",
                rowClick: function (e, row) {
                    var taxid = row.row.data.taxid;
                    // 複数のidが結果に含まれるケースではカンマ区切りの文字列として検索クエリを扱う

                    // BioSample検索
                    window.open("result.html?db=biosample" + targetdb + "&taxonomy_id=" + taxid)

                }
            });

            child_table = new Tabulator("#c_table", {
                layout: 'fitColumns',
                columns: table_columns,
                placeholder: "No Data Available",
                rowClick: function (e, row) {
                    var taxid = row.row.data.taxid;
                    // 複数のidが結果に含まれるケースではカンマ区切りの文字列として検索クエリを扱う

                    // BioSample検索
                    window.open("result.html?db=biosample" + targetdb + "&taxonomy_id=" + taxid)

                }
            });
        });

        keywordsearch()
        {
            // 検索URL生成
            var forms = document.getElementById('queryform').elements;
            

            // 入力されたフォームごと処理を分岐する
            // Taxonomy IDが入力されていた場合
            // scientific name取得　& 親・同レベルのtax,name取得
            if (forms.taxonomy_id.value){
                // Taxonomy IDが入力されていた場合
                taxonomy = forms.taxonomy_id.value;

                var api_p = scientific_name_base + "/" + taxonomy
                api = exp_taxonomy_base + "/" + taxonomy;
                fetch(api_p)
                    .then(function(r){
                        return r.json();
                    })
                    .then(function (d) {
                        self.taxonomy = taxonomy;
                        self.name = d["scientific_name"];
                        self.update()
                    });

                fetch(api)
                    .then(function(r){
                        return r.json();
                    })
                    .then(function(d){
                        // パース
                        child_table.setData(d["child"]);
                        parent_table.setData(d["parent"]);
                        self.founds = d["numfound"];
                        // 検索語を表示する
                        // {query_params} - {founds} {target}
                        //
                        var elm = document.getElementById("rslt_content");
                        elm.style.height = '300px';
                        elm.style.opacity = 1;
                        elm.style.visibility = visible;
                        self.update()
                    });


            }else if(forms.scientific_name.value){
                // Scientific nameが入力された場合taxonomy idを取得
                name = forms.scientific_name.value;
                api = taxonomy_base + name;
                fetch(api)
                    .then(function(r){
                        return r.json();
                    }).then(function(d){
                        // レスポンスをパースしtaxonomy idを文字列として取得
                        taxonomy = d["taxonomy_id"].split("/").slice(-1);
                        api = exp_taxonomy_base + taxonomy;
                        return fetch(api)
                    }).then(function(r){
                        return r.json()
                    }).then(function (d) {
                        self.taxonomy = taxonomy;
                        self.name = name;
                        child_table.setData(d["child"]);
                        parent_table.setData(d["parent"]);
                        var elm = document.getElementById("rslt_content");
                        elm.style.height = '300px';
                        elm.style.opacity = 1;
                        elm.style.visibility = visible;
                        self.update()
                })

            }

            // parentの情報



      }


        formrst()
        {
            document.queryform.reset()
        }


    </script>



</taxonomy-table>