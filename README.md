# 実行環境
- MacBook Pro (Apple Silicon):Memory 24GB
- Docker Desktop for Mac (Apple Silicon)
- Docker version 26.0.0, build 2ae903e

# Dockerfile構成
このDockerfileは、Ubuntuイメージをベースにして、開発環境を構築するためのものです。主な機能は以下の通りです。

1. 基本的なツールのインストール
- sudo、net-tools、binutils、file、git、vim、telnet、netcat、wget、curl、lsof、iputils-ping、iproute2、ethtool、traceroute
- Python3、pip、jupyterlab、grpcio関連ライブラリ
2. Go言語環境の構築
- 指定のGo言語バージョンをインストール
- Goコマンドへのシンボリックリンクを作成
- 関連ツールのインストール (gonb、goimports、gopls、protoc-gen-go、protoc-gen-go-grpc、grpcurl)
3. Java開発環境の構築
- 指定のJDKバージョンをインストール
- gRPCおよびProtocolBuffersライブラリをインストール
- grpc-servicesライブラリをダウンロード
4. ユーザー作成と設定
- 指定のUID/GIDでグループとユーザーを作成
- sudoの権限を付与
- ユーザーのホームディレクトリを作成
5. [JupyterLab](https://jupyter.org/)設定
- 設定ファイルの生成とカスタマイズ
- Go環境の設定
- Go環境変数の設定
- jbangのインストールとJupyter Kernelの設定
7. キャッシュとテンポラリファイルの削除
- pip cacheとaptキャッシュの削除
8. Expose
- ポート8888を公開

Go、Java、Python、gRPC、ProtocolBuffersなどの開発環境を構築し、JupyterLabを使ったインタラクティブな開発が可能な環境を用意しています。




# コンテナ起動手順
1. [Docker Desktop](https://matsuand.github.io/docs.docker.jp.onthefly/desktop/mac/install/)をインストールする。
2. Docker Desktopを起動する。
   1. Statusが`Docker Desktop is Running`であることを確認する。
3. ターミナルを起動する。
4. `git clone　https://github.com/iwataTMC/docker-learning.git`で本リポジトリをクローンする。
5. `cd docker-learning`でリポジトリに移動する。
6. `sh docker-build.sh`でDockerイメージをビルドする。
7. `sh docker-run.sh`でDockerコンテナを起動する。

# コンテナを終了する
1. コンテナを終了する。
   1. コンテナを終了するには、コンテナ内で`exit`を実行する。

# コンテナ内で変更した内容を保存する
1. コンテナを起動した状態で別のターミナルを開く。
2. `docker ps`でコンテナIDまたはコンテナ名を確認する。
3. `docker commit <コンテナIDまたはコンテナ名> <イメージ名>:<タグ>`でイメージを作成する。（タグ名は任意、`latest`を指定すると最新のイメージとして扱われる、`v1`などバージョンを指定することもできる）
   - 例: `docker commit network network:latest`

# コンテナ内でJupyterLabを起動する
1. コンテナ内で`jupyter-lab --ip=0.0.0.0 --port=8888`でJupyterLabを起動する。
2. `http://localhost:8888`にアクセスする。


# ホスト側のディレクトリをコンテナ内にマウントする方法
```
docker -v /Users/<host user>/<user-dir>:/home/<docker user>/<docker-user-dir> -ti --rm --name network -p 8888:8888 network:latest /bin/bash
```

# Appendix
Linuxを学習するだけなら、本リポジトリのDockerfileではなく以下のイメージを利用することをオススメします。
> 以下のイメージはDocker Hubに公開されている。
- [busybox](https://hub.docker.com/_/busybox)（←オススメイメージ、よく使うコマンド詰め合わせセット）

1. コンテナ起動
```
docker run -it --rm --name busybox busybox
```
2. 変更をコミットする（別のターミナルで）
```
docker commit busybox busybox:latest
```
> 変更内容が不要であれば、コミットせずにコンテナを終了する。
3. コンテナを終了する
```
exit
```
