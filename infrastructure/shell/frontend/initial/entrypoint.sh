#!/bin/sh

echo "初期構築モード: コンテナは起動中ですが処理は未実行です"
echo "fe-initを実行してください。"

# 無限待機（ホスト側で手動作業を許容）
tail -f /dev/null
