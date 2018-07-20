# Kompira : シンプルで軽量な次世代運用自動化プラットフォーム

## Kompiraとは

KompiraはIT運用管理業務の自動化を支援するための基盤システムです。
ジョブフローを記述することで、様々な運用業務、管理業務、さらには障害の復旧処理まで自動化することができます。

## インストール

パッケージを展開してから、root権限でinstall.shを実行してください（OSは新規インストールを推奨します）。
手動でインストールを行う場合は、パッケージに含まれているドキュメントを参照してください。

## 動作環境

Kompira 1.5 の動作環境は以下の通りです。

### 対応システム

* x86_64
* CentOS/RHEL 6.X, 7.X (7.X 推奨)
* Python 2.7

### 推奨ハードウェア

* CPU: 1GHz以上
* メモリ: 2GB以上
* HDD: 30GB以上

### ポート番号

Kompira が利用するポート番号は以下の通りです。

#### 外部から内部への方向

* Kompira GUI, REST APIへのアクセス： http(80), https(443)
* kompira_sendevt によるイベント送信： amqp(5672)

#### 内部から外部への方向

* Kompira からメール受信： POP(110), IMAP(143), POPS(995), IMAPS(993)
* Kompira からメール送信： SMTP(25)
* Kompira から外部機器へのアクセス： ssh(22), winrm(5985)
* Kompira から外部 API の呼び出し： http(80), https(443)

## ライセンス

[使用許諾契約書](https://bitbucket.org/kompira/package/wiki/LICENSE "ライセンス")に同意の上、ダウンロードページからダウンロードして下さい。

## ニュース

新規リリース情報など、ニューストピックスは[こちら](https://bitbucket.org/kompira/package/wiki/News "ニュース")をご参照ください。