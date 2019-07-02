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

- tasks_statuses

| カラム名  | データ型 |
|:---|:---|
|task_cd|integer |
|status_cd|integer |

- tasks_labels

| カラム名  | データ型 |
|:---|:---|
|task_cd|integer |
|label_cd|integer |