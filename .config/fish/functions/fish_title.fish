function fish_title
    set -l host
    set -l title

    if set -q SSH_TTY
        set host (prompt_hostname)
    end

    if set -l info (command git rev-parse --is-inside-work-tree 2>/dev/null)
        set -l inside_work_tree $info[1]

        set -l worktree

        if test $inside_work_tree = true
            set worktree (command git rev-parse --show-toplevel)
        else
            set worktree (string split ' ' -f1 -- (command git worktree list 2>/dev/null)[1])
        end

        set title (string split '/' -r -m1 -f2 -- $worktree)
    else
        set title (prompt_pwd -d 0)
    end

    echo -n -s $host': ' $title
end
