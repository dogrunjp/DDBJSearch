<template>
    <div class="content mb-3">
        <p class="title is-6 has-text-right">Data Last Update <span class="date">{{ lupd }}</span></p>
        <hr />
        <div class="columns">
            <div class="column" id="organism_ranking" data-field="organism_name" data-target="bioproject" v-show="bioproject">
                <div class="box">
                    <h3 class="title is-5">Organism Name</h3>
                </div>
            </div>
            <div class="column" id="project_datatype_ranking" data-field="project_datatype" data-target="sra" v-show="sra">
                <div class="box">
                    <h3 class="title is-5">BioProject Datatype</h3>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
//    import conf from '../config'
    import axios from 'axios'
    import * as d3 from 'd3'
    import $ from 'jquery'

    var types = [{target: 'organism', db: 'bioproject'}, {target: 'project_datatype', db: 'bioproject'}];
    var x = d3.scaleLinear();
    var y = d3.scaleOrdinal();
    var svg_list, svg_bar1, bars1, bars3;
    var color = d3.scaleOrdinal(d3.schemeCategory10);//d3.scale.category10();
    var margin = {top: 25, bottom: 30, left: 30, right: 110}, width = 505, height = 220;
    var tdb;

    export default {
        data() {
            return {
                lupdData: [],
                lupd: '',
                bioproject: true,
                sra: true,
                targetUrl: "http://dbcls-sra-api.bmu.jp/api"
            }
        },
        mounted: function () {
            this.getData()
            for (var i in types) {
                this.statistic(types[i])
            }
        },
        watch: {
            '$route': 'updateLupd'
        },
        methods: {
            getData() {
                axios
                    .get(this.targetUrl)
                    .then(response => {
                        this.lupdData = response.data
                        this.lupd = response.data.sra.last_update
                    })
            },
            updateLupd() {
                this.lupd = this.lupdData.sra.last_update
            },
            statistic(options) {
                //var margin = {top: 25, bottom: 30, left: 30, right: 110}, width = 505, height = 220;
                var margin = {top: 25, bottom: 30, left: 30, right: 110}, height = 220;
                //var color = d3.scale.category10();
                // スケール設定
                //var x = d3.scale.linear();
                //var y = d3.scale.ordinal();

                //var svg_list, svg_bar1, svg_bar2, bars1, bars2, bars3, bars4;

                // 描画するDOMを設定
                var t = options.target;
                tdb = options.db;
                // データ読み込み
                var base_url = this.targetUrl + "/";
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
                    //svg_bar2 = d3.select("#" + t + "_ranking").append("svg")
                    //    .attr("width", 505).attr("height", 17);

                    //チャート描画用のグループ作成
                    bars1 = svg_bar1.append("g").attr("class", "bars").attr("transform", "translate(0,10)");
                    bars3 = svg_bar1.append("g").attr("class", "vals").attr("transform", "translate(0,10)");
                    //bars4 = svg_bar1.append("g").attr("class", "arrows").attr("transform", "translate(0,10)");

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
                    this.drawBar(data_f);
                    this.drawRanking(data_f);
                })
            },
            drawRanking(d) {
                var list = svg_list.selectAll(".lists")
                    .data(d)
                    .enter()
                    .append("g")
                    .attr("transform", "translate(0, 10)")
                    .attr("font-size", 14)
                    .attr("fill", "#444444")
                    .attr("class", "lists")
                    .on("click", function (d) {
                        var type = $(this).parents()[1].getAttribute('data-field');
                        this.showList({key: type, value: d.name})
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
                    .text(function (d) {
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
                        width: function () {
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

            },
            drawBar(datas) {
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
                        this.showList({key: type, value: d.name})
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
                        this.showList({key: type, value: d.name})
                    });

            },
            showList(q) {
                if (q != "total") {
                    // key: valueを渡す
                    var k = q["key"];
                    var v = q["value"];
                    window.location.href = "?" + k + "=" + v + "&target_db=" + tdb;
                }
            }
        }
    }
</script>