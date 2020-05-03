# このアプリについて

このアプリはタスクを管理するアプリです。

## バージョン
  - Ruby 2.6.5
  - Rails 5.2.4.2
  - PostgreSQL 12.1

## データベース
### tasksテーブル
#### モデル名:Task

カラム名     | データ型 | limit  | null  | default
-------------|----------|--------|-------|--------
title        | string   | 30文字 | false | なし
description  | text     | なし   | false | なし
end_deadline | datetime | なし   | false | now()
status       | integer   | なし   | false | 未着手
priority     | integer  | なし   | false | 高
created_at   | datetime | なし   | false | なし
updated_at   | datetime | なし   | false | なし

## herokuへのデプロイ手順

1. アセットプリコンパイルを実施
```
$ rails assets:precompile RAILS_ENV=production
```
2. git add, commitを実施
```
$ git add .
$ git commit -m "コミットメッセージ"
```
3. herokuにアプリケーションを作成
```
$ heroku create
```
4. herokuにデプロイ
```
$ git push heroku master
```  
5. データベースのmigrateを実施
```
$ heroku run rails db:migrate
```
6. 以下のコマンドを実施するか、直接URLを指定し、アクセスする
```
$ heroku open
```
または、
https://sheltered-everglades-15308.herokuapp.com にアクセス
