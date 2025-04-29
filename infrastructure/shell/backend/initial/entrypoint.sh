#!/bin/bash

# Railsアプリがまだない場合は無限待機
if [ ! -f "config.ru" ]; then
  echo "コンテナ内で rails new を実行してください。"
  tail -f /dev/null
else
  echo "Railsアプリを起動します..."
  bundle exec rails server -b 0.0.0.0
fi