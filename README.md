# pintos_gdbMacros
Tools for Debugging Pintos

- **p_ready:** print all ready threads.
- **p_blocked:** print all blocked threads.
- **p_all:** print all threads regardless of their status.
- **p_run:** print the currently running thread.
- **trace_run $arg0:** Prints the currently running thread whenever execution stops at `$arg0`, then automatically continues until no further stops occur at `$arg0`.
