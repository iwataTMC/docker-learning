# 実行環境
- MacBook Pro (Apple Silicon):Memory 24GB
- Docker Desktop for Mac (Apple Silicon)
- Docker version 26.0.0, build 2ae903e

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
