From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 23 Jul 2019 09:10:41 +0800
Subject: [PATCH 0/5] blk-mq: wait until completed req's complete fn is run
In-Reply-To: <a22e7266-98cb-875d-aa89-f37dd6c34ad5@oracle.com>
References: <20190722053954.25423-1-ming.lei@redhat.com>
 <a22e7266-98cb-875d-aa89-f37dd6c34ad5@oracle.com>
Message-ID: <20190723011040.GE30776@ming.t460p>

On Tue, Jul 23, 2019@07:27:00AM +0800, Bob Liu wrote:
> On 7/22/19 1:39 PM, Ming Lei wrote:
> > Hi,
> > 
> > blk-mq may schedule to call queue's complete function on remote CPU via
> > IPI, but never provide any way to synchronize the request's complete
> > fn.
> > 
> > In some driver's EH(such as NVMe), hardware queue's resource may be freed &
> > re-allocated. If the completed request's complete fn is run finally after the
> > hardware queue's resource is released, kernel crash will be triggered.
> > 
> 
> Have you seen the crash? Anyway to emulate/verify this bug..

The crash is reported on nvme-rdma by one RH partner, and the approach
of this patchset has been verified already.

Thanks,
Ming
