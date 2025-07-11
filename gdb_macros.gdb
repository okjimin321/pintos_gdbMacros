

define connect
    target remote localhost:1234
end

define offsetof
    set $rc = (char*)&((struct $arg0 *)0)->$arg1 - (char*)0
end

define p_ready
    set $e = ready_list.head.next
    while ($e != &ready_list.tail)
        set $t = (struct thread *)((char *)$e - 48)
        printf "%-5d %-16s %-8d\n", $t->tid, $t->name, $t->status
        set $e = $e->next
    end
end

define p_blocked
    set $e = blocked_list.head.next
    while ($e != &blocked_list.tail)
        set $t = (struct thread *)((char *)$e - 48)
        printf "%-5d %-16s %-8d %-5d\n", $t->tid, $t->name, $t->status, $t->tick_to_awake
        set $e = $e->next
    end
end

define p_all
    set $e = all_list.head.next
    while ($e != &all_list.tail)
        set $t = (struct thread *)((char *)$e - 32)
        printf "%-5d %-16s %-8d\n", $t->tid, $t->name, $t->status
        set $e = $e->next
    end
end

define p_run
    set $cur = (struct thread *)((int)$esp & ~0xfff)
    printf "Tid= %-5d Name= %-16s \n", $cur->tid, $cur->name
end

define trace_run
    
    b $arg0 
    commands
    silent
    end
    c
    set $i = 0

    while($i < 100000)
        set $cur = (struct thread *)((int)$esp & ~0xfff)

        if($cur != -1)
            p ::ticks
            printf "RUNNING THREAD: tid= %-5d name= %-10s\n", $cur->tid, $cur->name
        end

        set $i = $i + 1
        c
    end
end

define test_trace
    
    b $arg0 
    commands
    silent
    end
    c
    set $i = 0

    while($i < 100000)
        set $cur = 0
        set $e = all_list.head.next
        while ($e != &all_list.tail)
            set $t = (struct thread *)((char *)$e - 32)
            if($t->status == 0)
                set $cur = $t
            end
            set $e = $e->next
        end

        if($cur != 0)
            if($cur->tid != 2)
                p ::ticks
                printf "RUNNING THREAD: tid= %-5d name= %-10s\n", $cur->tid, $cur->name
                
            end
        end

        set $i = $i + 1
        c
    end
end

define test_run
    set $e = all_list.head.next
    while ($e != &all_list.tail)
        set $t = (struct thread *)((char *)$e - 32)
        if($t->status == 0)
            printf "%-5d %-16s %-8d\n", $t->tid, $t->name, $t->status
        end
        set $e = $e->next
    end
end
