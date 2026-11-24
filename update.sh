#!/usr/bin/env bash
# 南方国际看板 — 一键更新并推送到 GitHub Pages
# 用法：1) 把最新的 dashboards/index.html 复制到本目录；2) GH_TOKEN=xxx bash update.sh "更新说明"
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DIR"

if [ -z "$GH_TOKEN" ]; then
  echo "错误：请先设置环境变量 GH_TOKEN（GitHub Personal Access Token）"
  echo "用法：GH_TOKEN=ghp_xxx bash update.sh \"更新说明\""
  exit 1
fi

MSG="${1:-更新南方国际看板}"

# 确认源文件比已提交版本有变化
if git diff --quiet && git diff --cached --quiet; then
  echo "没有检测到文件变化，无需提交。"
  exit 0
fi

git add -A
git -c user.name="xiongwenqianghub" -c user.email="xiongwenqiang@southernfund.com" commit -m "$MSG"

# 使用临时 token 推送，凭据不写入 git 配置
git push "https://xiongwenqianghub:${GH_TOKEN}@github.com/xiongwenqianghub/csam_gjkb.git" main
echo "推送完成。GitHub Pages 通常 1-2 分钟后自动更新：https://xiongwenqianghub.github.io/csam_gjkb/"
