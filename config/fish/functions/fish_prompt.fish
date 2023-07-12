function fish_prompt
    set -l color_normal (set_color normal)
    set -l color_host (set_color green)
    set -l color_name (set_color blue)
    set -l color_ref (set_color cyan)
    set -l color_operation (set_color magenta)
    set -l color_cwd (set_color yellow)

    set -l host
    set -l name
    set -l ref
    set -l operation
    set -l cwd

    if set -q SSH_TTY
        set host (prompt_hostname)
    end

    if set -l info (command git rev-parse --git-dir --is-inside-work-tree 2>/dev/null)
        set -l git_dir $info[1]
        set -l is_inside_work_tree $info[2]

        set -l worktree

        if test $is_inside_work_tree = true
            set worktree (command git rev-parse --show-toplevel 2>/dev/null)
        else
            set worktree (string split ' ' -f1 -- (command git worktree list 2>/dev/null)[1])
        end

        set name (string split '/' -r -m1 -f2 -- $worktree)

        if not set cwd (string replace -r "^$worktree/" '' -- (pwd -P))
            set cwd .
        end

        if test -d $git_dir/rebase-merge
            set operation rebase
            set ref (cat $git_dir/rebase-merge/head-name 2>/dev/null)
        else if test -d $git_dir/rebase-apply
            set operation rebase
            set ref (cat $git_dir/rebase-apply/head-name 2>/dev/null)
        else if test -f $git_dir/MERGE_HEAD
            set operation merge
        else if test -f $git_dir/CHERRY_PICK_HEAD
            set operation cherry-pick
        else if test -f $git_dir/REVERT_HEAD
            set operation revert
        else if test -f $git_dir/BISECT_LOG
            set operation bisect
        end

        if test -z "$ref"
            set ref (command git symbolic-ref HEAD 2>/dev/null)
            or set ref (command git describe --tags --exact-match HEAD 2>/dev/null)
            or set ref (command git rev-parse --short=8 HEAD 2>/dev/null)
        end

        set ref (string replace -r '^refs/heads/' '' -- $ref)
    else
        set name (prompt_pwd -d 0)
    end

    echo -n -s $color_host $host' ' $color_normal $color_name $name $color_normal $color_ref ' '$ref $color_normal $color_operation ' '$operation $color_normal $color_cwd ' '$cwd $color_normal "\$ "
end
