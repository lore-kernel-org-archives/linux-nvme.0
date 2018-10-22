From: johannes@sipsolutions.net (Johannes Berg)
Date: Mon, 22 Oct 2018 22:14:22 +0200
Subject: [PATCH] Revert "workqueue: re-add lockdep dependencies for
 flushing"
In-Reply-To: <20181022151818.135163-1-bvanassche@acm.org>
References: <20181022151818.135163-1-bvanassche@acm.org>
Message-ID: <13901aed5074f4b1fbd259d03928efb6ab40c65a.camel@sipsolutions.net>

On Mon, 2018-10-22@15:18 +0000, Bart Van Assche wrote:
> Lockdep is a tool that developers rely on to find actual bugs. False
> positive lockdep warnings are very annoying because it takes time to
> analyze these and to verify that the warning is really a false positive
> report. Since commit 87915adc3f0a ("workqueue: re-add lockdep
> dependencies for flushing") causes lockdep to produce multiple false
> positive reports, revert that commit. 


What, no, I obviously _strongly_ object to this. You've just killed
lockdep reporting an entire *class* of problems over a single report
that you don't like.

"False positives" - which in this case really should more accurately be
called "bad lockdep annotations" - of the kind you report here are
inherent in how lockdep works, and thus following your argument to the
ultimate conclusion you should remove lockdep.


Say, for example (and similar things exist, like socket locks in
networking), you have a list of objects, each initialized through a
single function that does mutex_init(), causing a single lockdep class
to be used.

Now you have to acquire the locks for multiple such objects, and to make
that safe you always do that in object ID order, which is strictly
monotonically increasing.

Lockdep will *certainly* complain about this situation, since as far as
it is concerned, you've just done a recursive lock.

The solution to this isn't to remove lockdep annotations for mutexes (or
work objects, as you propose), the solution is to tell lockdep that you
actually have multiple classes of objects, and thus the recursion you do
is not a problem.

So clearly, NACK.

I must also say that I'm disappointed you'd try to do things this way.
I'd be (have been?) willing to actually help you understand the problem
and add the annotations, but rather than answer my question ("where do I
find the right git tree"!) you just send a revert patch.

To do that, you have to understand what recursion is valid (I'm guessing
there's some sort of layering involved), and I'm far from understanding
anything about the code that triggered this report.

I'm almost certain can teach lockdep about why the recursion is fine,
probably by using a lock subclass (last argument to lockdep_init_map())
in either a new variant of alloc_workqueue() or a new variant of
INIT_WORK().

johannes
