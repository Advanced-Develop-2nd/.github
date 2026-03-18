# ツール仕様・運用フロー

---

## 配下スクリプト一覧

| スクリプト | 概要 |
|:---|:---|
| setup_portal.sh | Portalリポジトリ新規作成 |
| add_app.sh | PortalリポジトリへのApp追加 |
| setup_app.sh | App単体リポジトリ新規作成 |

## 使い方・運用フロー

!!! example "実行例"
	```bash
	./tools/setup_portal.sh <Portal名>
	./tools/add_app.sh <Portal名> <App名>
	./tools/setup_app.sh <App名>
	```

!!! warning "運用上の注意点"
	- PAT管理、権限、エラー時の対処など

---

詳細な仕様は各スクリプトの先頭コメントやREADMEも参照してください。
## coming soon...