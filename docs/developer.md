# 開発者ガイド

## 1. ブランチ命名規則

!!! note "Prefix運用"
	- feature/、bugfix/、hotfix/、release/、docs/、chore/ など
	- hotfix/はmain直マージ、必要に応じdevelopへcherry-pick
	- ブランチ名は自動化ツールが判別しやすいようPrefixを厳守

## 2. コミットメッセージ規約

!!! tip "Conventional Commits形式"
	- `type(scope): subject` 例: `feat(api): add login`
	- type例: feat, fix, docs, chore, refactor, test, ci
	- scopeは任意、subjectは簡潔に

## 3. Issue・Pull Request 運用

!!! example "運用ポイント"
	- `.github/ISSUE_TEMPLATE/` のテンプレートを活用
	- `.github/pull_request_template.md` でレビューチェックリストを活用
	- Issueは必ずGitHub上で作成
	- PRはmain直Push禁止、必ずレビューを経由

## 4. コードレビュー

!!! info "レビューの進め方"
	- 変更内容の品質・一貫性を重視
	- 明確な説明・レビューチェックリストを記載
	- 建設的なフィードバックを心がける

## 5. ドキュメント管理

!!! info "Docs as Code原則"
	- コード修正時はdocs/も必ず更新
	- ドキュメントのみのPRも可
	- コミットメッセージに `docs:` を明記
	- ドキュメント責任者・レビュワー明確化（大規模PJの場合）

## 6. CI/CD・セキュリティ

!!! tip "CI/CD・セキュリティ運用"
	- PR作成時に自動テスト・Lint・セキュリティスキャンを実行
	- Secret管理（GitHub ActionsのsecretsやDependabot alerts等）を徹底
	- mainブランチへのデプロイはCI経由のみ

## 7. コミュニケーション

!!! tip "推奨"
	- Issue/PRコメントは敬意を持って建設的に
	- Discussionsやチャットツールも活用

---

## 日々の開発フロー例

1. ブランチ作成
	```bash
	git checkout -b feature/login-screen
	```
2. 実装 & ドキュメント更新
	```bash
	# コードとドキュメントはセットでコミット
	git add src/login.ts docs/specs.md
	git commit -m "feat(auth): login implementation and docs update"
	```
3. PR作成 & マージ
	- GitHub上でPRを作成
	- CI(Lint/Test)が通っていることを確認
	- マージ後、自動的にPortalへ同期

## ディレクトリ構成例

```text
RepoRoot/
├── .github/      # CI設定
├── src/          # ソースコード
├── docs/         # ドキュメント
│   ├── index.md
│   └── images/
└── mkdocs.yml    # ドキュメント設定
```

