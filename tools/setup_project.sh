#!/bin/bash

# ==========================================
# プロジェクト立ち上げ自動化スクリプト
# Organization: Advanced-Develop-2nd
# ==========================================

# 設定値
ORG_NAME="Advanced-Develop-2nd"
TEMPLATE_PORTAL="temp_portal"
TEMPLATE_APP="temp_app"

# 引数チェック
if [ $# -ne 2 ]; then
    echo "使用法: ./setup_project.sh <新規ポータル名> <新規アプリ名>"
    echo "例: ./setup_project.sh ProjectA_portal ProjectA_app"
    exit 1
fi

PORTAL_NAME=$1
APP_NAME=$2

# GitHub CLIのログイン確認
if ! gh auth status >/dev/null 2>&1; then
    echo "エラー: GitHub CLI (gh) にログインしていません。"
    echo "'gh auth login' を実行してから再試行してください。"
    exit 1
fi

# Secret用のPAT入力（セキュリティのため実行時に入力）
echo "--------------------------------------------------"
echo "各リポジトリに登録する管理者用PAT(Personal Access Token)を入力してください。"
echo "※入力内容は画面に表示されません"
echo "--------------------------------------------------"
read -sp "PAT: " ADMIN_TOKEN
echo ""

if [ -z "$ADMIN_TOKEN" ]; then
    echo "エラー: PATが入力されませんでした。中止します。"
    exit 1
fi

echo "🚀 プロジェクト立ち上げを開始します..."

# 1. リポジトリの作成
echo "Creating Portal Repository: $PORTAL_NAME..."
gh repo create "$ORG_NAME/$PORTAL_NAME" --template "$ORG_NAME/$TEMPLATE_PORTAL" --private --clone

echo "Creating App Repository: $APP_NAME..."
gh repo create "$ORG_NAME/$APP_NAME" --template "$ORG_NAME/$TEMPLATE_APP" --private

# 2. Secret (ORG_ADMIN_TOKEN) の登録
echo "Setting Secrets..."
# 親リポジトリに登録
gh secret set ORG_ADMIN_TOKEN -b "$ADMIN_TOKEN" --repo "$ORG_NAME/$PORTAL_NAME"
# 子リポジトリに登録
gh secret set ORG_ADMIN_TOKEN -b "$ADMIN_TOKEN" --repo "$ORG_NAME/$APP_NAME"

# 3. Subtree連携 (ローカル操作)
echo "Configuring Subtree..."
cd "$PORTAL_NAME" || exit

# アプリリポジトリをリモートとして追加
git remote add "$APP_NAME" "https://github.com/$ORG_NAME/$APP_NAME.git"

# Subtreeとして追加 (Squashオプション付き)
# 初回は履歴がないためエラーになる場合を考慮し、空コミットがある前提か、または単に追加を試みる
git subtree add --prefix="apps/$APP_NAME" "$APP_NAME" main --squash -m "init: link $APP_NAME"

# 変更を親リポジトリへPush
git push origin main

cd ..
# 作業用フォルダの削除（必要に応じてコメントアウトを外してください）
# rm -rf "$PORTAL_NAME"

echo "=========================================="
echo "✅ セットアップ完了！"
echo "  Portal: https://github.com/$ORG_NAME/$PORTAL_NAME"
echo "  App:    https://github.com/$ORG_NAME/$APP_NAME"
echo "=========================================="