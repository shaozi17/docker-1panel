#!/bin/bash

# 更新数据库
update_database() {
  if [[ -f ${PANEL_BASE_DIR}/1panel/db/1Panel.db ]]; then
    # 备份数据库文件
    cp ${PANEL_BASE_DIR}/1panel/db/1Panel.db ${PANEL_BASE_DIR}/1panel/db/1Panel.db.bak

    # 使用 sqlite3 执行更新操作
    sqlite3 ${PANEL_BASE_DIR}/1panel/db/1Panel.db <<EOF
UPDATE settings
SET value = '$PANEL_VERSION'
WHERE key = 'SystemVersion';
.exit
EOF

    echo "数据库版本已更新为 $PANEL_VERSION"
  else
    echo "警告：${PANEL_BASE_DIR}/1panel/db/1Panel.db 文件不存在" >&2
    exit 0
  fi
}

# 主函数
main() {
  if [ -n "$PANEL_VERSION" ]; then
    update_database
  fi
}

# 调用主函数
main