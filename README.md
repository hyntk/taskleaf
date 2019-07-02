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

- labels

| カラム名  | データ型 |
|:---|:---|
|label|string |

- statuses

| カラム名  | データ型 |
|:---|:---|
|status|string |

- task_statuses

| カラム名  | データ型 |
|:---|:---|
|task_id|integer |
|status_id|integer |

- task_labels

| カラム名  | データ型 |
|:---|:---|
|task_id|integer |
|label_id|integer |