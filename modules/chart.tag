<chart>
    <div id="last_update" class="vertical_top">
        <div class="row">
            <div class="box-r">Data Last Update { lupd }<span class="date"></span> </div>
        </div>
    </div>

    <div class="row trends">
        <div class="box tob" id="organism_ranking" data-field="organism_name" data-target="bioproject">
            <h3>BioProject OrganismName</h3>
        </div>
        <div class="box" id="project_datatype_ranking" data-field="project_datatype" data-target="sra">
            <h3>BioProject DataType</h3>
        </div>

    </div>

    <script>
        $(function () {
            var types = [{target: 'organism', db: 'bioproject'}, {target: 'project_datatype', db: 'bioproject'}];
            for (var i in types){
                $("body").statistic(types[i]);
            }
        });

        var target_url = "http://sra-api-dev.bhx.jp/api";
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

        obs.on("menuSelected", function(t){
            get_data()
                .done(function (d) {
                    self.lupd = d[t.toLowerCase()]["last_update"];
                    self.update()
                })
        });

    </script>

</chart>