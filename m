From: riel@redhat.com (Rik van Riel)
Date: Thu, 27 Jun 2013 14:10:36 -0400
Subject: RFC: Allow block drivers to poll for I/O instead of sleeping
In-Reply-To: <CA+55aFy+COdk5+ucwxtc1At=PAYTJxeUaUV6rP9XstHdNV0hbQ@mail.gmail.com>
References: <20130620201713.GV8211@linux.intel.com>
 <20130623100920.GA19021@gmail.com>
 <CA+55aFy+COdk5+ucwxtc1At=PAYTJxeUaUV6rP9XstHdNV0hbQ@mail.gmail.com>
Message-ID: <51CC801C.5050600@redhat.com>

On 06/23/2013 02:29 PM, Linus Torvalds wrote:

> You could try to do that either *in* the idle thread (which would take
> the context switch overhead - maybe negating some of the advantages),
> or alternatively hook into the scheduler idle logic before actually
> doing the switch.
>
> But anything that starts polling when there are other runnable
> processes to be done sounds really debatable. Even if it's "only" 5us
> or so. There's a lot of real work that could be done in 5us.

Having a hook into the idle code could be useful for
KVM, too.

In certain message passing workloads, we have seen
that the system throughput suffers greatly simply
by having the KVM thread's preempt notifiers save
CPU state when the guest goes idle, and re-load it
when the guest VCPU is activated again.

Avoiding the context switch overhead when nothing
else wants to run, but being immediately preempted
when something does, could be a big win.

Would it make sense to have some hook that says
"I *am* an idle thread right now", as opposed to
"context switch to the idle thread"?

That hook could even run the cpuidle code, and
switch to the real idle task (saving the current
task state), and put the CPU into a C-state, when
the expected sleep time is long...
