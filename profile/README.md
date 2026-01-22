# Advanced-Develop-2nd Engineering

## 🚀 ナレッジ共有型プロジェクト運用ポータル
当組織では「Docs as Code」を推進し、コードとドキュメントの完全一致を目指します。  
Git Subtree と GitHub Actions を活用した自動連携フローにより、属人化を排除し、常に最新のナレッジが共有される状態を保ちます。  

---

### 📚 運用ガイドライン & リソース
開発ルールや運用フローは、リポジトリ内の以下のドキュメントを参照してください。

#### 📖 運用ガイドライン (Portal Site)

プロジェクトの運用ルール、アーキテクチャ、開発フローは以下のGitHub Pagesで公開しています。  
👉 **[エンジニアリング・ガイドライン (GitHub Pages)](https://Advanced-Develop-2nd.github.io/.github/)**
(※ URLはSettings > Pagesの設定後に確定します)

---

### ⚡ プロジェクト立ち上げ手順 (管理者・PM向け)
新規プロジェクトを開始する際は、**手動でリポジトリを作成せず**、以下の自動化スクリプトを使用してください。  
「リポジトリ作成」「Secret(PAT)設定」「Subtree連携」を一括で自動実行します。

#### 1. 準備 (初回のみ)
この管理リポジトリをローカルにクローンし、スクリプトに実行権限を付与します。
```bash
gh repo clone Advanced-Develop-2nd/.github
cd .github
chmod +x tools/setup_project.sh
```

#### 2. セットアップ実行

```bash
# 使用法： ./tools/setup_project.sh <新規ポータル名> <新規アプリ名>
./tools/setup_project.sh ProjectA_portal ProjectA_app
```

*※ 実行中に管理者用PAT（Personal Access Token）の入力を求められます。*  
*※ 作成したPATは安全に保管してください。子リポジトリの追加などで再度求められます*

#### 3. 子リポジトリの追加

```bash
# 使用法： ./tools/add_app.sh <既存ポータル名> <新規アプリ名>
./tools/add_app.sh ProjectA_portal ProjectB_app
```

---

### 🔄 自動連携アーキテクチャ概要

コスト０円（Freeプラン）かつセキュアな運用のために、以下のフローで自動化しています。

1. **Dev(子リポジトリ)**： 開発者がPRをマージ -> 親リポジトリへ「更新通知」を送信。
2. **Sync(親リポジトリ)**： 通知を受信 -> 自動で `git subtree pull` を実行し、ドキュメントを取り込む。
3. **Check**： 親リポ塩リに「同期用PR」が自動生成されるので、管理者がマージする。

---

### 🏷 ブランチ命名規則

自動化ツールがバージョンアップの種類を判別できるよう、以下のPrefixを厳守してください。  
マージ完了後のブランチは、GitHubの設定により、**即時削除**されます。

| Prefix | 用途 | SemVer影響 | 例 |
| :--- | :--- | :--- | :--- |
| `feature/` | 新機能追加 | Minor | `feature/add-login-function` |
| `bugfix/` | バグ修正 | Patch | `bugfix/fix-crash-on-startup` |
| `hotfix/` | 緊急修正 | Patch | `hotfix/fix-security-vulnerability` |
| `release/` | リリース準備 | Patch/Minor | `release/v1.2.0-prep` |
| `docs/` | ドキュメント更新のみ | Patch | `docs/update-api-docs` |
| `chore/` | その他メンテナンス | Patch | `chore/update-dependencies` |

---

### 🆘 緊急連絡先

- システム管理者： [藤平](https://github.com/fujihira-azapaeng)
- インシデント報告：[tomoki-fujihira@azapa-eng.co.jp](mailto:)