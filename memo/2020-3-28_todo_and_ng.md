# 2020-3-28 DDBJSearch  基本情報 & TODO

#### 2020-3-30

## APIについて

### ドメイン名を統一する
```
　dbcls-sra.bhx.jp/api
```

- 現状は 52.192.124.76 。52.199.173.250にデータ投入とAPI ver UP完了後はそちらに付け替える 
- bmu.jpって何と聞かれることが多いので、よりそれっぽいドメインの方に（BioHackathon X）

### Taxonomy 検索・変換APIは以下のように(rdf_wrapper.py)

- 親子の表示
http://dbcls-sra.bhx.jp/api/exp_taxonomy/<tax ID>
例）http://dbcls-sra.bhx.jp/api/exp_taxonomy/9606

- scientific name から taxonomy IDへの変換は
http://dbcls-sra.bhx.jp/api/taxonomyid/<生物名>
例）http://dbcls-sra.bhx.jp/api/taxonomyid/Homo%20sapiens

- taxonomy idからScientific nameへの変換は
http://dbcls-sra.bhx.jp/api/scientific_name/<taxonomy ID>
例）http://dbcls-sra.bhx.jp/api/scientific_name/9606

### Publication 検索API

```
/api/publication/search?<parameter=>
```

- 検索パラメータは
  bp_title, article_title, journal, year 

- 例）http://dbcls-sra.bhx.jp/api/publication/search?article_title=Bacillus&year=2009&bp_title=Genome

- __ページネーションは、page_no, per_pageで良いの？？__ 

  2020-4-3  publicationのパラメータは{size: , page, article_title, bp_title, journal, year, sort: <field name>, order: [desc, asc]]}

## デモサイトの不具合

###  デモサイト：http://sra-dev.bmu.jp/publication を直打ちすると 404 NTO Found
-  http://sra-dev.bmu.jp/taxonomy  404 Not Fount
```
404 Not Found

Code: NoSuchKey
Message: The specified key does not exist.
Key: publication
RequestId: 95EA97D2A15DCCE8
HostId: eCiC/cyJtjRYZzvbvuimjfV5W9TAcXiJJ/+jowlhyOL1atnpxtXB0l1nCaNw0psUpP/mcf6sucY=
```


###  reloadしてもnotfound


### 検索処理の不具合

- __検索を続けると二回目の検索が上手く表示されない”Sorry caused an error.."に__

1. Taconomy ID に10090を入力し"search"
2. 何か表示される http://sra-dev.bmu.jp/?tx_taxonomy_id=10090&scientific_name=&per_page=10&sort_key=TaxonomyID&order_by=asc&page_no=1
3. クリアする http://sra-dev.bmu.jp/
4. Taxonomy IDに9606と入力し"search"
5. "Sorry Caused an error"が下に表示される

- __publication で検索から発行されるAPIのパラメータがおかしい__
1. BioProject titleで"rat"を入力し、検索
2. 表示される、がクエリパラメータの値が入っていないような、、、
 この時APIは http://sra-dev.bmu.jp/publication?assesions=&keyword=&pmid=&article_title=&bp_title=&pub_year=&per_page=10&sort_key=BioProject&order_by=asc&page_no=1
3. clearをクリック
4. BioProject tileに"mouse"を入力し"search"
5. Sorry caused an error
　この時APIは　http://dbcls-sra-api.bmu.jp/api/publication/search?size=10&sort=BioProject&order=asc&page=1

**一度目（2.）は検索しているようでキーに値が入っていない?**
**二度目（5.）はパラメータの検索フィールドのキーが存在しないため（bp_title, article_titleなど）500が帰っている（fix 対象）**


## UIについて

- エラー表示のパネルが大きすぎるのでは


## APIのエラーと未実装（dogrunが対応すること）

- numfoundがsizeの値になっている！！！！！！！
- page nationのパラメータ、page_no, per_pageで良い？
-  publication, 検索キーが取得できないと500エラーが返る（正常系で返すべきかも。でもviewはどちらもかわらないかもですが）

## まとめ

- API：ドメイン"dbcls-sra.bhx.jp/api" に統一する
- ルータの問題かと思われるが、URL直打ちが効かなそうなのが?？S3利用は前提なので、S3で問題が回避できないと使えないかも。
- 検索のUI、入力とパラメータの付与の挙動があやしい


