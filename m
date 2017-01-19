From: parav@mellanox.com (Parav Pandit)
Date: Thu, 19 Jan 2017 15:45:30 +0000
Subject: [PATCHv3] nvmet-rdma: Fix missing dma sync to nvme data structures
In-Reply-To: <20170119152240.GA32400@lst.de>
References: <1484785346-2991-1-git-send-email-parav@mellanox.com>
 <20170119152240.GA32400@lst.de>
Message-ID: <VI1PR0502MB300864C57897C37D4397A76AD17E0@VI1PR0502MB3008.eurprd05.prod.outlook.com>

Hi Christoph,

> -----Original Message-----
> From: Christoph Hellwig [mailto:hch at lst.de]
> Sent: Thursday, January 19, 2017 9:23 AM
> To: Parav Pandit <parav at mellanox.com>
> Cc: hch at lst.de; sagi at grimberg.me; linux-nvme at lists.infradead.org; linux-
> rdma at vger.kernel.org; dledford at redhat.com
> Subject: Re: [PATCHv3] nvmet-rdma: Fix missing dma sync to nvme data
> structures
> 
> >
> > +	ib_dma_sync_single_for_cpu(queue->dev->device,
> > +		cmd->cmd->sge[0].addr, cmd->cmd->sge[0].length,
> > +		DMA_FROM_DEVICE);
> > +	ib_dma_sync_single_for_cpu(queue->dev->device,
> > +			cmd->send_sge.addr, cmd->send_sge.length,
> > +			DMA_TO_DEVICE);
> 
> Why the different indentation here?  Both one or two tab indents look fine to
> me in this context, but don't mix them.
> 
I agree. I should have taken care of that.
Shall I resend patch with same indentation at all places or this can be taken care during commit?

> Except for that this looks fine:
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>
