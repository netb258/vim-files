"Color <exec> tag as Python code:
runtime! syntax/xml.vim
unlet b:current_syntax
syntax include @Python syntax/python.vim
syntax region execCode  start=+<exec[^>]*>+ keepend end=+</exec>+  contains=@Python
syntax region validationCode  start=+<validate[^>]*>+ keepend end=+</validate>+  contains=@Python
