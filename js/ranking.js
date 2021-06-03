;(function($){
    $.fn.statistic = function(options) {
        var margin = {top: 25, bottom: 30, left: 30, right: 110}, width = 505, height = 220;
        //var color = d3.scale.ordinal().range(["#EB6238", "#f6ad49", "#f8c822", "#f5e56b", "#dccb18"]);
        var color = d3.scale.category10();
        // スケール設定
        var x = d3.scale.linear();
        var y = d3.scale.ordinal();

        var svg_list, svg_bar1, svg_bar2, bars1, bars2, bars3, bars4;

        // 描画するDOMを設定
        var t = options.target;
        var tdb = options.db;
        // データ読み込み
        var base_url = api_base_url + "/";
        //var base_url = "http://52.193.211.138/api/";
        var conf = {statistic:{params: "sra/type/"},
            organism: {params: "bioproject/organism_name/"},
            study_type: {params: "sra/study_type/"},
            project_datatype:{params: "bioproject/project_datatype/"}
        };
        var target_url = base_url + conf[t]["params"];

        d3.json(target_url, function(e, d){
            //リスト描画領域を作成
            svg_list = d3.select("#" + t + "_ranking").append("svg")
                .attr("width", 505).attr("height", 115);

            //ランキング描画領域を作成
            svg_bar1 = d3.select("#" + t + "_ranking").append("svg")
                .attr("width", 505).attr("height", height + margin.bottom);
            svg_bar2 = d3.select("#" + t + "_ranking").append("svg")
                .attr("width", 505).attr("height", 17);

            //チャート描画用のグループ作成
            bars1 = svg_bar1.append("g").attr("class", "bars").attr("transform", "translate(0,10)");
            bars3 = svg_bar1.append("g").attr("class", "vals").attr("transform", "translate(0,10)");
            bars4 = svg_bar1.append("g").attr("class", "arrows").attr("transform", "translate(0,10)");

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
        });

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
                    var type = $(this).parents()[1].getAttribute('data-field');
                    showList({key: type, value: d.name})
                });

            //ランキング表の背景画像を作る
            list.append("rect");

            list.append("text")
                .attr("y", function (d, i) {
                    if (i < 5){
                        return i * 22 + 4
                    } else {
                        return (i-5) * 22 + 4
                    }
                })
                .attr("x", function(d, i){
                    if (i <= 4){
                        return 25
                    } else {return 257}
                })
                .text(function (d, i) {
                    return d.name
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
            y.rangeBands([0, height]).domain(names);
            x.range([0, width - margin.right]).domain([0, d3.max(values)]);

            //矩形の描画
            bars1.selectAll("g").data(datas).enter().append("g").append("rect");
            bars1.selectAll("g").data(datas).exit().remove();
            bars1.selectAll("rect").data(datas)
                .attr("y", function (d, i) {
                    return (i * y.rangeBand())
                })
                .attr("x", 0)
                .attr("height", y.rangeBand())
                .attr("width", function (d) {
                    return x(+d.val)
                })
                .attr("fill", function (d, i) {
                    return color(i)
                })
                .attr({"stroke-width": 2, "stroke": "#ffffff", "cursor": "pointer"})
                .attr("class", function (d, i) {
                    return "rect_o" + i
                })
                .on("click", function (d) {
                    var type = $(this).parents()[3].getAttribute('data-field');
                    showList({key: type, value: d.name})
                });

            //吹き出し内のテキストを描画
            bars3.selectAll("g").data(datas).enter().append("g").append("text");
            bars3.selectAll("g").data(datas).exit().remove();
            bars3.selectAll("text").data(datas)
                .attr("y", function (d, i) {
                    return (i * y.rangeBand()) + y.rangeBand()/2 + 6
                })
                .attr("x", function (d) {
                    return x(+d.val) + 16
                })
                .attr({"fill": "#696969", "font-size": "17px", "cursor": "pointer"})
                .text(function (d) {
                    return parseInt(d.val)
                })
                .attr("text-anchor", "start")
                .on("click", function (d) {
                    var type = $(this).parents()[3].getAttribute('data-field');
                    showList({key: type, value: d.name})
                });

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
                // key: valueを渡す
                var k = q["key"];
                var v = q["value"];
                window.location.href = "result.html?" + "target_db=" + tdb + "&" + k + "=" + v;
            }
        }

    }
})(jQuery);