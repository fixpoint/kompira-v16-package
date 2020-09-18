# Kompira : シンプルで軽量な次世代運用自動化プラットフォーム

## Kompiraとは

KompiraはIT運用管理業務の自動化を支援するための基盤システムです。
ジョブフローを記述することで、様々な運用業務、管理業務、さらには障害の復旧処理まで自動化することができます。

## インストール

パッケージを展開したら root 権限で `./install.sh` を実行してください（インストール先のサーバは、OS新規インストール状態であることを推奨します）。
インストールに成功したサーバにブラウザでアクセスするとログイン画面が表示されますので、以下のアカウントでログインすることで Kompira をはじめることができます。

* ユーザ名: `root`
* パスワード: `root`

ログイン後の画面の右上にある「ヘルプ」をクリックすると、オンラインマニュアルが表示されますので使い方の参考にしてください。

## 動作環境

Kompira 1.6 の動作環境は以下の通りです。

### 対応システム

* x86_64
* CentOS/RHEL 7.6以上, 8.x (8.X 推奨)
* Python 3.6

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
* Kompira からメール送信： SMTP(25), SMTP-TLS(587), SMTPS(465)
* Kompira から外部機器へのアクセス： ssh(22), winrm(5985)
* Kompira から外部 API の呼び出し： http(80), https(443)

#### 冗長構成の場合の ACT/SBY 間通信

* rsync(873)
* rabbitmq(4369, 5672, 25672)
* postgresql(5432)
* pcsd(2224)
* corosync(UDP/5404, UDP/5405)

## Kompira ライセンス

[使用許諾契約書](https://bitbucket.org/kompira/package/raw/818f1e4599f9aa5009f52e133bc11568522b37fe/LICENSE.pdf)に同意の上、ダウンロードページからダウンロードして下さい。

Kompira の使用には、ライセンス登録が必要です。詳しくは [license@kompira.jp](mailto:license@kompira.jp) までご連絡ください。

## Kompira ニュース

Kompira の最新情報については [Kompiraニュース](https://bitbucket.org/kompira/package/wiki/News) をご参照ください。

## Kompira 運用自動化コラム

Kompira の実践的な使い方やジョブフローの書き方については [運用自動化コラム](https://www.kompira.jp/column/) を参考にしてみてください。
