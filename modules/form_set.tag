<form_set>
        <form id="queryform" name="queryform">
            <div id="keyword">
                <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="term">Keyword :</label></span>
                <input type="text" id="term" class="input-box1" name="term" size="50" value="" onkeydown="{enter_go}"/>
            </div>

            <div id="accession">
                <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="uid">Accession :</label></span>
                <input type="text" class="input-box1" id="uid" name="uid" size="50" value="" onkeydown="{enter_go}"/>
            </div>

            <div id="sra_form" show='{visible.sra}'>

                <div class="show_more"><a href="#" data-target="sra_advanced" data-state="hide" onclick={adv_show}>Advanced search</a></div>

                <div  id="sra_advanced" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                    <div>
                        <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="study_title">Title :</label></span>
                        <input type="text" class="input-box1" id="study_title" name="study_title" data-type="study" size="50" value="" onkeydown="{enter_go}"/>
                    </div>

                    <div>
                        <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="publication_id">Publication ID :</label></span>
                        <input type="text" class="input-box1" id="publication_id" name="publication_id" data-type="study" size="50" value="" onkeydown="{enter_go}"/>
                    </div>

                    <div>
                        <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="study_type" class="left-margin">StudyType :</label></span>
                        <input type="text" class="input-box1" name="study_type" id="study_type" data-type="study" onkeydown="{enter_go}" />
                    </div>

                    <div>
                        <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="library_name">Library Name :</label></span>
                        <input type="text" class="input-box1" name="library_name" id="library_name" data-type="experiment" size="50" value=""  onkeydown="{enter_go}"/>
                    </div>

                    <div>
                        <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="library_strategy">Library Strategy :</label></span>
                        <input type="text" class="input-box1" name="library_strategy" id="library_strategy" data-type="experiment" size="50" value="" onkeydown="{enter_go}"/>
                    </div>

                    <div>
                        <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="library_source">Library Source :</label></span>
                        <input type="text" class="input-box1" name="library_source" id="library_source" data-type="experiment" size="50" value="" onkeydown="{enter_go}"/>
                    </div>

                    <div>
                        <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="library_selection">Library Selection :</label></span>
                        <input type="text" class="input-box1" name="library_selection" id="library_selection" data-type="experiment" size="50" value=""  onkeydown="{enter_go}"/>
                    </div>

                    <div>
                        <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="platform">Platform :</label></span>
                        <input type="text" class="input-box1" name="platform" id="platform" data-type="experiment" size="50" value="" onkeydown="{enter_go}"/>
                    </div>

                    <div>
                        <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="instrument_model">Instrument model :</label></span>
                        <input type="text" class="input-box1" id="instrument_model" name="instrument_model" data-type="experiment" size="50" value="" onkeydown="{enter_go}"/>
                    </div>

                </div>
            </div>

            <div id="bioproject_form" data-target="bioproject" show="{visible.bioproject}">
                <div class="show_more"><a href="#" data-target="bp_advanced" data-state="hide" onclick={adv_show}>Advanced search</a></div>
                <div  id="bp_advanced" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                    <div>
                        <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="bp_title">Title :</label></span>
                        <input type="text" class="input-box1" id="bp_title" name="title" size="50" value="" onkeydown="{enter_go}"/>
                    </div>

                    <div>
                        <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="publication_id">Publication ID :</label></span>
                        <input type="text" class="input-box1" name="publication_id" id="publication_id" size="50" value="" onkeydown="{enter_go}"/>
                    </div>
                </div>


            </div>

            <div id="biosample_form" data-target="biosample" show="{visible.biosample}">
                <div>
                    <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="taxonomy_id">Taxonomy ID :</label></span>
                    <input type="text" class="input-box1" name="taxonomy_id" id="taxonomy_id" size="50" value="" onkeydown="{enter_go}" />
                </div>
                <div>
                    <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="taxonomy_name">Organism name :</label></span>
                    <input type="text" class="input-box1" name="taxonomy_name" id="taxonomy_name" size="50" value="" onkeydown="{enter_go}" />
                </div>
                <div class="show_more"><a href="#" data-target="bs_advanced" data-state="hide" onclick={adv_show}>Advanced search</a></div>
                <div  id="bs_advanced" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                    <div>
                        <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="bs_title">Title :</label></span>
                        <input type="text" class="input-box1" id="bs_title" name="title" size="50" value="" onkeydown="{enter_go}"/>
                    </div>
                    <div>
                        <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="package">Package :</label></span>
                        <input type="text" class="input-box1" name="package" id="package" size="50" value="" onkeydown="{enter_go}" />
                    </div>
                </div>
            </div>

            <div>
                <label for="view_count">Show
                    <select id="view_count" class="select-box1" name="rows">
                        <option value="20">20</option>
                        <option value="50">50</option>
                        <option value="100">100</option>
                    </select>
                     records
                </label>

                <label show='{visible.sra}' for="sra_sort_key">Sort by
                    <select id="sra_sort_key" class="select-box1" name="sort">
                        <option value="uid">ACCESSION</option>

                    </select>
                </label>

                <label show='{visible.bioproject}' for="bp_sort_key">Sort by
                    <select id="bp_sort_key" class="select-box1" name="sort">
                        <option value="submitted">SUBMITTED</option>
                        <option value="uid">ACCESSION</option>
                    </select>
                </label>

                <label show='{visible.biosample}' for="bs_sort_key">Sort by
                    <select id="bs_sort_key" class="select-box1" name="sort">
                        <option value="uid">ACCESSION</option>
                    </select>
                </label>

                <input type="button" id="search" class="input-box1" value="Search" onclick={keywordsearch} />
                <input type="button" id="clear" class="input-box1" value="Clear" onclick={formrst} />
            </div>
        </form>
    <script>
        // アクティブなターゲットを切り替え
        this.visible = {
            biosample: false,
            bioproject: false,
            sra: true
        };
        var self = this;
        var args = location.search;
        var props = args.slice(1).split('&');
        var target_db = props[0].slice(10);
        var focused = target_db ? target_db : "sra";

        $("#header-menu li.target").click(function(){
            $("#header-menu li.target").removeClass("focused");
            focused = this.dataset.target;
            self.visible.sra = self.visible.bioproject = self.visible.biosample = false;
            self.visible[focused] = true;
            //css変更
            $("#header-menu [data-target="+ focused +"]").addClass("focused");
            self.formrst();
            self.update()
        });

        keywordsearch()
        {
            var forms = document.getElementById('queryform').elements;
            var vals = [],acc;

            // nameとvalueをformをk:vにパースしarrayに追加する
            $.each(forms, function (i, x) {
                var k = x.name;
                var v = x.value;

                if (["", "Search", "Clear"].indexOf(v) == -1) {
                    var obj = [k, v];
                    // accessionが入力された場合のみaccにも値を入れる
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
                    q.push("type=" + s)
                }
            });
            if(acc){
                fetch("http://52.193.211.138/api/" + focused + "?uid=" + acc[1])
                    .then(function (d) {
                        return d.json()
                    })
                    .then(function (jsn) {
                        if (jsn["numFound"] > 0){
                            window.location.href = "details.html?db=" + focused + "&accession=" + acc[1]
                        }else{
                            // 必ず0件を取得するquery
                            window.location.href = "result.html?target_db=" + focused + "&uid=" + acc[1]
                        }
                    });

            }else{
                var qs = q.join("&");
                window.location.href = "result.html?" + "target_db=" + focused + "&" + qs;
            };

        }
        formrst()
        {
            document.queryform.reset()
        }

        adv_show(e)
        {
            if(e.target.dataset.state == "hide"){
                $("#" + e.target.dataset.target).addClass("in");
                e.target.text = "Hide";
                e.target.dataset.state = "show";
            }else if(e.target.dataset.state == "show"){
                $("#" + e.target.dataset.target).removeClass("in");
                e.target.text = "Advanced search";
                e.target.dataset.state = "hide";
            }
        }

        enter_go(e)
        {
            if(e.key == "Enter"){
                this.keywordsearch();
            }
        }

        // Advanced searchのshow propertyを設定
        obs.on("targetSelected", function(s){
            for (var k in self.visible){
                self.visible[k] = false;
            }
            self.visible[s] = true;
            self.update();

        });

    </script>
</form_set>
