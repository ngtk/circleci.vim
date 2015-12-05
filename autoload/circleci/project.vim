let s:save_cpo = &cpo
set cpo&vim

function! circleci#project#get_recent_builds(username, reponame, ...) abort
  let path = s:base_path(a:username, a:reponame)
  if exists('a:1')
    let branch = a:1
    let branch_url_encoded = webapi#http#encodeURIComponent(branch)
    let path .= '/tree/' . branch_url_encoded
  endif
  let response = circleci#call_api(path, {})
  return webapi#json#decode(response.content)
endfunction

function! circleci#project#get_build(username, reponame, build_num) abort
  let path = s:build_path(a:username, a:reponame, a:build_num)
  let response = circleci#call_api(path, {})
  return webapi#json#decode(response.content)
endfunction

function! circleci#project#get_build_artifacts(username, reponame, build_num) abort
  let path = s:build_path(a:username, a:reponame, a:build_num) . '/artifacts'
  let response = circleci#call_api(path, {})
  return webapi#json#decode(response.content)
endfunction

function! s:base_path(username, reponame) abort
  return '/project/' . a:username . '/' . a:reponame
endfunction

function! s:build_path(username, reponame, build_num) abort
  return s:base_path(a:username, a:reponame) . '/' . a:build_num
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
