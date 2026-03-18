# 管理者ガイド

---

## 1. リポジトリの立ち上げ手順

!!! warning "重要"
    - すべてのリポジトリは自動化スクリプトで作成してください。
    - 手動でのリポジトリ作成やSubtreeコマンドの直接使用は禁止です。
    - 事前に tools/.secret_pat に管理者権限を持つGitHub PATを設定してください。

=== "Portal新規作成"
    ```bash
    ./tools/setup_portal.sh <Portal名>
    ```

=== "App追加"
    ```bash
    ./tools/add_app.sh <Portal名> <App名>
    ```

=== "App単体新規作成"
    ```bash
    ./tools/setup_app.sh <App名>
    ```

## 2. テンプレート管理・更新

!!! info "テンプレートリポジトリ"
    - temp_app, temp_portal の構成と運用
    - テンプレートの更新・品質担保フロー

## 3. CI/CD・セキュリティ・Secret管理

!!! example "設計例・ポイント"
    - GitHub Actionsワークフロー設計例
    - セキュリティスキャン・Secret管理のポイント

## 4. ツール利用

| スクリプト | 概要 |
|:---|:---|
| setup_portal.sh | Portalリポジトリ新規作成 |
| add_app.sh | PortalリポジトリへのApp追加 |
| setup_app.sh | App単体リポジトリ新規作成 |

---

詳細な手順や注意点は、各スクリプトやテンプレートリポジトリREADMEも参照してください。

## 付録: 準備・トラブルシューティング

### PATの準備
!!! info "PATの準備"
    1. 管理リポジトリ (`.github`) をローカルにClone
    2. `tools/.secret_pat` ファイルを作成し、管理者権限を持つ **GitHub PAT** (repo, workflow) を記述して保存（Git管理外ファイルのため安全）

### トラブルシューティング
!!! warning "認証エラー"
    - `gh auth login` の再実行、または `.secret_pat` の更新を確認してください。

!!! warning "Subtree競合"
    - 親リポジトリ側で直接 `apps/` 配下を編集してしまった可能性があります。原則、親での編集は禁止です。