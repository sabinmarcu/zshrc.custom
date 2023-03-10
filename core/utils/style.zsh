import core.constants.colors
import core.constants.backgroundColors
import core.constants.text

function style_text {
  local styles=($(zsh_color default) $(zsh_text_style normal) $(zsh_background_color default))
  local rest=-1
  for ((i=1; i <= $#; i++)); do
    local arg=${(P)i}
    if [[ "$arg" == "--" ]]; then
      rest=$i
      break
    elif color=$(zsh_color $arg) then
      styles+=($color)
    elif style=$(zsh_text_style $arg) then
      styles+=($style)
    elif bgColor=$(zsh_background_color $arg) then
      styles+=($bgColor)
    fi
  done
  if [[ rest -eq -1 ]]; then
    echo "\033[0;$(zsh_color red)mNo text to format!\033[0m"
    return 1
  fi
  echo "\033[${(j:;:)styles}m${@:(($rest + 1))}\033[0m"
}
_cleanup style_text

function error {
  echo $(style_text bgRed -- "❌ $@")
}
_cleanup error

function warn {
  echo $(style_text yellow underline -- "⚠ $@")
}
_cleanup warn

function info {
  echo $(style_text blue -- " $@")
}
_cleanup info
