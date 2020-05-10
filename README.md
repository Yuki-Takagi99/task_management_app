# このアプリについて

このアプリはタスクを管理するアプリです。
タスクには優先順位、ステータス、ラベルを付加し、登録することが可能です。

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

### usersテーブル
#### モデル名:User

カラム名        | データ型 | limit     | null  | default
----------------|----------|-----------|-------|--------
name            | string   | 30文字    | false | なし
email           | string   | 255文字   | false | なし
password_digest | string   | 6文字以上 | false | なし
admin           | boolean  | なし      | false | false
created_at      | datetime | なし      | false | なし
updated_at      | datetime | なし      | false | なし

### labelsテーブル
#### モデル名:Label

カラム名        | データ型 | limit     | null  | default
----------------|----------|-----------|-------|--------
name            | string   | なし    | false | なし
created_at      | datetime | なし      | false | なし
updated_at      | datetime | なし      | false | なし

### labellingsテーブル
#### モデル名:Labelling

カラム名   | データ型 | limit | null  | default
-----------|----------|-------|-------|--------
task_id    | bigint   | なし  | なし  | なし
label_id   | bigint   | なし  | なし  | なし
created_at | datetime | なし  | false | なし
updated_at | datetime | なし  | false | なし

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
