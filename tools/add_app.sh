#!/bin/bash

# ==========================================
# 既存プロジェクトへのアプリ追加スクリプト (階層修正版)
# ==========================================

set -e

# 設定値
ORG_NAME="Advanced-Develop-2nd"
TEMPLATE_APP="temp_app"

# 引数チェック
if [ $# -ne 2 ]; then
    echo "使用法: ./add_app.sh <既存ポータル名> <新規アプリ名>"
    echo "例: ./add_app.sh ProjectA_portal ProjectA_app_iOS"
    exit 1
fi

PORTAL_NAME=$1
APP_NAME=$2

# GitHub CLI ログイン確認
if ! gh auth status >/dev/null 2>&1; then
    echo "エラー: GitHub CLI (gh) にログインしていません。"
    exit 1
fi

gh auth setup-git

# ========================================================
# PAT取得ロジック
# ========================================================
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PAT_FILE="$SCRIPT_DIR/.secret_pat"

if [ -f "$PAT_FILE" ]; then
    ADMIN_TOKEN=$(cat "$PAT_FILE" | tr -d '\r\n')
    if [ -n "$ADMIN_TOKEN" ]; then
        echo "✅ 秘密ファイル(.secret_pat)からPATを自動取得しました。"
    fi
fi

if [ -z "$ADMIN_TOKEN" ]; then
    echo "--------------------------------------------------"
    echo "管理者用PAT(Personal Access Token)を入力してください。"
    echo "--------------------------------------------------"
    read -sp "PAT: " ADMIN_TOKEN
    echo ""
fi

if [ -z "$ADMIN_TOKEN" ]; then
    echo "エラー: PATが取得できませんでした。"
    exit 1
fi

# ========================================================
# ★ここが修正ポイント: 作業ディレクトリの移動
# ========================================================
WORK_DIR="$SCRIPT_DIR/../.."
cd "$WORK_DIR" || exit
echo "作業場所を移動しました: $(pwd)"

echo "🚀 アプリケーション追加プロセスを開始します..."

# 1. アプリリポジトリの作成
echo "Creating App Repository: $APP_NAME..."
gh repo create "$ORG_NAME/$APP_NAME" --template "$ORG_NAME/$TEMPLATE_APP" --private

# 2. アプリ側にSecretと変数を設定
echo "Setting Secrets & Variables..."
gh secret set ORG_ADMIN_TOKEN -b "$ADMIN_TOKEN" --repo "$ORG_NAME/$APP_NAME"
gh variable set PORTAL_REPO_NAME --body "$PORTAL_NAME" --repo "$ORG_NAME/$APP_NAME"

# 3. 親リポジトリにSubtreeとして登録
echo "Configuring Subtree in Portal..."

# ポータルをクローン（既にある場合はPull）
if [ -d "$PORTAL_NAME" ]; then
    cd "$PORTAL_NAME" || exit
    # 念のためPull
    git pull origin main
else
    gh repo clone "$ORG_NAME/$PORTAL_NAME"
    cd "$PORTAL_NAME" || exit
fi

# リモート追加 & Fetch
git remote add "$APP_NAME" "https://github.com/$ORG_NAME/$APP_NAME.git"
echo "Fetching app repository..."
git fetch "$APP_NAME" main

# Subtreeとして追加
git subtree add --prefix="apps/$APP_NAME" "$APP_NAME" main --squash -m "init: add new app $APP_NAME"

# 親へPush
git push origin main

cd ..

echo "=========================================="
echo "✅ アプリ追加完了！"
echo "  Portal: https://github.com/$ORG_NAME/$PORTAL_NAME"
echo "  New App: https://github.com/$ORG_NAME/$APP_NAME"
echo "=========================================="