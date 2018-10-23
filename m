From: johannes@sipsolutions.net (Johannes Berg)
Date: Tue, 23 Oct 2018 21:44:26 +0200
Subject: [PATCH] Revert "workqueue: re-add lockdep dependencies for
 flushing"
In-Reply-To: <1540243592.128590.36.camel@acm.org>
 (sfid-20181022_232636_906722_14E48F04)
References: <20181022151818.135163-1-bvanassche@acm.org>
 <13901aed5074f4b1fbd259d03928efb6ab40c65a.camel@sipsolutions.net>
 <094669f3df1690dec5913c2086f6a6d8c470f685.camel@sipsolutions.net>
 <1540241646.128590.16.camel@acm.org>
 (sfid-20181022_225411_316091_CE34F84D)
 <d45d54e8a46028c2b83296c5bf25a89500a289c4.camel@sipsolutions.net>
 <1540243592.128590.36.camel@acm.org> (sfid-20181022_232636_906722_14E48F04)
Message-ID: <3abaaea3cd2477fbcf8830f0dd34dbfcc4cfbcc2.camel@sipsolutions.net>

On Mon, 2018-10-22@14:26 -0700, Bart Van Assche wrote:
> On Mon, 2018-10-22@23:04 +0200, Johannes Berg wrote:
> > When lockdep was added, the networking socket locks also were (mostly)
> > fine, recursion there only happened on different types of sockets. Yet,
> > lockdep did in fact report issues with it, because originally they
> > weren't split into different classes.
> > 
> > Did we remove lockdep again because it was reporting a potential problem
> > in the socket lock code?
> 
> I do not agree. It is accepted in the kernel community that if locks are
> nested that nested locks should always be taken in the same order.

You brought here another example, different from the one that we've been
discussing in the nvmet-rdma thread. If somebody can explain how you end
up with this specific example I'd be happy to explain what lockdep
thinks it's going on, but from just the report, without knowing what the
setup was, I don't really have any idea what's going on.

If I were to venture a guess I'd say you mounted a file system image
loopback, and this happens during some kind of direct IO flush or
perhaps unmount, because you try to flush the inner filesystem and that
ends up tricking out to the outer filesystem, which is basically all the
same (dio) code, so it connects the lock class back to itself as far as
lockdep is concerned.

> There is
> no agreement however that the kind of checking implemented by the "crosslock"
> code made sense. My understanding is that you are trying to reintroduce
> through a backdoor some of the crosslock code. 

Not at all.

> There is scientific evidence
> that it is not possible to come up with an algorithm that flags all
> potential deadlocks in programs that use completions without reporting false
> positives. See e.g. Agarwal, Rahul, and Scott D. Stoller. "Run-time detection
> of potential deadlocks for programs with locks, semaphores, and condition
> variables." In Proceedings of the 2006 workshop on Parallel and distributed
> systems: testing and debugging, pp. 51-60. ACM, 2006.
> (http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.436.7823&rep=rep1&type=pdf).

Yeah, but again, you could take that as an argument for removing
lockdep.

> > As I thought I made pretty clear, the report is in fact valid.
> 
> I'm surprised that although your patch caused a deadlock to be reported while
> no deadlock occurred that you keep insisting that your report is valid. I don't
> understand this.

I guess it boils down to semantics of "valid" here. I do argue that the
report is valid because the report only says:

   Look here, I found that you created a dependency from lock class X
   (i_mutex_key) back to itself. This means you have a potential bug in
   your program, because maybe if these are actually the same instance,
   then you may deadlock.

Note that this kind of reporting is all lockdep ever does.

Think of it like this: You have a bunch of chains, looking like this:

A1-B1
   B2-A2

where the letters are the lock classes, and the numbers are the
instances.

Lockdep will basically project that down to be

A-B-A

and tell you that you have a potential deadlock. If somehow you've
ensured that A1 and A3 are _guaranteed_ to be different *instances*,
then you can use *_nested() primitives to tell this to lockdep, in which
case it would project down to

A-B-A'

and not complain.

Now let's put a work struct in here, and you get something like

A-W    # flush work struct W (*) while holding lock A
  W-A  # lock A while running from work struct W

(*) or a single-threaded/ordered workqueue that may run work struct W


This is what lockdep is reporting here now. Again, if the A's are
actually two guaranteed-to-be-different instances, then *_nested()
versions of the locking, which may have to be added for flushing
workqueues/work items, will let you tell lockdep that this is safe.


You are arguing that we should remove the lockdep annotations instead,
basically saying that you'd prefer that lockdep only sees

A      # flush work struct W (*) while holding lock A
    A  # lock A
while running from work struct W

instead of the picture with A-W/W-A above.

While this obviously gets rid of this report and the other one in nvmet-
rdma that you found, all it means is that you've just - to some extent -
crippled lockdep's ability to find chains.

You haven't removed something that's creating false positives, you've
just removed links from the chains.

This is why I say this code is valid, and why I say what you're arguing
is pretty much equivalent to saying that lockdep is just fundamentally
useless. You wouldn't, after all, say that mutexes shouldn't be
annotated in lockdep just because lockdep found an A-B-A mutex class
chain that you had to annotate with mutex_lock_nested() to make it into
A-B-A' as per my other example above.


I hope that clarifies what's going on here. I do understand that it can
be frustrating if you see a lockdep report and can't really understand
it immediately, and I also understand that it's not always trivial to
teach lockdep about the right nesting, but I'd argue that we have ways
to address both dynamic (mutex_lock_nested) and static (__mutex_init
passing a different class) ways of addressing this issue.

johannes
