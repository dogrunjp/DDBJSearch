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

    <div class="chart">
        <div style="width:100%; height: 600px;" id='graph'></div>
    </div>

    <script>
        var self = this;
        var vals = [],acc, api, nfounds, parent_table, child_table, taxonomy, name;
        var taxonomy_base = conf.api_base + "/taxonomyid/";
        var exp_taxonomy_base = conf.api_base + "/exp_taxonomy/";
        var scientific_name_base = conf.api_base + "/scientific_name/"


        // tableを描画
        var table_columns = [
            {title:"Taxonomy ID", field:"taxid", width:"15%", cellClick:function(e, cell){ if(cell.getValue() != "NA") {window.open("http://sra.dbcls.jp/result.html?target_db=biosample&taxonomy_id=" + cell.getValue())}}},
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
                        elm.style.visibility = "visible";
                        self.update()
                        return d
                    }).then(function(d){
                        // showTreeにorganism nameを渡す
                        root_node = d.parent[0].label
                        showTree(root_node)
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
                        elm.style.visibility = "visible";
                        self.update()
                        showTree(name)
                        
                    })

            }

            // parentの情報



      }


        formrst()
        {
            document.queryform.reset()
        }

        // taxonomy tree描画
        let result = {
            "head": {
                "link": [],
                "vars": [
                "root_name",
                "parent_name",
                "child_name"
                ]
            },
            "results": {
                "distinct": false,
                "ordered": true,
                "bindings": [
                {
                    "root_name": {
                    "type": "literal",
                    "value": "Homo"
                    },
                    "parent_name": {
                    "type": "literal",
                    "value": "Homo"
                    },
                    "child_name": {
                    "type": "literal",
                    "value": "Homo heidelbergensis"
                    }
                },
                {
                    "root_name": {
                    "type": "literal",
                    "value": "Homo"
                    },
                    "parent_name": {
                    "type": "literal",
                    "value": "Homo"
                    },
                    "child_name": {
                    "type": "literal",
                    "value": "Homo sapiens"
                    }
                },
                {
                    "root_name": {
                    "type": "literal",
                    "value": "Homo"
                    },
                    "parent_name": {
                    "type": "literal",
                    "value": "Homo"
                    },
                    "child_name": {
                    "type": "literal",
                    "value": "environmental samples"
                    }
                },
                {
                    "root_name": {
                    "type": "literal",
                    "value": "Homo"
                    },
                    "parent_name": {
                    "type": "literal",
                    "value": "Homo sapiens"
                    },
                    "child_name": {
                    "type": "literal",
                    "value": "Homo sapiens neanderthalensis"
                    }
                },
                {
                    "root_name": {
                    "type": "literal",
                    "value": "Homo"
                    },
                    "parent_name": {
                    "type": "literal",
                    "value": "Homo sapiens"
                    },
                    "child_name": {
                    "type": "literal",
                    "value": "Homo sapiens subsp. 'Denisova'"
                    }
                },
                {
                    "root_name": {
                    "type": "literal",
                    "value": "Homo"
                    },
                    "parent_name": {
                    "type": "literal",
                    "value": "environmental samples"
                    },
                    "child_name": {
                    "type": "literal",
                    "value": "Homo sapiens environmental sample"
                    }
                }
                ]
            }
        };

        let taxonomy_api = "http://togostanza.org/sparqlist/api/d3sparql_dendrogram?organism="
        let organism = ""

        let pg_json;
        function unique_name(value, index, self){
            return self.indexOf(value) === index
        }

        let nodeIdSet = new Set();
        let pg = {nodes: [], edges: []};
        let edgeSet = new Set();
        for (let binding of result.results.bindings) {
        nodeIdSet.add(binding.parent_name.value);
        nodeIdSet.add(binding.child_name.value);
        pg.edges.push({from: binding.parent_name.value, to: binding.child_name.value, properties: {}, labels: []});
        }

        for (let nodeId of nodeIdSet) {
        pg.nodes.push({id: nodeId, properties: {}, labels: []});
        }


        let helloGraph;
        function showTree(d) {
            
            let container = document.getElementById('graph');
            helloGraph = new Blitzboard(container);
            let ncbi_taxonomy = "https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?name="

            let config =
            {
                // nodeとedgeを埋め込む
            
            node: {
                caption: ['id'],
                icon: {
                icon: 'f1fd',
                graph: 'f341',
                },
                onClick: (node) => {
                    window.open(ncbi_taxonomy + node.id, '_blank');
                },
                saturation: '100%',
                brightness: '37%',
            },
            edge: {
                caption: ['label', 'date'],
                length: {
                distance: 'value',
                },
                width: {
                flow: 'throughput',
                },
                saturation: '0%',
                brightness: '50%',
            },
              zoom: {
                    max: 3.0,
                    min: 0.25,
                },


            layout: 'hierarchical',
            layoutSettings: {
                enabled: true,
                levelSeparation: 250,
                nodeSpacing: 50,
                treeSpacing: 200,
                blockShifting: true,
                edgeMinimization: true,
                parentCentralization: true,
                direction: 'LR',        // UD, DU, LR, RL
                sortMethod: 'directed',  // hubsize, directed
                shakeTowards: 'leaves'  // roots, leaves
            },
            /*  layout: 'custom',
                layoutSettings: {
                x: 'x',
                y: 'y'
                },*/
            }

            // taxonomy treeを取得し、config.node, config.edgeをアプデート
            let url = taxonomy_api + d
        
            fetch(url)
            .then(res => {
                if (res.ok){
                    return res.json();
                } else {
                    return Promise.reject(new Error('Error!'))
                }
            })
            .then(result => {
                let nodeIdSet = new Set();
                let pg = {nodes: [], edges: []};
                let edgeSet = new Set();
                for (let binding of result.results.bindings) {
                nodeIdSet.add(binding.parent_name.value);
                nodeIdSet.add(binding.child_name.value);
                pg.edges.push({from: binding.parent_name.value, to: binding.child_name.value, properties: {}, labels: []});
                }

                for (let nodeId of nodeIdSet) {
                pg.nodes.push({id: nodeId, properties: {}, labels: ["icon"]});
                }
                
                helloGraph.updateGraph(pg, config);
                let chart_content = document.getElementById("rslt_content");
                chart_content.style.display = "inline";
            })
            

            
        };

    </script>

</taxonomy-table>