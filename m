From: hch@lst.de (Christoph Hellwig)
Date: Thu, 19 Jan 2017 16:46:01 +0100
Subject: [PATCHv3] nvmet-rdma: Fix missing dma sync to nvme data structures
In-Reply-To: <VI1PR0502MB300864C57897C37D4397A76AD17E0@VI1PR0502MB3008.eurprd05.prod.outlook.com>
References: <1484785346-2991-1-git-send-email-parav@mellanox.com>
 <20170119152240.GA32400@lst.de>
 <VI1PR0502MB300864C57897C37D4397A76AD17E0@VI1PR0502MB3008.eurprd05.prod.outlook.com>
Message-ID: <20170119154601.GA597@lst.de>

On Thu, Jan 19, 2017@03:45:30PM +0000, Parav Pandit wrote:
> I agree. I should have taken care of that.
> Shall I resend patch with same indentation at all places or this can be taken care during commit?

I think Sagi or I can just take care of it on commit.
