<header>
    
    <div id="header-link" class="navbar-inverse nav-upper">
        <div class="container-fluid content">
            <ul class="nav navbar-upper">
                <li><a href="http://trace.ddbj.nig.ac.jp/dra/index.html"><i class="fa fa-external-link" aria-hidden="true"></i> DRA Home </a></li>
                <li><a href="http://getentry.ddbj.nig.ac.jp/top-e.html"><i class="fa fa-external-link" aria-hidden="true"></i> DDBJ flat file search</a></li>
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
                        <span class="title">DBCLS SRA <i class="fa fa-angle-right" aria-hidden="true"></i> {fed}</span>
                    </a>
                </h1>
            </div>

            <div class="box box3">
                <ul id="target_dbs" onclick={onFocus}>
                    <li class="target" data-target="taxonomy">Taxonomy</li>
                    <li class="target" data-target="publication">Publication</li>
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
        // ターゲットのdb名を取得し、heaaderの情報に埋め込む
        var self = this;
        self.fed = "SRA";
        var args = location.search;
        var props = args.slice(1).split('&');
        var target_db = props[0].split('=');
        focused = target_db ?  target_db[1]: "sra";

        // headerのdbがクリックされた祭のイベント
        this.onFocus = function(e){
            focused = sub_title[e.target.dataset.target];
            self.fed = focused;
            obs.trigger('menuSelected', focused);
        };

        obs.on("targetSelected", function(s){
            focused = sub_title[s];
            self.fed = focused;
            self.update();
            $("#header-menu li.target").removeClass("focused");
            $("#header-menu [data-target="+ s +"]").addClass("focused");

        });

    </script>
</header>