# 開発者向けガイド (Developer Handbook)

## 📝 ゴールデンルール
1. **Docs as Code**: コードを修正したら、同じPRで必ずドキュメント (`docs/`) も修正する。
2. **Naming**: ブランチ名のPrefix (`feature/`, `bugfix/`) を守る。
3. **No Direct Push**: `main` ブランチへの直接Pushは禁止。必ずPRを経由する。

## 🔄 日々の開発フロー

### 1. ブランチ作成
```bash
git checkout -b feature/login-screen
```

### 2. 実装 & ドキュメント更新

ソースコードの修正に合わせて、`docs/index.md` や仕様書を更新します。

```bash
# コードとドキュメントはセットでコミット
git add src/login.ts docs/specs.md
git commit -m "feat: login implementation and docs update"
```

### 3. PR作成 & マージ

GitHub上でPRを作成します。

- CI(Lint/Test) が通っていることを確認。
- マージされると、自動的にPortalへ同期されます。

## 📂 ディレクトリ構成

```tree
RepoRoot/
├── .github/      # CI設定 (触らない)
├── src/          # ソースコード
├── docs/         # ★ここにドキュメントを書く
│   ├── index.md
│   └── images/
└── mkdocs.yml    # ドキュメント設定
```

