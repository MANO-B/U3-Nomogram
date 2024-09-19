## MANomogram （仮） for C-CAT CALICO database <img src="source/MANO.png" width=50>
MGPT (multi-gene panel testing) advocacy Nomogram for C-CAT CALICO database.  
Copyright (c) 2024 Masachika Ikegami, Released under the [MIT license](https://opensource.org/license/mit).  

### Trial Website
[Shinyapps.io](https://1onvji-mano0b.shinyapps.io/MANomogram/)でv0.0.1での動作確認が可能です。  
1GBメモリの環境のため頻繁にメモリ不足でクラッシュします。基本的には以下に記載の手順のとおりLocal環境で実行ください。  

### C-CAT CALICO データベースを用いた生殖細胞系列変異の解析Webアプリ
国立がん研究センターに設置されている[がんゲノム情報管理センター(C-CAT)](https://www.ncc.go.jp/jp/c_cat/use/index.html)には保険診療で行われたがん遺伝子パネル検査(Comprehensive Genomic Profiling, CGP検査)の結果と臨床情報が集約されています。この情報を学術研究や医薬品等の開発を目的とした二次利活用する仕組みがあります。現状では所属施設の倫理審査とC-CATでの倫理審査を経た研究でのみ使用可能であり、また病院やアカデミア以外の組織では年間780万円の利用料金が必要と敷居が高いですが、類似した海外のデータベースである[AACR project GENIE](https://www.aacr.org/professionals/research/aacr-project-genie/)と比較して薬剤の情報や臨床情報が詳しい点で優れており、希少がん・希少フラクションの研究においてこれまでになかった切り口での解析が可能になると考えられています。  
  
C-CATのデータを用いるに当たってはビッグデータかつリアルワールドデータの解析には特有の問題があり、また一定程度のデータ処理を行うプログラミングの知識が必要になります。GUIを用いたソフトウェアにより解析の敷居を下げることで、臨床医の日常診療におけるクリニカルクエスチョンに基づいた探索的研究を容易とし、C-CAT利活用データの活用を促進するために本ソフトウェアを作成しました。Felisはネコの学名であり、C-CAT関連の命名にはネコの名前縛りがあるようです。良い名前を検討中です。  

C-CAT CALICOからデータを入手可能な方のみが本ソフトウェアを使用可能となる現状はご理解ください。  

### 解析手法は以下の論文に基づきます
> 1) Tamura T et al., Selection bias due to delayed comprehensive genomic profiling in Japan, Cancer Sci, 114(3):1015-1025, 2023.  
      左側切断バイアスについては[こちらのwebsite](https://github.com/MANO-B/CCAT)も参照ください。
> 2) Mochizuki T et al., Factors predictive of second-line chemotherapy in soft tissue sarcoma: An analysis of the National Genomic Profiling Database, Cancer Sci, 115(2):575-588, 2024.  

### System Requirements
#### Hardware Requirements
機械学習を行っており、CPUが高速であるに超したことはありませんが、必ずしも高性能のPCでなくても動作すると思います、多分。  

#### Software Requirements
#### Docker file
Dockerを使用可能であれば面倒なインストール作業をせずにすぐに使用開始可能です。  
Dockerの使用法は[Windows向け](https://qiita.com/hoshimado/items/51c99ccaee3d4222d99d)や[MacOS向け](https://www.kagoya.jp/howto/cloud/container/dockerformac/)を参照ください。  
Docker desktop使用時は、CPUは4コア以上、メモリは[可及的に大きく設定](https://dojo.docker.jp/t/topic/52)ください。  
MANomogramのDocker fileは[Docker-hub](https://hub.docker.com/r/ikegamitky/)に登録しています。  
```
# 先にDocker desktopを起動しておきます
# Windowsはコマンドプロンプト、Macはターミナルで以下を実行
# 適宜sudoで実施ください
# バージョンアップを行う場合もこのコマンドを実行します
docker pull ikegamitky/felis:latest

# バージョンアップが不調の時は、以下の例の様にlatestを変更して直接バージョンを指定するとよいかもしれません。
# この場合は以降のコマンドにおけるlatestの記載も対応するバージョンに変更して実行します。
Intel: docker pull ikegamitky/felis:1.6.7
Apple silicon Mac: docker pull ikegamitky/felis:1.6.7.mac

# 古いソフトが動き続けてしまっている場合は以下で終了します。
docker ps -a
docker kill [container id]
docker rm [container id]
```
使用時は以下のコマンドを入力し、ブラウザで **[http://localhost:3838](http://localhost:3838)** にアクセスするとFELISが起動します。  
```
docker run -d --rm -p 3838:3838 ikegamitky/felis:latest R --no-echo -e 'library(shiny);runApp("/srv/shiny-server/MANomogram", launch.browser=F)'

##上記で動かない場合は以下を
# Docker containerを起動
docker run -it --rm -p 3838:3838 ikegamitky/felis:latest R
# Rで以下の2行を実行
library(shiny)
runApp("/srv/shiny-server/MANomogram", launch.browser=F)
```
サーバーでMANomogramを起動する場合、ターミナルから以下のコマンドを入力後はssh接続は不要です。  
接続先のIPアドレスが172.25.100.1であれば、ブラウザで **[http://172.25.100.1:3838](http://172.25.100.1:3838)** にアクセスするとMANomogramが起動します。  
```
# ssh username@servername
docker run -d -p 3838:3838 ikegamitky/felis:latest nohup shiny-server
# exit
```
Dockerを使用する場合は**解析ファイルの読み込み**セクションまで飛ばしてください。  
  
##### R language
適宜[ウェブサイト](https://syunsuke.github.io/r_install_guide_for_beginners/03_installation_of_R.html)を参照しRを導入ください。  
特にバージョンの指定はありませんが、本ソフトウェアはv4.3.2を使用して作成しました。  
以下、[コマンドラインからRを起動して作業を行います。](http://kouritsu.biz/installing-r-on-mac/)  
　　
##### Shiny
Webアプリとするために[Shiny](https://shiny.posit.co)を使用しました。
```
install.packages("shiny")
```
##### Package dependencies
依存しているパッケージ群を`R`ターミナルからインストールください。  
初めて実行する場合は相当に時間がかかります(最短で2時間程度、慣れていないとインストールの完遂は困難です)。  
依存するライブラリ群を必要に応じてapt/brewなどでinstallすることになり大変ですので、Dockerの使用が望まれます。  
```
install.packages(c('ggplot2', 'umap', 'tidyr', 'dbscan', 'shinyWidgets', 'readr', 'dplyr', 'stringr', 'RColorBrewer', 'gt', 'gtsummary', 'flextable', 'survival', 'gridExtra', 'survminer', 'tranSurv', 'DT', 'ggsci', 'scales', 'patchwork', 'sjPlot', 'sjlabelled', 'forcats', 'markdown','PropCIs','shinythemes', 'data.table', 'ggrepel', 'httr', 'plyr', 'rms', 'dcurves', 'Matching', 'blorr', 'broom', 'survRM2', 'rsample', 'shinydashboard', 'pROC', 'withr', 'rpart', 'ranger', 'bonsai', 'tidymodels', 'discrim', 'klaR', 'probably', 'lightgbm', 'partykit', 'betacal', 'BiocManager'), dependencies = TRUE)
BiocManager::install("maftools", update=FALSE)
BiocManager::install("ComplexHeatmap", update=FALSE)
BiocManager::install("drawProteins", update=FALSE)
install.packages("Rediscover")
install.packages("tidybayes")

# drawProteinsのインストールが上手くいかない場合
# githubのサインイン、PATの発行を行った上で以下を実行
install.packages("remotes")
remotes::install_github('brennanpincardiff/drawProteins', auth_token = "入手したPAT")

# Rのバージョンによりrmsのインストールが上手くいかない場合
# versionは以下URLを確認し適宜変更ください
# https://cran.r-project.org/src/contrib/Archive/rms/
install.packages("remotes")
remotes::install_version(package = "rms", version = "6.7.0", dependencies = FALSE)
```

##### Rの設定  
[Rstudio](https://posit.co/download/rstudio-desktop/)の使用をお勧めします。  
Figureの日本語表示が上手くいかない場合は[こちら](https://ill-identified.hatenablog.com/entry/2021/09/10/231230)を参照ください。  
  
### MANomogramの起動
- MANomogramのダウンロード  
使用するバージョンのFELISのZIPファイルをダウンロードし、適当なフォルダにダウンロード・解凍してください。
```
wget https://github.com/MANO-B/MANomogram/raw/main/MANomogram_latest.zip
unzip MANomogram_latest.zip
```  
ここでは"/srv/shiny-server/MANomogram"とします。  

- MANomogramの起動
以下のコマンドでWebアプリが起動します。  
Rstudioですと画面の右上に表示されるRun Appボタンから起動できます。  
```
$ R

R version 4.3.2 (2023-10-31) -- "Eye Holes"
Copyright (C) 2023 The R Foundation for Statistical Computing
Platform: aarch64-apple-darwin20 (64-bit)
.
.
.
'help.start()' で HTML ブラウザによるヘルプがみられます。 
'q()' と入力すれば R を終了します。

> library(shiny)
> runApp('/srv/shiny-server/MANomogram', launch.browser=T)
```

### 解析ファイルの読み込み
- 解析ファイルの入手
解析したいPathogenic mutationの情報をCALICOから入手し、Sampleファイルの書式にあわせてtsvファイルとして下さい。  
CALICOでのスクリプトファイルは追って公開予定です。  

**Input C-CAT files**タブを開きます。  
TSVファイルを画面左上のBrowse...ボタンから選択して読み込みます。  
ValidationとしてC-CAT利活用データポータルのデータを使用予定です。  

### 解析対象の指定  
**Setting**タブを開きます。  
**Start file loading/analysis settings**ボタンを押すと設定項目が表示されます。  
多数の項目が設定可能です。  

#### 組織型に関するフィルタ  
- Filter by histology  
　　解析対象とする組織型の絞り込みを行います。  
- Minimum patients for each histology  
　　稀な組織型は発生部位に名前を変更して解析できます。(未動作)  
　　解析する組織型の最小症例数を設定します。  
  
#### 臨床事項に関するフィルタ  
- Filter by sex  
　　解析対象とする性別の絞り込みを行います。  
- Age for analysis  
　　解析対象とする年齢の絞り込みを行います。  
- Threshold age for oncoprint  
　　OncoprintでのYoung/Oldの分類の閾値を設定します。  
  
#### 遺伝子に関するフィルタ  
- Genes of interest (if any)  
　　Oncoprintや生存期間解析等で優先する遺伝子を選択します。
　　デフォルトでは小杉班のSecondary findings genesが入力されています。  
- Genes for lolliplot (if any)  
　　Lolliplotで描画する遺伝子を選択してください。遺伝子によっては完全な描画にはInternet接続が必要です。  
　　Internet接続がない場合は簡易表示します。  
　　[Mutplot](https://github.com/VivianBailey/Mutplot)のスクリプトを使用しています。  
- Threshold mutation count for lolliplot  
　　頻度の高い変異を強調するための設定です。  
　　
#### その他の設定  
- Gene number for oncoprint  
　　Oncoprintや生存期間解析で対象とする遺伝子の絞り込みを行います。  
- Oncoprintの表示  
　　Oncoprintにおけるソートの順序を設定します。
   
### 解析の実行  
Analysisタブを開きます。  
多数の解析が可能です。説明文が適宜最下部に表示されます。  
各ボタンに対応したタブに結果が表示されます。  
表示された図は.pngの拡張子で保存可能です。  
  
#### 症例のまとめを表示  
選択した症例のまとめを**Case summary**タブに表示します。  
- 全症例の背景を**Summarized all**タブに表示します。  
- 組織型で分類して**Summarized by histology**タブに表示します。  
  
#### 変異のまとめを表示  
選択した変異のまとめを**Mutation summary**タブに表示します。  
- 体細胞変異と生殖細胞系列変異のVAFを**VAF histograms**タブに表示します。  
  
#### Oncoprintを表示  
- 選択した症例の遺伝子変異を**Oncoprint**タブに表示します。  
- 選択した遺伝子のLolliplotを**Lolliplot for the selected gene**タブに表示します。Internet接続が必要です。
    上手く表示されない場合はsource/UniProt.txtに[Uniprot ID](https://www.uniprot.org)を追記してください。  
- 症例の表を**Table of clinical and mutation information per patient**タブに表示します。左上のボタンからダウンロードが可能です。  
  
#### 組織型ごとの各遺伝子の変異率を表示  
- 変異頻度の高い遺伝子について、組織型ごとの全遺伝子変異の頻度を**All variats**タブに表示します。  
- 変異頻度の高い遺伝子について、組織型ごとの体細胞変異の頻度を**Somatic variants**タブに表示します。  
- 変異頻度の高い遺伝子について、組織型ごとの生殖細胞系列変異の頻度を**Germline variants**タブに表示します。  
- 変異頻度の高い遺伝子について、体細胞変異のgermline conversion rateを**Germline conversion rate**タブに表示します。  
- 変異頻度の高い遺伝子について、生殖細胞系列変異がTumor panelで検出されない頻度を**Germline conversion rate**タブに表示します。  
  
#### 体細胞変異から生殖細胞系列変異を予測  
Tumor panelで検出された変異に確認検査を行うべきかどうかを解析します。  
結果は**GPV estimation**タブ以下に表示します。  
- 生殖細胞系列変異かどうかを予測するノモグラムを**Nomogram**タブに表示します。  
- 生殖細胞系列変異かどうか予測する因子を**Odds ratio**タブに表示します。  
- 生殖細胞系列変異かどうかのノモグラムの性能を[Decision curve analysis](https://mskcc-epi-bio.github.io/decisioncurveanalysis/index.html)で評価し**Decision curve**タブに表示します。
  結果の考え方については[こちら](https://github.com/MANO-B/FELIS/blob/main/decision_curve_analysis.md)を参照ください。  
- Nomogramの性能評価を**ROC curve**タブに表示します。  
- Decision curve analysisの詳細を**Table for decision curve**タブに表示します。  
  
#### 妥当性検証  
機械学習とノモグラムでそれほど性能に差がないため、理解しやすさと医学的妥当性からノモグラムを使用して外的妥当性をみたいと思います。  
適切な妥当性検証のデータが入手困難ですが、C-CAT利活用データを用いる見込みです。  
ただし、生殖細胞系列変異のTumor panelでのVAFの情報が得られません。  
困りました。他のデータベースで何かあると良いのですが。  
結果は**Validation**タブ以下に表示します。  
- ROC曲線での性能評価を**ROC curve**タブに表示します。  
- 最適な閾値での性能を**Sensitivity-specificity**タブに表示します。  
  
#### ノモグラムの活用  
作成した予測モデルを**Prediction**タブ以下で実際のデータに適用可能にします。  
まずは手元のTumor panelでの検査結果にノモグラムを適用してみます。  
**Apply nomogram**タブ以下に表示します。  
- データを**Input your data**タブ中で入力します。
- 予測結果を**Results**タブで表示します。
  
#### 説明
ソフトの使用法などを**Instruction**タブに表示します。  
　　
### 今後の予定
- 外的妥当性検証について考える。  

### C−CAT CALICOのデータベースのバージョンごとのMANomogram推奨バージョン  
C-CATのデータはバージョンごとに列名が追加・変更されることがあるため、適合するバージョンが必要です。  
C-CAT CALICO database version 1: MANomogram version 0.0.1  
