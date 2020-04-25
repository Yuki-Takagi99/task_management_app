# このアプリについて

このアプリはタスクを管理するアプリです。

## バージョン
  - Ruby 2.6.5
  - Rails 5.2.4.2
  - PostgreSQL 12.1

## データベース
### tasksテーブル
#### モデル名:Task

カラム名    | データ型 | limit  | null  | default
------------|----------|--------|-------|--------
title       | string   | 30文字 | false | なし
description | text     | なし   | false | なし
created_at  | datetime | なし   | false | なし
updated_at  | datetime | なし   | false | なし
