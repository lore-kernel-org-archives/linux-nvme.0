From: johannes@sipsolutions.net (Johannes Berg)
Date: Tue, 23 Oct 2018 21:58:04 +0200
Subject: [PATCH] Revert "workqueue: re-add lockdep dependencies for
 flushing"
In-Reply-To: <3abaaea3cd2477fbcf8830f0dd34dbfcc4cfbcc2.camel@sipsolutions.net>
References: <20181022151818.135163-1-bvanassche@acm.org>
 <13901aed5074f4b1fbd259d03928efb6ab40c65a.camel@sipsolutions.net>
 <094669f3df1690dec5913c2086f6a6d8c470f685.camel@sipsolutions.net>
 <1540241646.128590.16.camel@acm.org>
 (sfid-20181022_225411_316091_CE34F84D)
 <d45d54e8a46028c2b83296c5bf25a89500a289c4.camel@sipsolutions.net>
 <1540243592.128590.36.camel@acm.org>
 (sfid-20181022_232636_906722_14E48F04)
 <3abaaea3cd2477fbcf8830f0dd34dbfcc4cfbcc2.camel@sipsolutions.net>
Message-ID: <adabc379f7d90ba018ac88877d6e9c42418360f7.camel@sipsolutions.net>

On Tue, 2018-10-23@21:44 +0200, Johannes Berg wrote:

> > There is
> > no agreement however that the kind of checking implemented by the "crosslock"
> > code made sense. My understanding is that you are trying to reintroduce
> > through a backdoor some of the crosslock code. 
> 
> Not at all.

Perhaps I should elaborate on this, although I'm not really entirely
sure of it.

As I understand it, crosslock was trying to solve an entirely different
problem, namely that of tracking locks that can be acquired in one
thread, and released in another. This obviously still causes deadlocks,
but doesn't lend itself to actual tracking in the lockdep chain, since
you don't really know how directly long the lock was held.

With a classic mutex (spinlock, ...), you always have

lock(A)
do_something()
unlock(A)

in the same thread, so if do_something() contains another lock(B), you
know that you've got a dependency A->B.

If A instead is something that might be released in another thread, e.g.
a completion or semaphore, it's really hard to tell whether you have

down(A)
do_something()
up(A)

in a single thread, or if the up(A) happens elsewhere entirely.
Therefore, things like this aren't tracked by lockdep at all.

Crosslock tried to address this.

The workqueue annotations, on the other hand, *are* within the same
thread. You're either executing from the work struct, and the same
thread will obviously end up going out of the work struct again, or
you're flushing (and waiting) for the workqueue, so all of that also
happens in the same thread (apart from the actual work that you wait
for, but that's unrelated).

johannes
