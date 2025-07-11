# pintos_gdbMacros
Tools for Debugging Pintos

-p_ready: print all ready thread.

-p_blocked: print all blocked thread.

-p_all: print all thread No matter what the condition is.

-p_run: print currently Running thread.

-trace_run $arg0: Prints the currently running thread whenever execution stops at $arg0, then automatically continues next $arg0 until no further stops occur at $arg0.
