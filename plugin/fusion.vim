" TODO: Leave the "-start-insert" as an option
" TODO: Files->categories navigation
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
        let category = get(a:context, 'custom_category', '')
        if category ==# ''
            let files = []
            for [category, file_list] in items(projectionist#list_all())
                for [file_name, file_path] in file_list
                    call add(files, [category, file_name, file_path])
                endfor
            endfor
            return map(files,
                        \ '{
                        \ "word": printf("%s: %s", v:val[0], v:val[1]),
                        \ "kind": ["file"],
                        \ "action__path": v:val[2],
                        \ }')
        else
            let files = get(projectionist#list_all(), category, "")
            return map(files,
                        \ '{
                        \ "word": v:val[0],
                        \ "kind": ["file"],
                        \ "action__path": v:val[1],
                        \ }')
        endif
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
