From: kbusch@kernel.org (Keith Busch)
Date: Tue, 19 Mar 2019 09:25:34 -0600
Subject: [PATCH 0/8]: blk-mq: use static_rqs to iterate busy tags
In-Reply-To: <1553008222.152266.43.camel@acm.org>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
 <1552930085.152266.36.camel@acm.org>
 <3cd58454-eda3-de9a-0eed-b6a7edbce28f@oracle.com>
 <1553008222.152266.43.camel@acm.org>
Message-ID: <20190319152533.GD24176@localhost.localdomain>

On Tue, Mar 19, 2019@08:10:22AM -0700, Bart Van Assche wrote:
> On Tue, 2019-03-19@09:25 +0800, jianchao.wang wrote:
> > Do you mean this patch from Jens ?
> > https://marc.info/?l=linux-block&m=154534605914798&w=2
> > 
> > +	rcu_read_lock();
> >  	sbitmap_for_each_set(&bt->sb, bt_iter, &iter_data);
> > +	rcu_read_unlock();
> > 
> > The busy_iter_fn could sleep for nvme
> > blk_mq_check_expired
> >   -> blk_mq_rq_timed_out
> >     -> q->mq_ops->timeout
> >        nvme_timeout
> >          -> nvme_dev_disable
> >             -> mutex_lock dev->shutdown_lock
> 
> Hi Jianchao,
> 
> I think that's an additional reason to rewrite NVMe error handling ...

Nonesense. Block timeout handling runs in a work queue precicesly so
handlers can actually do useful work in line with the notification.
