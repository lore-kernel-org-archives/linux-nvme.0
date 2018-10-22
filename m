From: bvanassche@acm.org (Bart Van Assche)
Date: Mon, 22 Oct 2018 13:54:06 -0700
Subject: [PATCH] Revert "workqueue: re-add lockdep dependencies for
 flushing"
In-Reply-To: <094669f3df1690dec5913c2086f6a6d8c470f685.camel@sipsolutions.net>
References: <20181022151818.135163-1-bvanassche@acm.org>
 <13901aed5074f4b1fbd259d03928efb6ab40c65a.camel@sipsolutions.net>
 <094669f3df1690dec5913c2086f6a6d8c470f685.camel@sipsolutions.net>
Message-ID: <1540241646.128590.16.camel@acm.org>

On Mon, 2018-10-22@22:28 +0200, Johannes Berg wrote:
> The lockdep report even more or less tells you what's going on. Perhaps
> we need to find a way to make lockdep not print "lock()" but "start()"
> or "flush()" for work items ... but if you read it this way, you see:
> 
> CPU0			CPU1
> 
> lock(i_mutex_key)
> 			start(dio->complete_work)
> 			lock(i_mutex_key)
> flush(wq dio/...)
> 
> which is *clearly* a problem.

Your patch made lockdep report that the direct I/O code deadlocks although it
clearly doesn't deadlock. So where do you think the bug is? In the direct I/O
code or in your patch?

The code in the column with label "CPU0" is code called by do_blockdev_direct_IO().
>From the body of that function:

			/* will be released by direct_io_worker */
			inode_lock(inode);

I think that is sufficient evidence that the direct I/O code is fine and that
your patch caused lockdep to produce an incorrect deadlock report.

Bart.
