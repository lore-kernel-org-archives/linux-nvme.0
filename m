From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 13 Dec 2017 14:43:09 +0800
Subject: [PATCH 6/6] nvme: remove .init_request callback
In-Reply-To: <20171212151032.GA15078@ming.t460p>
References: <20171212110232.12495-1-ming.lei@redhat.com>
 <20171212110232.12495-7-ming.lei@redhat.com>
 <20171212141358.GB7849@lst.de> <20171212151032.GA15078@ming.t460p>
Message-ID: <20171213064151.GA1693@ming.t460p>

On Tue, Dec 12, 2017@11:10:32PM +0800, Ming Lei wrote:
> On Tue, Dec 12, 2017@03:13:58PM +0100, Christoph Hellwig wrote:
> > On Tue, Dec 12, 2017@07:02:32PM +0800, Ming Lei wrote:
> > > It may cause race by setting 'nvmeq' in nvme_init_request()
> > > because .init_request is called inside switching io scheduler, which
> > > may happen when the NVMe device is being resetted and its nvme queues
> > > are being freed and created. We don't have any sync between the two
> > > pathes.
> > > 
> > > This patch removes the .init_request callback and sets the nvmeq runtime,
> > > and fixes the following bug:
> > 
> > If ->init_request doesn't work for NVMe it won't work for any other
> > driver either, so we need to remove it entirely if we can't fix it.
> > 
> > I'd much rather try to fix it first, though.
> 
> Just checked all this uses, and it is a NVMe specific issue, because only
> NVMe's .init_request() associates reference of one variable to the request,
> and the variable itself may change during the request's lifetime.
> 
> And all the following .init_request() have this issue:
> 
> 	nvme_fc_init_request()
> 	nvme_rdma_init_request()
> 	nvme_loop_init_request()

After taking a close look, there isn't such issue actually on the above
three cases because the lifetime of ctl->queues(and each element) are
same with 'nvme_ctr/nvme_rdma_ctrl/nvme_loop_ctrl'. Not like nvme-pci,
->queues(and each element) won't be reallocated.

So it is a nvme-pci specific issue.

Thanks,
Ming
