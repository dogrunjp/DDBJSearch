<chart>
    <div id="last_update" class="vertical_top">
        <div class="row">
            <div class="box-r">Data Last Update <span class="date"></span> </div>
        </div>
    </div>

    <div class="row trends">
        <div class="box tob" id="organism_ranking" data-field="organism_name" data-target="bioproject">
            <h3>Organism Name</h3>
        </div>
        <div class="box" id="study_type_ranking" data-field="study_type" data-target="study">
            <h3>Study Type</h3>
        </div>

    </div>

    <script>
        $(function () {
            var types = [{target: 'organism', db: 'bioproject'}, {target: 'study_type', db: 'sra'}];
            for (var i in types){
                $("body").statistic(types[i]);
            }
        });
    </script>

</chart>