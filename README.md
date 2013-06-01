konashi-js-sdk
=============

BLE konashi + js = konashi-js-sdk!!


## konashiってなぁに？
iPhoneやiPadで使えるワイヤレスなフィジカル・コンピューティング・ツールキット

<a href="http://konashi.ux-xu.com"><img src="http://konashi.ux-xu.com/img/header_logo.png" width="200" /></a><br/>
Physical computing toolkit for smartphones and tablets

[http://konashi.ux-xu.com](http://konashi.ux-xu.com)<br/>
[Github: konashi-ios-sdk](https://github.com/YUKAI/konashi-ios-sdk)

## konashi-js-sdk の魅力的なコードたち
JSだけでkonashiをコントロールできる、とはどういうことだろう。コードを見れば一目瞭然！

たとえば、konashiのボートにあるLEDを光らせるには

```js
// konashiと接続できたら実行される
k.ready(function(){
    // I/Oの設定
    k.pinMode(k.LED2, k.OUTPUT);
    
    // LED2をON
    k.digitalWrite(k.LED2, k.HIGH);
});

// まわりにあるkonashiを探す
k.find();
```

これだけでOK!

さらに発展させて、LEDをチカチカさせるには

```js
// LEDチカチカ開始
function startBlinkLed(){
    var toggle = false;
    
    setInterval(function(){
        if(toggle){
            // LEDをON
            k.digitalWrite(k.LED2, k.HIGH);
        } else {
            // LEDをOFF
            k.digitalWrite(k.LED2, k.LOW);
        }
        
        // 次の状態をセット
        toggle = !toggle;
    }, 500);
    
    $("#goran").html("konashiのLED2をみてごらん！<br/>たぶんチカチカしていると思うよ！");
}

// konashiと接続できたんだね
k.ready(function(){
    // まずはI/Oの設定から
    k.pinMode(k.LED2, k.OUTPUT);
    
    // Lチカスタートさせるよ
    startBlinkLed();
});

// konashiを探すボタンを押すとkonashiを探せ命令を送る！
$(function(){
    $("#find").on("tap", function(){
        k.find();
    });
});
```

これだけでオッケー！！

BLEの通信内容やCoreBluetoothAPIなどのネイティブの実装を意識することなく、ただJSを書くだけでハードウェアをコントロールできちゃうんです。

## konashi-js-sdk について
konashi-js-sdk には、iOSのライブラリと、jsのライブラリが含まれています。

- koanshi-ios-sdk で定義されている関数の実行や、イベントのハンドラ登録をJavaScriptからできるようにしたUIWebView **「KonashiWebView」**
- ブラウザから KonashiWebView へアクセスするための手続きをラップした **「konashi-bridge.js」**

これらを使用することにより、HTML+JavaScript から konashi をコントロールすることができます。

## ただいまBeta中!!
現在beta開発中です。まだ足りないJSの関数があったり、デバッグができていないところがあります。よかったらPullRequestやIssueで開発に参加してね！大歓迎！

## Getting Started
- サンプル参照

### konashi-bridge.js をbowerでゲット
```
$ bower install konashi-bridge.js
```


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
