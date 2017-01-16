From: parav@mellanox.com (Parav Pandit)
Date: Mon, 16 Jan 2017 17:18:15 +0000
Subject: [PATCH] nvmet-rdma: Fix missing dma sync to nvme data	structures
In-Reply-To: <20170116153109.GA16170@lst.de>
References: <1484412337-10860-1-git-send-email-parav@mellanox.com>
 <20170116153109.GA16170@lst.de>
Message-ID: <VI1PR0502MB3008EBE381C87D629A784279D17D0@VI1PR0502MB3008.eurprd05.prod.outlook.com>



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch at lst.de]
> Sent: Monday, January 16, 2017 9:31 AM
> To: Parav Pandit <parav at mellanox.com>
> Cc: hch at lst.de; sagi at grimberg.me; linux-nvme at lists.infradead.org; linux-
> rdma at vger.kernel.org; dledford at redhat.com
> Subject: Re: [PATCH] nvmet-rdma: Fix missing dma sync to nvme data
> structures
> 
> > +++ b/drivers/nvme/target/rdma.c
> > @@ -438,6 +438,14 @@ static int nvmet_rdma_post_recv(struct
> > nvmet_rdma_device *ndev,  {
> >  	struct ib_recv_wr *bad_wr;
> >
> > +	ib_dma_sync_single_for_device(ndev->device,
> > +			cmd->sge[0].addr, sizeof(*cmd->nvme_cmd),
> > +			DMA_FROM_DEVICE);
> > +
> > +	if (cmd->sge[1].addr)
> 
> 0 can be a valid address returned from dma_map_single on some
> architectures.

I see. I will change it to check for the non-zero length instead of non-zero address.
