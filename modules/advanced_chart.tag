<chart>
    <div id="last_update" class="vertical_top">
        <div class="row">
            <div class="box-r">Data Last Update { lupd }<span class="date"></span> </div>
        </div>
    </div>

    <div class="row trends">
        <div class="panel_stas">
            <h4>BioSample: taxonomy name</h4>
            <div width="960", height="400" id="chart1" class="chart"></div>
            <h4>BioProject: datatype</h4>
            <div width="960", height="400" id="chart2" class="chart"></div>
            <h4>Experiment: Instrument model</h4>
            <div width="960", height="400" id="chart3" class="chart"></div>


        </div>

    </div>


    <script>
    this.on("mount", function () {

        var margin = {top: 20, right: 200, bottom: 30, left: 70},
            width = 960 - margin.left - margin.right,
            height = 500 - margin.top - margin.bottom;

        var parseDate = d3.time.format("%Y").parse;

        var x = d3.time.scale()
            .range([0, width]);

        var y = d3.scale.linear()
            .range([height, 0]);

        var color = d3.scale.category10();

        var xAxis = d3.svg.axis()
            .scale(x)
            .orient("bottom");

        var yAxis = d3.svg.axis()
            .scale(y)
            .orient("left");

        var line = d3.svg.line()
            .interpolate("basis")
            .x(function(d) { return x(d.date); })
            .y(function(d) { return y(d.frequence); });

        var svg1 = d3.select("#chart1").append("svg")
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)
            .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")");



        d3.csv("./js/biosample_tax_date.csv", function(error, data) {
            if (error) throw error;

            color.domain(d3.keys(data[0]).filter(function(key) { return key !== "year"; }));

            data.forEach(function(d) {
                d.date = parseDate(d.year);
            });

            var emotions = color.domain().map(function(name) {
                return {
                    name: name,
                    values: data.map(function(d) {
                        return {date: d.date, frequence: +d[name]};
                    })
                };
            });

            x.domain(d3.extent(data, function(d) { return d.date; }));

            y.domain([
                d3.min(emotions, function(c) { return d3.min(c.values, function(v) { return v.frequence; }); }),
                d3.max(emotions, function(c) { return d3.max(c.values, function(v) { return v.frequence; }); })
            ]);

            svg1.append("g")
                .attr("class", "x axis")
                .attr("transform", "translate(0," + height + ")")
                .call(xAxis);

            svg1.append("g")
                .attr("class", "y axis")
                .call(yAxis)
                .append("text")
                .attr("transform", "rotate(-90)")
                .attr("y", 6)
                .attr("dy", ".71em")
                .style("text-anchor", "end")
                .text("Count");

            var emotion = svg1.selectAll(".emotion")
                .data(emotions)
                .enter().append("g")
                .attr("class", "emotion");

            emotion.append("path")
                .attr("class", "line")
                .attr("d", function(d) { return line(d.values); })
                .style("stroke", function(d) { return color(d.name); })
                .on("click", function () {
                });

            emotion.append("text")
                .datum(function(d) { return {name: d.name, value: d.values[d.values.length - 1]}; })
                .attr("transform", function(d,i) { return "translate(" + (width + 60) + "," +  (i * 20 + 75)  + ")"; })
                .attr("x", 3)
                .attr("dy", ".35em")
                .text(function(d) { return d.name; })
                .on("click", function () {
                    var url = "http://sra.dbcls.jp/result.html?target_db=sra&term=" + this.innerHTML + "&rows=20";
                    window.open(url)
                });

            emotion.append("rect")
                .datum(function(d) { return {name: d.name, value: d.values[d.values.length - 1]}; })
                .attr("transform", function(d,i) { return "translate(" + (width + 46) + "," +  (i * 20 + 70)  + ")"; })
                .attr("x", 3)
                .attr("dy", ".35em")
                .attr("height", 10)
                .attr("width", 10)
                .style("fill", function(d) { return color(d.name); })
                .text(function(d) { return d.name; })
                .on("click", function () {
                    var url = "http://sra.dbcls.jp/result.html?target_db=sra&term=" + this.innerHTML + "&rows=20";
                    window.open(url)
                })
        });

         // chart2
        var parseDate2 = d3.time.format("%Y").parse;

        var x2 = d3.time.scale()
            .range([0, width]);

        var y2 = d3.scale.linear()
            .range([height, 0]);

        var xAxis2 = d3.svg.axis()
            .scale(x2)
            .orient("bottom");

        var yAxis2 = d3.svg.axis()
            .scale(y2)
            .orient("left");

        var line2 = d3.svg.line()
            .interpolate("basis")
            .x(function(d) { return x2(d.date); })
            .y(function(d) { return y2(d.frequence); });

        var svg2 = d3.select("#chart2").append("svg")
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)
            .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

        d3.csv("./js/bioproject_datatype_date.csv", function(error, data2) {
            if (error) throw error;

            color.domain(d3.keys(data2[0]).filter(function(key) { return key !== "year"; }));

            data2.forEach(function(d) {
                d.date = parseDate2(d.year);
            });

            var emotions = color.domain().map(function(name) {
                return {
                    name: name,
                    values: data2.map(function(d) {
                        return {date: d.date, frequence: +d[name]};
                    })
                };
            });

            x2.domain(d3.extent(data2, function(d) { return d.date; }));

            y2.domain([
                d3.min(emotions, function(c) { return d3.min(c.values, function(v) { return v.frequence; }); }),
                d3.max(emotions, function(c) { return d3.max(c.values, function(v) { return v.frequence; }); })
            ]);

            svg2.append("g")
                .attr("class", "x axis")
                .attr("transform", "translate(0," + height + ")")
                .call(xAxis2);

            svg2.append("g")
                .attr("class", "y axis")
                .call(yAxis2)
                .append("text")
                .attr("transform", "rotate(-90)")
                .attr("y", 6)
                .attr("dy", ".71em")
                .style("text-anchor", "end")
                .text("Count");

            var emotion2 = svg2.selectAll(".emotion")
                .data(emotions)
                .enter().append("g")
                .attr("class", "emotion2");

            emotion2.append("path")
                .attr("class", "line")
                .attr("d", function(d) { return line2(d.values); })
                .style("stroke", function(d) { return color(d.name); });

            emotion2.append("text")
                .datum(function(d) { return {name: d.name, value: d.values[d.values.length - 1]}; })
                .attr("transform", function(d, i) { return "translate(" + x2(d.value.date) + "," + y2(d.value.frequence)+parseInt(i)*2 + ")"; })
                .attr("x", 3)
                .attr("dy", ".35em")
                .text(function(d) { return d.name; })
                .on("click", function () {
                    var url = "http://sra.dbcls.jp/result.html?target_db=sra&term=" + this.innerHTML + "&rows=20";
                    window.open(url)
                })
        });

        //chart3
        var margin3 = {top: 20, right: 100, bottom: 30, left: 180},
            width3 = 960 - margin3.left - margin3.right,
            height3 = 500 - margin3.top - margin3.bottom;

        var svg3 = d3.select("#chart3").append("svg")
            .attr("width", width3 + margin3.left + margin3.right)
            .attr("height", height3 + margin3.top + margin3.bottom)
            .append("g")
            .attr("transform", "translate(" + margin3.left + "," + margin3.top + ")");


        d3.json("./js/experiment_platform_s.json", function (data) {

            var x = d3.scale.linear()
                .range([0, width])
                .domain([0, d3.max(data, function (d) {
                    return d.doc_count;
                })]);

            var y = d3.scale.ordinal()
                .rangeRoundBands([height, 0], .1)
                .domain(data.map(function (d) {
                    return d.key;
                }));

            //make y axis to show bar names
            var yAxis = d3.svg.axis()
                .scale(y)
                //no tick marks
                .tickSize(0)
                .orient("left");

            var gy = svg3.append("g")
                .attr("class", "y axis")
                .call(yAxis)

            var bars = svg3.selectAll(".bar")
                .data(data)
                .enter()
                .append("g")

            //append rects
            bars.append("rect")
                .attr("class", "bar")
                .attr("y", function (d) {
                    return y(d.key);
                })
                .attr("height", y.rangeBand())
                .attr("x", 0)
                .attr("fill", "steelblue")
                .attr("width", function (d) {
                    return x(+d.doc_count);
                })
                .on("click", function (d) {
                    var api_base_url = "http://sra.dbcls.jp/result.html?target_db=sra&instrument_model=" + d.key  + "&rows=20&sort=uid&sort=submitted&sort=uid&type=experiment"
                    window.open(api_base_url)
                })

            //add a value label to the right of each bar
            bars.append("text")
                .attr("class", "label")
                //y position of the label is halfway down the bar
                .attr("y", function (d) {
                    return y(d.key) + y.rangeBand() / 2 + 4;
                })
                //x position is 3 pixels to the right of the bar
                .attr("x", function (d) {
                    return x(+d.doc_count) + 3;
                })
                .text(function (d) {
                    return d.doc_count;
                });







        })








    });




    var target_url = "http://dbcls-sra-dev.bmu.jp/api";
    var self = this;
    function get_data() {
        return $.ajax({
            type: "GET",
            url: target_url,
            timeout: 5000
        });
    }
    get_data()
        .done(function(d) {
            self.lupd = d["sra"]["last_update"];
            self.update();
        });




    </script>

</chart>