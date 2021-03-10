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
                    <li class="target" data-target="taxonomy"><a href="./taxonomy.html">Taxonomy</a></li>
                    <li class="target" data-target="publication"><a href="./publication">Publication</a></li>
                    <li class="target" data-target="biosample"><a href="./index.html?target_db=biosample">BioSample</a></li>
                    <li class="target" data-target="bioproject"><a href="./index.html?target_db=bioproject">BioProject</a></li>
                    <li class="target" data-target="sra"><a href="./index.html">SRA</a></li>
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

        var args = location.search;
        // location.pathnameはページことに変数に関わらず一定なためページ判定にpathnameを利用
        var focused = location.pathname.split(/\.|\//).slice(2,3)[0];
        self.fed = focused;
        this.on("mount", function () {
            $("#target_dbs li[data-target=" + focused + "]").addClass("focused");
        })

        // headerのターゲットDB名が
        // クリックされた祭のイベント
        // 対象DBを指定し
        this.onFocus = function(e){
            focused = sub_title[e.target.dataset.target];
            self.fed = focused;
            // chartタグのイベントを呼ぶ
            obs.trigger('menuSelected', focused);
        };

        // コンテンツモジュールからobs.trigger("targetSelected", targetdb)のように
        // データベースを指定し呼ばれる
        obs.on("targetSelected", function(s){
            focused = sub_title[s];
            self.fed = focused;
            self.update();
            $("#header-menu li.target").removeClass("focused");
            $("#header-menu [data-target="+ s +"]").addClass("focused");

        });

    </script>
</header>