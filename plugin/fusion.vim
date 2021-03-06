let g:fusion_files_start_insert = 0

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
        let files = []
        if category ==# ''
            for [category, file_list] in items(projectionist#list_all())
                for [file_name, file_path] in file_list
                    call add(files, [printf("%s:\t%s", category, file_name), file_path])
                endfor
            endfor
        else
            let files = get(projectionist#list_all(), category, "")
        endif
        return map(files,
                    \ '{
                    \ "word": v:val[0],
                    \ "kind": ["file"],
                    \ "action__path": v:val[1],
                    \ "action__directory": projectionist#path()
                    \ }')
    endfunction

    function! s:get_projection_files(type)
        let command_str = printf("Unite projection-files -custom-category=%s", a:type)
        if g:fusion_files_start_insert
            let command_str .= " -start-insert"
        endif
        return command_str
    endfunction

    function! s:unite_projection_categories_source.gather_candidates(args, context)
        return map(items(projectionist#list_all()),
                    \ '{
                    \ "word": printf("%s\t(%d)", v:val[0], len(v:val[1])),
                    \ "kind": ["command"],
                    \ "action__command": s:get_projection_files(v:val[0]),
                    \ "action__type": ": "
                    \ }')
    endfunction

    call unite#define_source(s:unite_projection_files_source)
    call unite#define_source(s:unite_projection_categories_source)
endfunction
