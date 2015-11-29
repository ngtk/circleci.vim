let s:save_cpo = &cpo
set cpo&vim

function! circleci#project#get_recent_builds(username, reponame, ...) abort
  let path = s:base_path(a:username, a:reponame)
  if exists(a:1)
    let branch = a:1
    let path .= '/tree/' . branch
  endif
  let response = circleci#call_api(path, {})
  return webapi#json#decode(response.content)
endfunction

function! circleci#project#get_build(username, reponame, build_num) abort
  let path = s:base_path(a:username, a:reponame) . '/' . a:build_num
  let response = circleci#call_api(path, {})
  return webapi#json#decode(response.content)
endfunction

function! circleci#project#get_build_artifacts(username, reponame, build_num) abort
  let path = s:base_path(a:username, a:reponame) . '/' . a:build_num . '/artifacts'
  let response = circleci#call_api(path, {})
  return webapi#json#decode(response.content)
endfunction

function! s:base_path(username, reponame) abort
  return '/project/' . a:username . '/' . a:reponame
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
