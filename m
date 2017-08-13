From: leon@kernel.org (Leon Romanovsky)
Date: Sun, 13 Aug 2017 09:46:51 +0300
Subject: Flush warning
In-Reply-To: <011601d3112d$fa305b70$ee911250$@opengridcomputing.com>
References: <016301d30c86$e7034ae0$b509e0a0$@opengridcomputing.com>
 <9bc142de-b8ba-acb6-5ea1-2ccdbb578655@grimberg.me>
 <003401d30f91$c7e2a3f0$57a7ebd0$@opengridcomputing.com>
 <00ff01d3112b$94142350$bc3c69f0$@opengridcomputing.com>
 <20170809162749.GA4069@obsidianresearch.com>
 <011601d3112d$fa305b70$ee911250$@opengridcomputing.com>
Message-ID: <20170813064651.GR24282@mtr-leonro.local>

On Wed, Aug 09, 2017@11:38:49AM -0500, Steve Wise wrote:
> > On Wed, Aug 09, 2017@11:21:38AM -0500, Steve Wise wrote:
> >
> > > > I don't know.  I read the workqueue doc on WQ_MEM_RECLAIM, but I don't
> > know
> > > > how
> > > > to tell if iw_cm needs this or not.  Can you give me an example of a
> workqueue
> > > > that _does_ need WQ_MEM_RECLAIM?  I _think_ it means your workqueue is
> > > > required
> > > > to run something that would get triggered by the oom OS code, but I don't
> know
> > > > if that would include rdma CMs or not...
> > >
> > > Many of the workqueues in infiniband/core use WQ_MEM_RECLAIM: cma, iwcm,
> > mad,
> > > multicast, sa_query, and ucma.
> > >
> > > Hey Sean, do you have any insight into whether the CMA modules really need
> > > WQ_MEM_RECLAIM for their workqueues?
> > >
> > > Does anyone else know?
> >
> > Consider that the ib_core can be used to back storage. Ie consider a
> > situation where iSER/NFS/SRP needs to reconnect to respond to kernel
> > paging/reclaim.
> >
> > On the surface it seems reasonable to me that these are on a reclaim
> > path?
> >
> > Jason
>
> hmm.  That seems reasonable.  Then I would think the nvme_rdma would also need
> to be using a reclaim workqueue.
>
> Sagi, Do you think I should add a private workqueue with WQ_MEM_RECLAIM to
> nvme_rdma vs using the system_wq?  nvme/target probably needs one also...

The workqueue which frees the memory and doesn't allocate memory during execution
is supposed to be marked as WQ_MEM_RECLAIM. This flag will cause to priority increase
for such workqueue during low memory conditions.

I don't remember it for sure, but I think that shrinker will call to
such workqueue in these conditions. In normal conditions, it won't
change a lot.

Thanks

>
> Steve.
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170813/eabd2a36/attachment.sig>
