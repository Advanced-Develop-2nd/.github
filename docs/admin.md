# 管理者向けガイド (Project Setup)

プロジェクトの立ち上げやアプリ追加は、**すべて自動化スクリプト**で行います。
手動でのリポジトリ作成やSubtreeコマンドは原則禁止です。

## 🛠 準備

管理リポジトリ (`.github`) をローカルにCloneし、`.secret_pat` を設定してください。

1. `tools/.secret_pat` ファイルを作成。
2. 管理者権限を持つ **GitHub PAT** (repo, workflow) を記述して保存。
   (Git管理外ファイルのため安全です)

## 1. 新規プロジェクトの立ち上げ

Portalと最初のAppを作成し、連携させます。

```bash
# 使用法: ./tools/setup_project.sh <Portal名> <App名>
./tools/setup_project.sh MobilityOps_portal MobilityOps_app_console
```

## 2. アプリの追加

既存のPortalに２つ目以降のリポジトリを追加します。

```bash
# 使用法: ./tools/add_app.sh <既存Portal名> <新規App名>
./tools/add_app.sh MobilityOps_portal MobilityOps_edge_control
```

## ⚠️ トラブルシューティング

- **認証エラー**: `gh auth login` の再実行、または `.secret_pat` の更新を確認してください。
- **Subtree競合**: 親リポジトリ側で直接 `apps/` 配下をいじってしまった可能性があります。原則、親での編集は禁止です。