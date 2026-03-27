'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
  emulate -L zsh -o extended_glob

  unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'

  autoload -Uz is-at-least && is-at-least 5.1 || return

  # ─── Layout ───────────────────────────────────────────────────────────────
  # Line 1 left:  ╭─ user@host dir git
  # Line 1 right: languages duration jobs vi_mode
  # Line 2 left:  ╰─ ❯
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    context dir vcs
    newline
    prompt_char
  )

  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    node_version python_version rust_version go_version
    java_version lua_version
    command_execution_time background_jobs vi_mode
    newline
  )

  # ─── Style ────────────────────────────────────────────────────────────────
  typeset -g POWERLEVEL9K_MODE=nerdfont-v3
  typeset -g POWERLEVEL9K_ICON_PADDING=none
  typeset -g POWERLEVEL9K_BACKGROUND=

  # No powerline separators — use spaces between segments
  typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=
  typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=
  typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=' '
  typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=' '
  typeset -g POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL=
  typeset -g POWERLEVEL9K_EMPTY_LINE_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=

  # Box-drawing multiline connectors
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX='%F{#555255}╭─%f'
  typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX='%F{#555255}╰─%f'
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_SUFFIX=
  typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_SUFFIX=

  # Transient prompt: past lines collapse to just ╰─❯
  typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=always

  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=false

  # ─── Context (user@host) ──────────────────────────────────────────────────
  typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO,REMOTE,REMOTE_SUDO}_BACKGROUND=none
  # Bold blue user, teal host
  typeset -g POWERLEVEL9K_CONTEXT_DEFAULT_CONTENT_EXPANSION='%B%F{#7A9AAA}%n%b%F{#5A8A8E}@%m'
  # Root: bold red user, teal host
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_CONTENT_EXPANSION='%B%F{#CC1A20}%n%b%F{#5A8A8E}@%m'
  typeset -g POWERLEVEL9K_CONTEXT_ALWAYS_SHOW=true

  # ─── Directory ────────────────────────────────────────────────────────────
  typeset -g POWERLEVEL9K_DIR_BACKGROUND=none
  typeset -g POWERLEVEL9K_DIR_FOREGROUND='#C89414'
  typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND='#C89414'
  typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND='#C89414'
  typeset -g POWERLEVEL9K_DIR_LOCK_FOREGROUND='#CC1A20'
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_repo
  typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
  typeset -g POWERLEVEL9K_DIR_ICON='󰉋'
  typeset -g POWERLEVEL9K_DIR_LOCK_SYMBOL='󰌾'
  typeset -g POWERLEVEL9K_DIR_SUBSTITUTIONS=(
    '~/Documents' '󰈙 Docs'
    '~/Downloads' ' DL'
    '~/Music' '󰝚 Music'
    '~/Pictures' ' Pics'
    '~/Projects' '󰲋 Projects'
  )

  # ─── Git ──────────────────────────────────────────────────────────────────
  typeset -g POWERLEVEL9K_VCS_{CLEAN,MODIFIED,UNTRACKED,CONFLICTED,LOADING}_BACKGROUND=none
  typeset -g POWERLEVEL9K_VCS_BRANCH_ICON=' '
  typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND='#7A9AAA'
  typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='#CC1A20'
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='#CC1A20'
  typeset -g POWERLEVEL9K_VCS_CONFLICTED_FOREGROUND='#CC1A20'
  typeset -g POWERLEVEL9K_VCS_LOADING_FOREGROUND='#555255'
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON='󰋗'
  typeset -g POWERLEVEL9K_VCS_UNSTAGED_ICON='󱇧'
  typeset -g POWERLEVEL9K_VCS_STAGED_ICON='󰐕'
  typeset -g POWERLEVEL9K_VCS_STASH_ICON='󰏗'
  typeset -g POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='󰶡'
  typeset -g POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='󰶣'
  typeset -g POWERLEVEL9K_VCS_CONFLICTED_ICON='󰞇'
  typeset -g POWERLEVEL9K_VCS_DELETED_ICON='󰍴'
  typeset -g POWERLEVEL9K_VCS_RENAMED_ICON='󰑕'

  # ─── Prompt character (❯ / ❮) ─────────────────────────────────────────────
  typeset -g POWERLEVEL9K_PROMPT_CHAR_BACKGROUND=none
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_VIINS_FOREGROUND='#5A8A65'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_VIINS_FOREGROUND='#5A8A65'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_VICMD_FOREGROUND='#C89414'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_VICMD_FOREGROUND='#C89414'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_VIVIS_FOREGROUND='#CC1A20'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_VIVIS_FOREGROUND='#CC1A20'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_VIINS_CONTENT_EXPANSION='❯'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_VIINS_CONTENT_EXPANSION='❯'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_VICMD_CONTENT_EXPANSION='❮'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_VICMD_CONTENT_EXPANSION='❮'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_VIVIS_CONTENT_EXPANSION='❮'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_VIVIS_CONTENT_EXPANSION='❮'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_{LEFT,RIGHT}_WHITESPACE=

  # ─── Vi mode ──────────────────────────────────────────────────────────────
  typeset -g POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND='#5A8A65'
  typeset -g POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='#C89414'
  typeset -g POWERLEVEL9K_VI_MODE_VISUAL_BACKGROUND='#CC1A20'
  typeset -g POWERLEVEL9K_VI_INSERT_MODE_STRING='INSERT'
  typeset -g POWERLEVEL9K_VI_COMMAND_MODE_STRING='NORMAL'
  typeset -g POWERLEVEL9K_VI_VISUAL_MODE_STRING='VISUAL'
  typeset -g POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND='#111014'
  typeset -g POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='#111014'
  typeset -g POWERLEVEL9K_VI_MODE_VISUAL_FOREGROUND='#111014'

  # ─── Command execution time ───────────────────────────────────────────────
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=none
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='#D4780A'
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=2
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_ICON='󱎫'

  # ─── Background jobs ──────────────────────────────────────────────────────
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND=none
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='#5A8A8E'
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_ICON='󰒓'
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE=true

  # ─── Language versions (shown only when relevant) ─────────────────────────
  typeset -g POWERLEVEL9K_NODE_VERSION_BACKGROUND=none
  typeset -g POWERLEVEL9K_NODE_VERSION_FOREGROUND='#5A8A65'
  typeset -g POWERLEVEL9K_NODE_ICON='󰎙'
  typeset -g POWERLEVEL9K_NODE_VERSION_PROJECT_ONLY=true

  typeset -g POWERLEVEL9K_PYTHON_VERSION_BACKGROUND=none
  typeset -g POWERLEVEL9K_PYTHON_VERSION_FOREGROUND='#7A9AAA'
  typeset -g POWERLEVEL9K_PYTHON_ICON=''
  typeset -g POWERLEVEL9K_PYTHON_VERSION_PROJECT_ONLY=true

  typeset -g POWERLEVEL9K_RUST_VERSION_BACKGROUND=none
  typeset -g POWERLEVEL9K_RUST_VERSION_FOREGROUND='#CC1A20'
  typeset -g POWERLEVEL9K_RUST_ICON='󱘗'
  typeset -g POWERLEVEL9K_RUST_VERSION_PROJECT_ONLY=true

  typeset -g POWERLEVEL9K_GO_VERSION_BACKGROUND=none
  typeset -g POWERLEVEL9K_GO_VERSION_FOREGROUND='#5A8A8E'
  typeset -g POWERLEVEL9K_GO_ICON='󰟓'
  typeset -g POWERLEVEL9K_GO_VERSION_PROJECT_ONLY=true

  typeset -g POWERLEVEL9K_JAVA_VERSION_BACKGROUND=none
  typeset -g POWERLEVEL9K_JAVA_VERSION_FOREGROUND='#D4780A'
  typeset -g POWERLEVEL9K_JAVA_ICON='󰬷'
  typeset -g POWERLEVEL9K_JAVA_VERSION_PROJECT_ONLY=true

  typeset -g POWERLEVEL9K_LUA_VERSION_BACKGROUND=none
  typeset -g POWERLEVEL9K_LUA_VERSION_FOREGROUND='#7A9AAA'
  typeset -g POWERLEVEL9K_LUA_ICON='󰢱'
  typeset -g POWERLEVEL9K_LUA_VERSION_PROJECT_ONLY=true

} 
(( $+__p9k_instant_prompt_active )) && unsetopt prompt_cr prompt_sp || setopt prompt_cr prompt_sp

(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'
