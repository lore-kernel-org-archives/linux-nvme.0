From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Tue, 14 Mar 2017 21:32:12 +0000
Subject: [PATCH rfc 06/10] IB/cq: Don't force IB_POLL_DIRECT poll
 context for ib_process_cq_direct
In-Reply-To: <f4ade02b-9d17-20ae-f910-47c718f2a5bd@grimberg.me>
References: <1489065402-14757-1-git-send-email-sagi@grimberg.me>
 <1489065402-14757-7-git-send-email-sagi@grimberg.me>
 <1489077040.2597.3.camel@sandisk.com>
 <f4ade02b-9d17-20ae-f910-47c718f2a5bd@grimberg.me>
Message-ID: <1489527119.2676.15.camel@sandisk.com>

On Mon, 2017-03-13@10:24 +0200, Sagi Grimberg wrote:
> > Before this patch
> > the completions from each CQ were processed sequentially. That's a big
> > change so I think this should be mentioned clearly in the header above
> > ib_process_cq_direct().
> 
> Note that I now see that the cq lock is not sufficient for mutual
> exclusion here because we're referencing cq->wc array outside of it.
> 
> There are three options I see here:
> 1. we'll need to allocate a different wc array for polling mode,
> perhaps a smaller one?
> 2. Export __ib_process_cq (in some form) with an option to pass in a wc
> array.
> 3. Simply not support non-selective polling but it seems like a shame...
> 
> Any thoughts?

I doubt it is possible to come up with an algorithm that recognizes whether
or not two different ib_process_cq() calls are serialized. So the
ib_process_cq() caller will have to provide that information. How about adding
an ib_wc array argument to ib_process_cq() and modifying __ib_process_cq()
such that it uses that array if specified and cq->wc otherwise?

Bart.
