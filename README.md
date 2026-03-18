# QuickStart - プロジェクト運用・開発ガイド

---

## 📖 運用ガイドライン

プロジェクトの運用ルール・アーキテクチャ・開発フローは [GitHub Pages](https://Advanced-Develop-2nd.github.io/.github/) で公開しています。

- [Home](https://Advanced-Develop-2nd.github.io/.github/)
- [管理者ガイド](https://Advanced-Develop-2nd.github.io/.github/admin/)
- [開発者ガイド](https://Advanced-Develop-2nd.github.io/.github/developer/)
- [ツール仕様](https://Advanced-Develop-2nd.github.io/.github/tools/)
- [アプリ単体運用ガイド](https://Advanced-Develop-2nd.github.io/.github/app_standalone/)

---

## 🛠 管理者用ツール

プロジェクトの立ち上げ・構成変更は自動化スクリプトで行います。詳細は「管理者ガイド」を参照してください。

| 目的 | スクリプト | コマンド例 |
| :--- | :--- | :--- |
| **Portal新規作成** | `setup_portal.sh` | `./tools/setup_portal.sh MobilityOps_portal` |
| **アプリ追加** | `add_app.sh` | `./tools/add_app.sh MobilityOps_portal MobilityOps_edge_control` |
| **App単体新規作成** | `setup_app.sh` | `./tools/setup_app.sh MyApp` |

### 前提条件
- `tools/.secret_pat` に管理者権限を持つPATが保存されていること
- `gh` (GitHub CLI) がインストールされていること

---

## 🚀 開発フロー（抜粋）

1. ブランチ作成
    ```bash
    git checkout -b feature/xxxx
    ```
2. 実装 & ドキュメント更新
    ```bash
    git add src/xxx docs/yyy
    git commit -m "feat(scope): add feature and docs"
    ```
3. PR作成 & マージ
    - GitHub上でPRを作成
    - CI(Lint/Test)が通っていることを確認
    - main直Pushは禁止、必ずレビューを経由

---

## ディレクトリ構成例

```text
RepoRoot/
├── .github/      # CI/CD・Issue/PRテンプレート
├── src/          # ソースコード
├── docs/         # ドキュメント
│   ├── index.md
│   └── images/
├── tests/        # テストコード
├── mkdocs.yml    # ドキュメント設定
├── requirements.txt
├── profile/
│   └── README.md
└── tools/
    ├── .secret_pat    # (Git管理外: ここにPATを保存)
    ├── add_app.sh
    ├── setup_portal.sh
    ├── setup_app.sh
```

---

## 初期セットアップ手順

1. `.secret_pat` ファイルを `tools` ディレクトリ内に作成し、管理者用PATを保存
    ```bash
    echo "ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" > tools/.secret_pat
    ```
2. スクリプトに実行権限を付与
    ```bash
    chmod +x tools/setup_portal.sh tools/add_app.sh tools/setup_app.sh
    ```

---

## 補足

`profile/README.md` には組織全体のガイドラインやリソースをまとめています。プロジェクト運用の全体像を把握したい場合はそちらも参照してください。