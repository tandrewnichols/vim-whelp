if has("syntax")
  syn match whelpEntry     "^[^|]\+"
  syn match whelpDate      "[A-Z][a-z]\{2} [0-9]\{2}, [0-9]\{4} at [0-9:]\{8} [AP]M$"

  hi def link whelpEntry   Keyword
  hi def link whelpDate    String
endif
