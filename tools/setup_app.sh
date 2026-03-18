#!/bin/bash

# ==========================================
# アプリ単体リポジトリ作成自動化スクリプト (setup_project.shベース)
# ==========================================

set -e

# 設定値
ORG_NAME="tinayrum"
TEMPLATE_APP="template_app"

# 引数チェック
if [ $# -ne 1 ]; then
    echo "使用法: ./setup_app_only.sh <新規アプリ名>"
    echo "例: ./setup_app_only.sh ProjectA_app"
    exit 1
fi

APP_NAME=$1

# GitHub CLI ログイン確認
if ! gh auth status >/dev/null 2>&1; then
    echo "エラー: GitHub CLI (gh) にログインしていません。"
    exit 1
fi

gh auth setup-git

# ========================================================
# PAT取得ロジック (秘密ファイル -> 手動入力)
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
    echo "エラー: PATが取得できませんでした。処理を中止します。"
    exit 1
fi

# ========================================================
# ★作業ディレクトリの移動: ワークスペースルートへ
# ========================================================
WORK_DIR="$SCRIPT_DIR/../.."
cd "$WORK_DIR" || exit
echo "作業場所を移動しました: $(pwd)"

echo "🚀 アプリ単体リポジトリ立ち上げを開始します..."

# 1. リポジトリ作成
echo "Creating App Repository..."
gh repo create "$ORG_NAME/$APP_NAME" --template "$ORG_NAME/$TEMPLATE_APP" --private --clone

# 2. Secret 設定
echo "Setting Secrets..."
gh secret set ORG_ADMIN_TOKEN -b "$ADMIN_TOKEN" --repo "$ORG_NAME/$APP_NAME"

# 3. 初期ファイル追加
cd "$APP_NAME"
git add .
git commit -m "Initial commit for app-only repository"
git push origin main

cd ..
# rm -rf "$APP_NAME" # 必要に応じて

echo "=========================================="
echo "✅ セットアップ完了！"
echo "  App: https://github.com/$ORG_NAME/$APP_NAME"
echo "=========================================="