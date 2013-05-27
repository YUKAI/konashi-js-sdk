konashi-js-sdk
=============

<a href="http://konashi.ux-xu.com"><img src="http://konashi.ux-xu.com/img/header_logo.png" width="200" /></a><br/>
Physical computing toolkit for smartphones and tablets

[http://konashi.ux-xu.com](http://konashi.ux-xu.com)<br/>
[Github: konashi-ios-sdk](https://github.com/YUKAI/konashi-ios-sdk)


## konashi-js-sdkについて
konashi-js-sdk には、

- koanshi-ios-sdk で定義されている関数の実行や、イベントのハンドラ登録をJavaScriptからできるようにしたUIWebView (KonashiWebView) 
- ブラウザから KonashiWebView へアクセスするための手続きをラップした konashi-bridge.js
が含まれています。

konashi-js-sdk により、HTML+JavaScript から konashi をコントロールすることができます。

## ただいまBeta中!!
現在beta開発中です。まだ足りないJSの関数があったり、デバッグができていないところがあります。よかったらPullRequestやIssueで開発に参加してね！大歓迎！

## Getting Started
- サンプル参照


## ディレクトリ構成
- KonashiWebView: konashi-ios-sdk + UIWebViewでブラウザからkonashi-ios-sdk経由でkonashiにアクセスできりるようにするUIWebViewのカスタムクラス。
- js: JSとnative(konashi-ios-sdk)をブリッジするkonashi-bridge.jsがある。
- build: konashi-bridge.jsの圧縮版。
- libs: submoduleが格納される。
- samples: まだ少ないですが、サンプルもあります。

## 開発情報

### JSをビルドする
最初に

```
$ npm install
```

以降は

```
$ grunt
```

### submoudleを初期化する
konashi-ios-sdk をsubmoduleとして組み込んでいます。

```
$ git submodule init
$ git submodule update
```

### submodule を更新する
konashi-ios-sdk が更新されている場合は、以下のコマンドで最新をpullすることができます。

```
$ git submodule foreach 'git pull origin master'
```
