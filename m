From: parav@mellanox.com (Parav Pandit)
Date: Thu, 19 Jan 2017 15:51:25 +0000
Subject: [PATCHv3] nvmet-rdma: Fix missing dma sync to nvme data structures
In-Reply-To: <20170119154601.GA597@lst.de>
References: <1484785346-2991-1-git-send-email-parav@mellanox.com>
 <20170119152240.GA32400@lst.de>
 <VI1PR0502MB300864C57897C37D4397A76AD17E0@VI1PR0502MB3008.eurprd05.prod.outlook.com>
 <20170119154601.GA597@lst.de>
Message-ID: <VI1PR0502MB30085FE37E38A20D99BD03C0D17E0@VI1PR0502MB3008.eurprd05.prod.outlook.com>

After sending I realized that Doug might also need to do that to merge this to Linux-rdma so that Bart's dma_ops series works correctly.
So its work for more people.
Let me just resend it. Its minor.

Parav

> -----Original Message-----
> From: Christoph Hellwig [mailto:hch at lst.de]
> Sent: Thursday, January 19, 2017 9:46 AM
> To: Parav Pandit <parav at mellanox.com>
> Cc: Christoph Hellwig <hch at lst.de>; sagi at grimberg.me; linux-
> nvme at lists.infradead.org; linux-rdma at vger.kernel.org;
> dledford at redhat.com
> Subject: Re: [PATCHv3] nvmet-rdma: Fix missing dma sync to nvme data
> structures
> 
> On Thu, Jan 19, 2017@03:45:30PM +0000, Parav Pandit wrote:
> > I agree. I should have taken care of that.
> > Shall I resend patch with same indentation at all places or this can be taken
> care during commit?
> 
> I think Sagi or I can just take care of it on commit.
