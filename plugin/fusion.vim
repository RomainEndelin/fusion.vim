" TODO: Leave the "-start-insert" as an option
" TODO: Files->categories navigation
" TODO: List files when no category is given (and prefix each file with its
" category)
" TODO: Echo error if one of the plugin isn't loaded

autocmd User ProjectionistActivate call s:activate()

function! s:activate() abort
    let s:unite_projection_files_source = {
                \ 'name': 'projection-files',
                \ 'hooks': {},
                \ 'action_table': {'*': {}},
                \ }

    let s:unite_projection_categories_source = {
                \ 'name': 'projection-categories',
                \ 'hooks': {},
                \ 'action_table': {'*': {}},
                \ }

    function! s:unite_projection_files_source.gather_candidates(args, context)
        let category = a:context['custom_category']
        let files = get(projectionist#list_all(), category, "")
        return map(files,
                    \ '{
                    \ "word": v:val[0],
                    \ "kind": ["file"],
                    \ "action__path": v:val[1],
                    \ }')
    endfunction

    function! s:get_projection_files(type)
        return printf("Unite projection-files -custom-category=%s", a:type)
    endfunction

    function! s:unite_projection_categories_source.gather_candidates(args, context)
        return map(items(projectionist#list_all()),
                    \ '{
                    \ "word": printf("%s (%d)", v:val[0], len(v:val[1])),
                    \ "kind": ["command"],
                    \ "action__command": s:get_projection_files(v:val[0]),
                    \ "action__type": ": "
                    \ }')
    endfunction

    call unite#define_source(s:unite_projection_files_source)
    call unite#define_source(s:unite_projection_categories_source)

    nnoremap <C-f> :Unite projection-categories -start-insert<cr>
endfunction
