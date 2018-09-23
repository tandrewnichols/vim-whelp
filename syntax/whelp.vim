if has("syntax")
  syn match whelpEntry     "^[^|]\+"
  syn match whelpDate      "[A-Z][a-z]\{2} [0-9]\{2}, [0-9]\{4}"
  syn match whelpTime      "at \zs[0-9:]\{8} [AP]M\ze$"

  hi def link whelpEntry   Keyword
  hi def link whelpDate    String
  hi def link whelpTime    String
endif
