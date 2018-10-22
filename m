From: johannes@sipsolutions.net (Johannes Berg)
Date: Mon, 22 Oct 2018 22:28:42 +0200
Subject: [PATCH] Revert "workqueue: re-add lockdep dependencies for
 flushing"
In-Reply-To: <13901aed5074f4b1fbd259d03928efb6ab40c65a.camel@sipsolutions.net>
References: <20181022151818.135163-1-bvanassche@acm.org>
 <13901aed5074f4b1fbd259d03928efb6ab40c65a.camel@sipsolutions.net>
Message-ID: <094669f3df1690dec5913c2086f6a6d8c470f685.camel@sipsolutions.net>

On Mon, 2018-10-22@22:14 +0200, Johannes Berg wrote:

> "False positives" - which in this case really should more accurately be
> called "bad lockdep annotations" - of the kind you report here are
> inherent in how lockdep works, and thus following your argument to the
> ultimate conclusion you should remove lockdep.

> I must also say that I'm disappointed you'd try to do things this way.
> I'd be (have been?) willing to actually help you understand the problem
> and add the annotations, but rather than answer my question ("where do I
> find the right git tree"!) you just send a revert patch.

Actually, wait, you have a different problem in the patch than the one
you reported earlier? Which I haven't even seen at all...

And this one is actually either the same missing subclass annotation, or
completely valid. You have here

 * dio/... workqueue
 * dio->complete_work, running on that workqueue
 * i_mutex_key#16

The lockdep report even more or less tells you what's going on. Perhaps
we need to find a way to make lockdep not print "lock()" but "start()"
or "flush()" for work items ... but if you read it this way, you see:

CPU0			CPU1

lock(i_mutex_key)
			start(dio->complete_work)
			lock(i_mutex_key)
flush(wq dio/...)

which is *clearly* a problem. You can't flush a workqueue under lock
that is (or might be) currently running a work item that takes the same
lock. You've already acquired the lock, and so the complete_work is
waiting for the lock, but you're now in the flush waiting for it to
finish ... pretty much a classic ABBA deadlock, just with workqueues.

It's possible, of course, that multiple instances of the same class are
involved and they're somehow ordered/nested in a way that is in fact
safe, say in this case CPU0 and CPU1 have acquired (or are trying to
acquire) fundamentally different instances of "i_mutex_key#16", or the
dio->complete_work here doesn't actually run on the dio workqueue in
question, but somehow a different one.

With workqueues, it's also possible that something out-of-band, other
than the flush_workqueue(), prevents dio->complete_work from being
running at this point in time - but in that case you might actually be
able to get rid of the flush_workqueue() entirely.

It ought to be possible to annotate this too though, but again, I'm not
an expert on what the correct and safe nesting here would be, and thus
wouldn't be able to say how to do it.

johannes
