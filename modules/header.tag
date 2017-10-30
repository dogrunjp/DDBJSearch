<header>
    <div id="header" class="sub">
        <div class="content">
            <!-- Header section -->
            <div class="box box1">
                <h1>
                    <a href="./index.html">
                        <img src="images/ddbj_logo.png" class="logo" alt="DRA Search"/>
                        <span class="title">DDBJ Search - {focused}</span>
                    </a>
                </h1>
            </div>

            <div class="box box3">
                <ul id="target_dbs" onclick={onFocus}>
                    <li><a href="http://trace.ddbj.nig.ac.jp/dra/index_e.html">DRA Home</a></li>
                    <li class="target" data-target="biosample">BioSample</li>
                    <li class="target" data-target="bioproject">BioProject</li>
                    <li class="target focused" data-target="sra">SRA</li>
                </ul>
            </div>
        </div>
    </div>
    <script>
        var sub_title = {
            biosample: "BioSample",
            bioproject: "BioProject",
            sra: "SRA"
        };
        var self = this;
        this.focused = "SRA";
        this.onFocus = function(e){
            this.focused = sub_title[e.target.dataset.target];
        };
        obs.on("targetSelected", function(s){
            self.focused = sub_title[s];
            self.update();
            $("#header li.target").removeClass("focused");
            $("#header [data-target="+ s +"]").addClass("focused");
        });
    </script>
</header>