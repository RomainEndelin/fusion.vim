" TODO: Reorder the code
" TODO: For tpope's vim-projectionist and refactor the code
" TODO: Leave the "-start-insert" as an option
" TODO: Files->categories navigation
" TODO: List files when no category is given (and prefix each file with its
" category)
" TODO: Rename everything
" TODO: Count and display the number of file in each category
" TODO: Echo error if one of the plugin isn't loaded

autocmd User ProjectionistActivate call s:activate()

function! s:activate() abort
    let s:unite_type_source = {
                \ 'name': 'projection',
                \ 'hooks': {},
                \ 'action_table': {'*': {}},
                \ }

    function! s:startswith(str, prefix) abort
        return strpart(a:str, 0, len(a:prefix)) ==# a:prefix
    endfunction

    function! s:endswith(str, suffix) abort
        return strpart(a:str, len(a:str) - len(a:suffix)) ==# a:suffix
    endfunction

    function! s:slash(str) abort
        return tr(a:str, projectionist#slash(), '/')
    endfunction

    function! s:match(file, pattern) abort
        if a:pattern =~# '^[^*{}]*\*[^*{}]*$'
            let pattern = s:slash(substitute(a:pattern, '\*', '**/*', ''))
        elseif a:pattern =~# '^[^*{}]*\*\*[^*{}]\+\*[^*{}]*$'
            let pattern = s:slash(a:pattern)
        else
            return ''
        endif
        let [prefix, infix, suffix] = split(pattern, '\*\*\=', 1)
        let file = s:slash(a:file)
        if !s:startswith(file, prefix) || !s:endswith(file, suffix)
            return ''
        endif
        let match = file[strlen(prefix) : -strlen(suffix)-1]
        if infix ==# '/'
            return match
        endif
        let clean = substitute('/'.match, '\V'.infix.'\ze\[^/]\*\$', '/', '')[1:-1]
        return clean ==# match ? '' : clean
    endfunction

    function! s:unite_type_source.gather_candidates(args, context)
        let type = a:context['custom_type']
        let globbed_files = get(projectionist#navigation_commands(), type, "")
        let results = []
        for format in map(globbed_files, 'v:val[1]')
            if format !~# '\*'
                continue
            endif
            let glob = substitute(format, '[^\/]*\ze\*\*[\/]\*', '', 'g')
            let results += map(split(glob(glob), "\n"), '[s:match(v:val, format), v:val]')
        endfor
        return map(results,
                    \ '{
                    \ "word": v:val[0],
                    \ "kind": ["file"],
                    \ "action__path": v:val[1],
                    \ }')
    endfunction

    let s:unite_projections_source = {
                \ 'name': 'fusion',
                \ 'hooks': {},
                \ 'action_table': {'*': {}},
                \ }

    function! s:fusion_list_type(type)
        return printf("Unite projection -custom-type=%s", a:type)
    endfunction

    function! s:unite_projections_source.gather_candidates(args, context)
        return map(keys(projectionist#navigation_commands()),
                    \ '{
                    \ "word": v:val,
                    \ "kind": ["command"],
                    \ "action__command": s:fusion_list_type(v:val),
                    \ "action__type": ": "
                    \ }')

    endfunction
    call unite#define_source(s:unite_type_source)
    call unite#define_source(s:unite_projections_source)

    nnoremap <C-f> :Unite fusion -start-insert<cr>
endfunction

