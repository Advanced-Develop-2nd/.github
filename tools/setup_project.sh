#!/bin/bash

# ==========================================
# プロジェクト立ち上げ自動化スクリプト (修正版)
# ==========================================

# エラーが発生したら即停止する設定を追加
set -e

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

# GitHub CLI ログイン確認
if ! gh auth status >/dev/null 2>&1; then
    echo "エラー: GitHub CLI (gh) にログインしていません。"
    exit 1
fi

# git credentialの設定 (重要: Privateリポジトリ操作のため)
gh auth setup-git

echo "--------------------------------------------------"
echo "管理者用PATを入力してください (Secret登録用)"
echo "--------------------------------------------------"
read -sp "PAT: " ADMIN_TOKEN
echo ""

if [ -z "$ADMIN_TOKEN" ]; then
    echo "エラー: PATが入力されませんでした。"
    exit 1
fi

echo "🚀 プロジェクト立ち上げを開始します..."

# 1. リポジトリ作成
echo "Creating Portal Repository..."
gh repo create "$ORG_NAME/$PORTAL_NAME" --template "$ORG_NAME/$TEMPLATE_PORTAL" --private --clone

echo "Creating App Repository..."
gh repo create "$ORG_NAME/$APP_NAME" --template "$ORG_NAME/$TEMPLATE_APP" --private

# 2. Secret & Variable 設定
echo "Setting Secrets & Variables..."
gh secret set ORG_ADMIN_TOKEN -b "$ADMIN_TOKEN" --repo "$ORG_NAME/$PORTAL_NAME"
gh secret set ORG_ADMIN_TOKEN -b "$ADMIN_TOKEN" --repo "$ORG_NAME/$APP_NAME"
gh variable set PORTAL_REPO_NAME --body "$PORTAL_NAME" --repo "$ORG_NAME/$APP_NAME"

# 3. Subtree連携
echo "Configuring Subtree..."
cd "$PORTAL_NAME"

# リモート追加
git remote add "$APP_NAME" "https://github.com/$ORG_NAME/$APP_NAME.git"

# ★修正点: まずFetchして接続確認を行う
echo "Fetching app repository..."
git fetch "$APP_NAME" main

# Subtree追加
echo "Adding subtree..."
git subtree add --prefix="apps/$APP_NAME" "$APP_NAME" main --squash -m "init: link $APP_NAME"

# Push
git push origin main

cd ..
# rm -rf "$PORTAL_NAME" # 確認のため残すことを推奨

echo "=========================================="
echo "✅ セットアップ完了！"
echo "  Portal: https://github.com/$ORG_NAME/$PORTAL_NAME"
echo "  App:    https://github.com/$ORG_NAME/$APP_NAME"
echo "=========================================="