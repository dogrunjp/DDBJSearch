<chart>
    <div id="last_update" class="vertical_top">
        <div class="row">
            <div class="box-r">Data Last Update { lupd }<span class="date"></span> </div>
        </div>
    </div>

    <div class="row trends">
        <div class="box tob" id="organism_ranking" data-field="organism_name" data-target="bioproject">
            <h3>Organism Name</h3>
        </div>
        <div class="box" id="project_datatype_ranking" data-field="project_datatype" data-target="sra">
            <h3>Project Datatype</h3>
        </div>

    </div>

    <script>
        $(function () {
            var types = [{target: 'organism', db: 'bioproject'}, {target: 'project_datatype', db: 'bioproject'}];
            for (var i in types){
                $("body").statistic(types[i]);
            }
        });

        var target_url = conf.api_update_url;
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
                self.lupd = d["sra"];
                self.update();
            });

    </script>

</chart>