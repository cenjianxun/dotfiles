## 使用说明

### 目录结构 （添加中……）
. dotfiles  
├── auto-bot/  # 一些通用脚本  
│       ├── kill_process.sh  # 杀进程用的  
│       └── nohup-tail.sh  # 后台启动进程并写入目录  
├── Rime/  # 鼠须管的配置  
│     ├── default.custom.yaml    
│     ├── luna_pinyin.custom.yaml  
│     ├── squirrel.custom.yaml  
│     ├── symbols.yaml  
│     └── sync.sh  # 同步这里和rime配置目录的脚本  
├── Axun.itermcolors  # iterm2的主题配置  
├── bootstrap.sh  # shell的启动  
├── config.sh  # shell的公共基本配置  
├── init.sh  # 初始化shell  
├── init.vim  # vim的配置  
├── prompt.sh  # zsh和sh的prompt配置  
└── zshrc.zsh  # zsh的专门配置  

### shell运行路径
bootstrap.sh  
    ├── init.sh  
          ├── config.sh  
          ├── prompt.sh  
          └── zshrc.zsh / 或bash的专门配置（还没写）  
    └── init.vim  
