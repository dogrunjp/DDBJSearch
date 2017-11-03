<form_set>
        <form method="get" id="queryform" name="queryform">
            <div id="query">
                <div id="keyword">
                    <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="term">Keyword :</label></span>
                    <input type="text" id="term" class="input-box1" name="term" size="50" value=""/>
                </div>

                <div id="accession">
                    <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="uid">Accession :</label></span>
                    <input type="text" class="input-box1" id="uid" name="uid" size="50" value=""/>
                </div>

                <div show='{visible.sra}'>
                    <div>
                        <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="study_title">Title :</label></span>
                        <input type="text" class="input-box1" id="study_title" name="study_title" size="50" value=""/>
                    </div>
                    <div>
                        <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="organism_name">Organism :</label></span>
                        <input type="text" class="input-box1" name="organism_name" id="organism_name" size="50" value=""/>
                    </div>

                    <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="study_type" class="left-margin">StudyType :</label></span>
                    <select id="study_type" class="select-box1" name="study_type">
                        <option></option>
                        <option>Whole Genome Sequencing</option>
                        <option>Transcriptome Analysis</option>
                        <option>Metagenomics</option>
                        <option>Population Genomics</option>
                        <option>Epigenetics</option>
                        <option>Exome Sequencing</option>
                        <option>Epigenetics</option>
                        <option>Exome Sequencing</option>
                        <option>Pooled Clone Sequencing</option>
                        <option>Synthetic Genomics</option>
                        <option>Transcriptome Sequencing</option>
                        <option>Other</option>
                    </select>

                </div>

                <div id="bioproject_form" data-target="bioproject" show="{visible.bioproject}">
                    <div>
                        <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="bp_title">Title :</label></span>
                        <input type="text" class="input-box1" id="bp_title" name="title" size="50" value=""/>
                    </div>
                    <div>
                        <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="locus_tag_prefix">Locus Tag Prefex :</label></span>
                        <input type="text" class="input-box1" name="locus_tag_prefix" id="locus_tag_prefix" size="40" value=""/>
                    </div>
                </div>

                <div id="biosample_form" data-target="biosample" show="{visible.biosample}">
                    <div>
                        <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="bs_title">Title :</label></span>
                        <input type="text" class="input-box1" id="bs_title" name="title" size="50" value=""/>
                    </div>
                    <div>
                        <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="package">Package :</label></span>
                        <input type="text" class="input-box1" name="package" id="package" size="50" value="" />
                    </div>
                    <div>
                        <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="taxonomy_id">Taxonomy ID :</label></span>
                        <input type="text" class="input-box1" name="taxonomy_id" id="taxonomy_id" size="50" value="" />
                    </div>
                    <div>
                        <span class="col_name"><i class="fa fa-search" aria-hidden="true"></i> <label for="taxonomy_name">Taxonomy Name :</label></span>
                        <input type="text" class="input-box1" name="taxonomy_name" id="taxonomy_name" size="50" value="" />
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
            </div>
        </form>
    </div>
    <script>
        // アクティブなターゲットを切り替え
        this.visible = {
            biosample: false,
            bioproject: false,
            sra: true
        };
        var self = this;
        var focused = "sra";

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
            var vals = [];

            // submit以外のformをk:vにパースしarrayに追加する
            $.each(forms, function (i, x) {
                var k = x.name;
                var v = x.value;
                if (["", "Search", "Clear"].indexOf(v) == -1) {
                    var obj = [k, v];
                    vals.push(obj);
                }
            });

            //
            var q = vals.map(function(l){
                var s = l[0] + "=" +l[1];
                return s
            });
            var qs = q.join("&");
            window.location.href = "result.html?" + "target_db=" + focused + "&" + qs;
        }
        formrst()
        {
            document.queryform.reset()
        }
    </script>
</form_set>
