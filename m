From: kbusch@kernel.org (Keith Busch)
Date: Mon, 18 Mar 2019 09:53:26 -0600
Subject: [PATCH 2/8] blk-mq: change the method of iterating busy tags of
 a request_queue
In-Reply-To: <CACVXFVM=r-jS_GnkAuARiiXLr3bQeWV5Gix3+F03B5oYbmdULw@mail.gmail.com>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
 <1552640264-26101-3-git-send-email-jianchao.w.wang@oracle.com>
 <20190315161608.GB15153@localhost.localdomain>
 <CACVXFVM=r-jS_GnkAuARiiXLr3bQeWV5Gix3+F03B5oYbmdULw@mail.gmail.com>
Message-ID: <20190318155326.GB23533@localhost.localdomain>

On Sat, Mar 16, 2019@11:50:27PM -0700, Ming Lei wrote:
> On Sat, Mar 16, 2019@12:15 AM Keith Busch <kbusch@kernel.org> wrote:
> > On Fri, Mar 15, 2019@01:57:38AM -0700, Jianchao Wang wrote:
> > > +     if (rq && rq->q == hctx->queue &&
> > > +         rq->mq_hctx == hctx &&
> > > +         (!iter_data->inflight ||
> > > +          blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT))
> > > +             return iter_data->fn(rq, iter_data->data, reserved);
> >
> > There is still a window where the check may succeed, but the request is
> > being assigned to a completely different request_queue. The callback
> > then operates on a request it doesn't own.
> 
> The situation above is only related with 'none' io scheduler.
> 
> However, this patch doesn't change behavior for none given .rq[tag] is same with
> .static_rq[tag], so I guess your concern may not be related with this patch.

Right, it's not new, but queue iteration wasn't exported for drivers
before this.
