# ようこそ

## ディレクトリ構成

```tee
.
├── .gitignore
├── README.md
├── guidelines
│   ├── GitHubナレッジ共有型プロジェクト_統合運用ガイドライン.pdf
│   ├── Project_Name_開発スタートアップガイド.pdf
│   ├── ナレッジ共有型プロジェクト運用ガイドライン.pdf
│   ├── ナレッジ共有型プロジェクト運用手順書_テンプレート作成.pdf
│   └── ナレッジ共有型プロジェクト運用手順書_日常運用.pdf
├── profile
│   └── README.md
└── tools
    ├── .secret_pat     <- 管理者用PATを保存するファイル（Clone後に手動作成）
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
