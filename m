From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 9 Aug 2017 10:27:49 -0600
Subject: Flush warning
In-Reply-To: <00ff01d3112b$94142350$bc3c69f0$@opengridcomputing.com>
References: <016301d30c86$e7034ae0$b509e0a0$@opengridcomputing.com>
 <9bc142de-b8ba-acb6-5ea1-2ccdbb578655@grimberg.me>
 <003401d30f91$c7e2a3f0$57a7ebd0$@opengridcomputing.com>
 <00ff01d3112b$94142350$bc3c69f0$@opengridcomputing.com>
Message-ID: <20170809162749.GA4069@obsidianresearch.com>

On Wed, Aug 09, 2017@11:21:38AM -0500, Steve Wise wrote:

> > I don't know.  I read the workqueue doc on WQ_MEM_RECLAIM, but I don't know
> > how
> > to tell if iw_cm needs this or not.  Can you give me an example of a workqueue
> > that _does_ need WQ_MEM_RECLAIM?  I _think_ it means your workqueue is
> > required
> > to run something that would get triggered by the oom OS code, but I don't know
> > if that would include rdma CMs or not...
> 
> Many of the workqueues in infiniband/core use WQ_MEM_RECLAIM: cma, iwcm, mad,
> multicast, sa_query, and ucma. 
> 
> Hey Sean, do you have any insight into whether the CMA modules really need
> WQ_MEM_RECLAIM for their workqueues?
> 
> Does anyone else know?

Consider that the ib_core can be used to back storage. Ie consider a
situation where iSER/NFS/SRP needs to reconnect to respond to kernel
paging/reclaim.

On the surface it seems reasonable to me that these are on a reclaim
path?

Jason
