konashi-js-sdk
=============

## Getting Started

## Build js
```
$ npm install
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
