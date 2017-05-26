:source $HOME/.vimrc_elixir
map <leader>x :w\|:!iex --sname example_api -S mix phx.server<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN TEST AND PRODUCTION CODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^test/') != -1
  let going_to_spec = !in_spec
  let in_lib = match(current_file, '\<lib\>') != -1
  let in_web = match(current_file, '\<web\>') != -1
  if going_to_spec
    if in_web
      let new_file = substitute(new_file, '^web/', '', '')
    end
    let new_file = substitute(new_file, '\.ex$', '_test.exs', '')
    let new_file = 'test/' . new_file
  else
    let new_file = substitute(new_file, '_test\.exs$', '.ex', '')
    let new_file = substitute(new_file, '^test/', '', '')
    if match(new_file, '\<lib\>') == -1
        let new_file = 'web/' . new_file
    endif
  endif
  return new_file
endfunction

