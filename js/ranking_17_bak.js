;(function($){
    $.fn.statistic = function(options) {
        var margin = {top: 25, bottom: 30, left: 30, right: 50}, width = 505, height = 200;
        var color = d3.scale.ordinal().range(["#EB6238", "#f6ad49", "#f8c822", "#f5e56b", "#dccb18"]);
        // スケール設定
        var x2 = d3.scale.ordinal();
        var y2 = d3.scale.linear();
        var x2Axis = d3.svg.axis();
        var y2Axis = d3.svg.axis();

        var svg_list, svg_bar1, svg_bar2, axisb, bars1, bars2, bars3, bars4;


        // 描画するDOMを設定
        var t = options.target;

        // データ読み込み
        var base_url = "http://52.193.211.138/";
        var conf = {statistic:{params: "sra/type/"},
            organism: {params: "sra/scientific_name/"},
            study_type: {params: "sra/study_type/"},
            center_name:{params: "sra/center_name/"}
        };

        var target_url = base_url + conf[t]["params"];

        d3.json(target_url, function(e, d){
            // confs

            //リスト描画領域を作成
            svg_list = d3.select("#" + t).append("svg")
                .attr("width", 505).attr("height", 115);

            //ランキング描画領域を作成
            svg_bar1 = d3.select("#" + t).append("svg")
                .attr("width", 505).attr("height", height + margin.bottom);
            svg_bar2 = d3.select("#" + t).append("svg")
                .attr("width", 505).attr("height", 17);
            axisb = svg_bar2.append("g").attr("class", "x axis")
                .attr("transform", "translate(0,2)")
                .style({"stroke-width": "2px", "fill": "none", "stroke": "Black"});//tickFormat("")を後指定するためtextは描画されない

            //チャート描画用のグループ作成
            bars1 = svg_bar1.append("g").attr("class", "bars").attr("transform", "translate(0,30)");
            bars2 = svg_bar1.append("g").attr("class", "fukidashi").attr("transform", "translate(0,1)");
            bars3 = svg_bar1.append("g").attr("class", "vals").attr("transform", "translate(0,2)");
            bars4 = svg_bar1.append("g").attr("class", "arrows").attr("transform", "translate(0,1)");


            // confs end

            // get data
            var data = d["val"];

            // parse data
            // {name: '', val: ''} のオブジェクトに変形

            // ソートして上位５項目までデータをスライス
            data = data.slice(0, 10);
            var data_f = data.map(function (x) {
                return {name: Object.keys(x)[0], val:Object.values(x)[0]}
            });

            // call draw method
            drawBar(data_f);
            drawRanking(data_f);
            show_update();
        });

        // last updateを表示
        function show_update(){
            var update_isempty = true;

            if (update_isempty) {
                // solrのlast updateを取得
                var last_updated = "";
                d3.select("#last_update .date").text(last_updated);
            }
        }

        // ランキングを表示
        function drawRanking(d) {
            list = svg_list.selectAll(".lists")
                .data(d)
                .enter()
                .append("g")
                .attr("transform", "translate(0, 10)")
                .attr("font-size", 14)
                .attr("fill", "#444444")
                .attr("class", "lists")
                .on("click", function (d) {
                    showList(d.name)
                });

            //ランキング表の背景画像をまず作る
            list.append("rect");

            list.append("text")
                .attr("y", function (d, i) {
                    return i * 22 + 4
                })
                .attr("x", 25)
                .text(function (d, i) {
                    if (i < 5) {
                        return d.name
                    }
                    ;
                })
                .attr("fill", "#444444")
                //背景の矩形のプロパティを取得
                .each(function (d) {
                    var bbox = this.getBBox();
                    d.width = bbox.width;
                    d.height = bbox.height;
                    d.y = bbox.y;
                    d.x = bbox.x;
                });

            //ランキング表の背景画像のプロパティを変更
            list.select("rect")
                .attr({
                    width: function (d) {
                        return 14
                    },
                    height: function (d) {
                        return d.height;
                    },
                    fill: function (d, i) {
                        return color(i)
                    },
                    x: function (d) {
                        return d.x - 25
                    },
                    y: function (d) {
                        return d.y
                    }
                });

        }


        // barchartを表示
        function drawBar(datas) {
            var names = datas.map(function (d) {
                return d.name
            });
            var values = datas.map(function (d) {
                return +d.val
            });
            x2.rangeBands([0, width]).domain(names);
            y2.range([height, 0]).domain([0, d3.max(values)]);

            //軸をcall
            axisb.call(x2Axis.scale(x2).tickFormat(""));


            //矩形の描画
            bars1.selectAll("g").data(datas).enter().append("g").append("rect");
            bars1.selectAll("g").data(datas).exit().remove();
            bars1.selectAll("rect").data(datas)
                .attr("x", function (d, i) {
                    return (i * x2.rangeBand())
                })
                .attr("y", function (d) {
                    return y2(+d.val)
                })
                .attr("width", x2.rangeBand())
                .attr("height", function (d) {
                    return height - y2(+d.val)
                })
                .attr("fill", function (d, i) {
                    return color(i);
                })
                .attr({"stroke-width": 2, "stroke": "#ffffff", "cursor": "pointer"})
                .attr("class", function (d, i) {
                    return "rect_o" + i
                })
                .on("click", function (d) {
                    var type = $(this).parents()[3].id
                    showList({key: type, value: d.name})
                });

            //吹き出し部分の矩形描画
            bars2.selectAll("g").data(datas).enter().append("g").append("rect");
            bars2.selectAll("g").data(datas).exit().remove();
            bars2.selectAll("rect").data(datas)
                .attr("x", function (d, i) {
                    return (i * x2.rangeBand() + 2)
                })
                .attr("y", function (d) {
                    return y2(d.val)
                })
                .attr("fill", function (d, i) {
                    return color(i)
                })
                .attr({
                    "rx": 3,
                    "ry": 3,
                    "stroke": "#696969",
                    "stroke-width": 2,
                    "fill-opacity": "0.25",
                    "cursor": "pointer"
                })
                .attr("width", x2.rangeBand() - 4)
                .attr("height", 15)
                .on("click", function (d) {
                    showList(d.name)
                });

            //吹き出し内のテキストを描画
            bars3.selectAll("g").data(datas).enter().append("g").append("text");
            bars3.selectAll("g").data(datas).exit().remove();
            bars3.selectAll("text").data(datas)
                .attr("x", function (d, i) {
                    return (i * x2.rangeBand() + (x2.rangeBand()) / 2)
                })
                .attr("y", function (d) {
                    return y2(d.val) + 10
                })
                .attr({"fill": "#696969", "font-size": "12px", "cursor": "pointer"})
                .text(function (d) {
                    return parseInt(d.val)
                })
                .attr("text-anchor", "middle")
                .on("click", function (d) {
                    showList(d.name)
                });

            //吹き出しの足を描画
            bars4.selectAll("g").data(datas).enter().append("g").append("text");
            bars4.selectAll("g").data(datas).exit().remove();
            bars4.selectAll("text").data(values)
                .attr("x", function (d, i) {
                    return (i * x2.rangeBand() + (x2.rangeBand()) / 2)
                })
                .attr("y", function (d) {
                    return y2(d) + 25
                })
                .attr("fill", "#696969")
                .text("▼")
                .attr("text-anchor", "middle");
        }

        //transition().duration()を設定するとon("click",,)がエラーになるため、再描画するオブジェクトでないものにイベントをわりあてる
        $("#col2_form input:text").on("keypress keyup change", function (e) {
            var query_text = $("#col1_form input:text").val();
            if (e.keyCode == 46 || e.keyCode == 8) { //BackspaceやDeltekeyが入力された場合
                if (query_text == "") {
                    //検索文字がnullとなった場合ランキングチャートを表示する
                    //drawBar(dimensionb);
                    //drawRanking(dimensionb)
                    showAlert()
                } else {
                    d3.json("projects?dimension=organism&query_text=" + query_text, function (error, data) {
                        //文字が入力されている場合jsonを再取得し検索結果によるグラフを表示する
                        //drawBar(data);
                        //drawRanking(data);
                        showAlert();
                    })
                }
            } else if (query_text != "") {
                //通常に文字が入力されたケースの挙動。jsonを新しい条件で再取得。ただし↑など文字はフィルタすべき。
                d3.json("projects?dimension=organism&query_text=" + query_text, function (error, data) {
                    //drawBar(data);
                    //drawRanking(data);
                    showAlert()
                })
            }
        });

        //
        function showList(q) {
            if (q != "total") {
                //console.log(window.location.pathname);
                // key: valueを渡す
                var k = q["key"];
                var v = q["value"];
                window.location.href = "result.html?" + k + "=" + v;
            }
        }

    }
})(jQuery);