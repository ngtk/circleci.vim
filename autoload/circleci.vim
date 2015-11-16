let s:save_cpo = &cpo
set cpo&vim

function! circleci#call_api(path, param) abort
  let base_url = 'https://circleci.com/api/v1'
  let url = base_url . a:path
  let param = copy(a:param)
  let param['circle-token'] = g:circleci#token
  let header =
        \ {
        \ 'accept': 'application/json',
        \ 'content-type': 'application/json'
        \ }
  return webapi#http#get(url, param, header)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
