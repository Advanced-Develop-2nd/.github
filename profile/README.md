# Advanced-Develop-2nd Engineering

[運用ガイドラインページ](https://advanced-develop-2nd.github.io/.github/)

---

## 🚀 ナレッジ共有型プロジェクト運用ポータル

当組織は「Docs as Code」を推進し、コードとドキュメントの完全一致・自動連携を徹底しています。
GitHub ActionsとGit Subtreeによる自動化で、属人化を排除し、常に最新のナレッジ共有を実現します。

---

## 📚 運用ガイドライン & リソース

- [運用ガイドライン (GitHub Pages)](https://Advanced-Develop-2nd.github.io/.github/)
- [管理者ガイド](https://Advanced-Develop-2nd.github.io/.github/admin/)
- [開発者ガイド](https://Advanced-Develop-2nd.github.io/.github/developer/)
- [ツール仕様](https://Advanced-Develop-2nd.github.io/.github/tools/)
- [アプリ単体運用ガイド](https://Advanced-Develop-2nd.github.io/.github/app_standalone/)

---

## ⚡ プロジェクト立ち上げ・運用フロー

### 1. 準備
1. 管理リポジトリをCloneし、`tools/.secret_pat` に管理者PATを保存
2. スクリプトに実行権限を付与
	```bash
	chmod +x tools/setup_portal.sh tools/add_app.sh tools/setup_app.sh
	```

### 2. Portal/Appリポジトリ作成
```bash
# Portal新規作成
./tools/setup_portal.sh ProjectA_portal
# App追加
./tools/add_app.sh ProjectA_portal ProjectB_app
# App単体新規作成
./tools/setup_app.sh MyApp
```

---

## 🔄 自動連携アーキテクチャ概要

1. **Appリポジトリ**: 開発者がPRをマージ→親リポジトリへ「更新通知」
2. **Portalリポジトリ**: 通知受信→自動で `git subtree pull` 実行
3. **管理者**: Portal側で同期用PRをマージ

---

## 🏷 ブランチ命名規則

| Prefix | 用途 | SemVer影響 | 例 |
| :--- | :--- | :--- | :--- |
| `main` | メインブランチ | なし | `main` |
| `develop` | ステージングブランチ | なし | `develop` |
| `feature/` | 新機能追加 | Minor | `feature/add-login-function` |
| `bugfix/` | バグ修正 | Patch | `bugfix/fix-crash-on-startup` |
| `hotfix/` | 緊急修正 | Patch | `hotfix/fix-security-vulnerability` |
| `release/` | リリース準備 | Patch/Minor | `release/v1.2.0-prep` |
| `docs/` | ドキュメント更新のみ | Patch | `docs/update-api-docs` |
| `chore/` | その他メンテナンス | Patch | `chore/update-dependencies` |

---

## 📝 開発・運用のポイント

- **Docs as Code**: コード修正時はdocs/も必ず更新
- **main直Push禁止**: PR経由でマージ
- **CI/CD必須**: GitHub Actions等で自動テスト・デプロイ
- **README.md整備**: QuickStart・開発手順・依存関係を明記
- **テンプレート活用**: Issue/PRテンプレート・CI/CDワークフローを標準化

---

## 🆘 緊急連絡先

- システム管理者： [藤平](https://github.com/fujihira-azapaeng)
- インシデント報告：[tomoki-fujihira@azapa-eng.co.jp](mailto:)
