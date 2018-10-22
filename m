From: bvanassche@acm.org (Bart Van Assche)
Date: Mon, 22 Oct 2018 14:26:32 -0700
Subject: [PATCH] Revert "workqueue: re-add lockdep dependencies for
 flushing"
In-Reply-To: <d45d54e8a46028c2b83296c5bf25a89500a289c4.camel@sipsolutions.net>
References: <20181022151818.135163-1-bvanassche@acm.org>
 <13901aed5074f4b1fbd259d03928efb6ab40c65a.camel@sipsolutions.net>
 <094669f3df1690dec5913c2086f6a6d8c470f685.camel@sipsolutions.net>
 <1540241646.128590.16.camel@acm.org>
 (sfid-20181022_225411_316091_CE34F84D)
 <d45d54e8a46028c2b83296c5bf25a89500a289c4.camel@sipsolutions.net>
Message-ID: <1540243592.128590.36.camel@acm.org>

On Mon, 2018-10-22@23:04 +0200, Johannes Berg wrote:
> When lockdep was added, the networking socket locks also were (mostly)
> fine, recursion there only happened on different types of sockets. Yet,
> lockdep did in fact report issues with it, because originally they
> weren't split into different classes.
> 
> Did we remove lockdep again because it was reporting a potential problem
> in the socket lock code?

I do not agree. It is accepted in the kernel community that if locks are
nested that nested locks should always be taken in the same order. There is
no agreement however that the kind of checking implemented by the "crosslock"
code made sense. My understanding is that you are trying to reintroduce
through a backdoor some of the crosslock code. There is scientific evidence
that it is not possible to come up with an algorithm that flags all
potential deadlocks in programs that use completions without reporting false
positives. See e.g. Agarwal, Rahul, and Scott D. Stoller. "Run-time detection
of potential deadlocks for programs with locks, semaphores, and condition
variables." In Proceedings of the 2006 workshop on Parallel and distributed
systems: testing and debugging, pp. 51-60. ACM, 2006.
(http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.436.7823&rep=rep1&type=pdf).

> As I thought I made pretty clear, the report is in fact valid.

I'm surprised that although your patch caused a deadlock to be reported while
no deadlock occurred that you keep insisting that your report is valid. I don't
understand this.

Bart.
