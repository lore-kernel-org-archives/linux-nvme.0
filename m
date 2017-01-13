From: parav@mellanox.com (Parav Pandit)
Date: Fri, 13 Jan 2017 15:08:07 +0000
Subject: [PATCH] nvmet-rdma: Fix missing dma sync to nvme data	structures
In-Reply-To: <20170113074420.GA25814@lst.de>
References: <1484261109-3316-1-git-send-email-parav@mellanox.com>
 <20170113074420.GA25814@lst.de>
Message-ID: <VI1PR0502MB30086F641A07262801C02A28D1780@VI1PR0502MB3008.eurprd05.prod.outlook.com>

Hi Christoph,

> -----Original Message-----
> From: Christoph Hellwig [mailto:hch at lst.de]
> Sent: Friday, January 13, 2017 1:44 AM
> To: Parav Pandit <parav at mellanox.com>
> Cc: hch at lst.de; sagi at grimberg.me; linux-nvme at lists.infradead.org; linux-
> rdma at vger.kernel.org; dledford at redhat.com
> Subject: Re: [PATCH] nvmet-rdma: Fix missing dma sync to nvme data
> structures
> 
> On Thu, Jan 12, 2017@04:45:09PM -0600, Parav Pandit wrote:
> > This patch performs dma sync operations on nvme_commmand, inline
> > page(s) and nvme_completion.
> >
> > nvme_command and write cmd inline data is synced
> > (a) on receiving of the recv queue completion for cpu access.
> > (b) before posting recv wqe back to rdma adapter for device access.
> >
> > nvme_completion is synced
> > (a) on receiving send completion for nvme_completion for cpu access.
> > (b) before posting send wqe to rdma adapter for device access.
> >
> > Pushing this patch through linux-rdma tree as its more relavant with
> > Bart's changes for dma_map_ops of[1].
> >
> > [1] https://patchwork.kernel.org/patch/9514085/
> 
> This seems like a fix for 4.10-rc as the old code is buggy on not DMA coherent
> architectures, so I suspect it should go in without being based on Barts
> cleanup.
> 
I first found and tested on git://git.infradead.org/nvme-fabrics.git in nvmf-4.10 branch.
If it has to go to 4.10-rc in above git repo,

Doug needs to rebase to above git tree.
Followed by Bart's patches, followed by my changes in his tree.
Without that, Linux-next will get compile error because ib_dma_xx won't be defined.
Let me know, I have 4.10-rc patch also tested.

> Btw, what architecture did you test this with?  One of the not coherent ARM
> SOCs?
On x86_64.
Currently testing on ARM.
While doing some performance improvement using inline sge mode, I encounter this bug in review.
