# README

## テーブルとスキーマ
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