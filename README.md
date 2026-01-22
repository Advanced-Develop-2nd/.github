# ようこそ

## 📖 運用ガイドライン (Portal Site)

プロジェクトの運用ルール、アーキテクチャ、開発フローは以下のGitHub Pagesで公開しています。  
👉 **[エンジニアリング・ガイドライン (GitHub Pages)](https://Advanced-Develop-2nd.github.io/.github/)**
(※ URLはSettings > Pagesの設定後に確定します)

## 🛠 管理者用ツール (Admin Tools)

プロジェクトの立ち上げ・構成変更を行う自動化スクリプトです。  
詳細は [管理者ガイド](https://tinayrum.github.io/.github/admin/) を参照してください。  

### コマンド一覧
| 目的 | スクリプト | コマンド例 |
| :--- | :--- | :--- |
| **新規PJ立ち上げ** | `setup_project.sh` | `./tools/setup_project.sh MobilityOps_portal MobilityOps_app_console` |
| **アプリ追加** | `add_app.sh` | `./tools/add_app.sh MobilityOps_portal MobilityOps_edge_control` |

### 前提条件
* `tools/.secret_pat` に管理者権限を持つPATが保存されていること。
* `gh` (GitHub CLI) がインストールされていること。

## ディレクトリ構成

```tree
.
├── README.md
├── docs
│   ├── admin.md
│   ├── developer.md
│   ├── index.md
│   └── tool.md
├── mkdocs.yml
├── profile
│   └── README.md
├── requirements.txt
└── tools
    ├── .secret_pat    # (Git管理外: ここにPATを保存)
    ├── add_app.sh
    └── setup_project.sh
```

## Clone後の初期設定

1. `.secret_pat` ファイルを `tools` ディレクトリ内に作成し、管理者用PATを保存してください。

   ```bash
   echo "ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" > tools/.secret_pat
   ```

2. `setup_project.sh` と `add_app.sh` に実行権限を付与します。

   ```bash
    chmod +x tools/setup_project.sh tools/add_app.sh
    ```

## README.mdについて

`profile/README.md` は当組織のナレッジ共有型プロジェクト運用ポータルのガイドラインとリソースをまとめたドキュメントです。  
このファイルを参照して、プロジェクトの立ち上げや運用方法を理解してください。