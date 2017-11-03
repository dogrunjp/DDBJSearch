<header>
    <div id="header-link" class="navbar-inverse nav-upper">
        <div class="container-fluid content">
            <ul class="nav navbar-upper">
                <li><a href="#"><i class="fa fa-external-link" aria-hidden="true"></i> DRA Home </a></li>
                <li><a href="#"><i class="fa fa-external-link" aria-hidden="true"></i> DDBJ flat file search</a></li>
            </ul>
        </div>
    </div>

    <div id="header-menu" class="sub">
        <div class="content">
            <!-- Header section -->
            <div class="box box1">
                <h1>
                    <a href="./index.html">
                        <img src="images/ddbj_logo.png" class="logo" alt="DRA Search"/>
                        <span class="title">DDBJ Search <i class="fa fa-angle-right" aria-hidden="true"></i> {focused}</span>
                    </a>
                </h1>
            </div>

            <div class="box box3">
                <ul id="target_dbs" onclick={onFocus}>
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
            $("#header-menu li.target").removeClass("focused");
            $("#header-menu [data-target="+ s +"]").addClass("focused");

        });

    </script>
</header>