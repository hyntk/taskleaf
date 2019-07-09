# README

# How to deploying Rails App on Heroku

### Herokuに直接デプロイする場合

1) ローカル環境の初期設定
---
- ローカル環境でheroku Toolbeltをインストール
```
wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh
```
- Herokuにログインする
```
heroku login
```

2) herokuに新しいアプリケーションを作成
---
```
heroku create
```
3) herokuにデプロイする
---
```
git push heroku master
```

### ローカル環境からGitHubにデプロイすると自動的にHerokuにデプロイされるようにする場合

1) Herokuのダッシュボードにログインする
2) ダッシュボードから対象のアプリを開く
3) メニューの中の「deploy]へ
4) DeploymentMethodをGithubへ変更
5) App connnected to Githubの項目で対象のレポジトリ、 masterブランチを選択
6) Automatic Deployをenableへ変更



# テーブルとスキーマ
---
- users

| カラム名  | データ型 |
|:---|:---|
|name|string |
|email |string |
|password_digest |string |

- tasks

| カラム名  | データ型 |
|:---|:---|
|content|text |
|status|string |
|priority|string |

- labels

| カラム名  | データ型 |
|:---|:---|
|name|string |

- task_labels

| カラム名  | データ型 |
|:---|:---|
|task_id|integer |
|label_id|integer |