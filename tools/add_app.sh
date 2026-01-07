#!/bin/bash

# ==========================================
# 既存プロジェクトへのアプリ追加スクリプト
# ==========================================

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

# Secret用のPAT入力
echo "--------------------------------------------------"
echo "管理者用PAT(Personal Access Token)を入力してください。"
echo "--------------------------------------------------"
read -sp "PAT: " ADMIN_TOKEN
echo ""

if [ -z "$ADMIN_TOKEN" ]; then
    echo "エラー: PATが入力されませんでした。"
    exit 1
fi

echo "🚀 アプリケーション追加プロセスを開始します..."

# 1. アプリリポジトリの作成
echo "Creating App Repository: $APP_NAME..."
gh repo create "$ORG_NAME/$APP_NAME" --template "$ORG_NAME/$TEMPLATE_APP" --private

# 2. アプリ側にSecretと変数を設定 (これで自動連携が可能になる)
echo "Setting Secrets & Variables..."
gh secret set ORG_ADMIN_TOKEN -b "$ADMIN_TOKEN" --repo "$ORG_NAME/$APP_NAME"
# 親リポジトリ名を子に教える
gh variable set PORTAL_REPO_NAME --body "$PORTAL_NAME" --repo "$ORG_NAME/$APP_NAME"

# 3. 親リポジトリにSubtreeとして登録
echo "Configuring Subtree in Portal..."

# ポータルをクローン（既にある場合はPull）
if [ -d "$PORTAL_NAME" ]; then
    cd "$PORTAL_NAME" || exit
    git pull origin main
else
    gh repo clone "$ORG_NAME/$PORTAL_NAME"
    cd "$PORTAL_NAME" || exit
fi

# アプリリポジトリをリモートとして追加
git remote add "$APP_NAME" "https://github.com/$ORG_NAME/$APP_NAME.git"

# Subtreeとして追加 (apps/アプリ名 に配置)
git subtree add --prefix="apps/$APP_NAME" "$APP_NAME" main --squash -m "init: add new app $APP_NAME"

# 親へPush
git push origin main

# 作業用ディレクトリから抜ける
cd ..
# rm -rf "$PORTAL_NAME" # 必要に応じてクローンしたポータルを削除

echo "=========================================="
echo "✅ アプリ追加完了！"
echo "  Portal: https://github.com/$ORG_NAME/$PORTAL_NAME"
echo "  New App: https://github.com/$ORG_NAME/$APP_NAME"
echo "=========================================="