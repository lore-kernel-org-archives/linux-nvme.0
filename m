From: hch@lst.de (Christoph Hellwig)
Date: Mon, 16 Jan 2017 18:30:02 +0100
Subject: [PATCH] nvmet-rdma: Fix missing dma sync to nvme data structures
In-Reply-To: <VI1PR0502MB3008EBE381C87D629A784279D17D0@VI1PR0502MB3008.eurprd05.prod.outlook.com>
References: <1484412337-10860-1-git-send-email-parav@mellanox.com>
 <20170116153109.GA16170@lst.de>
 <VI1PR0502MB3008EBE381C87D629A784279D17D0@VI1PR0502MB3008.eurprd05.prod.outlook.com>
Message-ID: <20170116173002.GA6298@lst.de>

On Mon, Jan 16, 2017@05:18:15PM +0000, Parav Pandit wrote:
> I see. I will change it to check for the non-zero length instead of non-zero address.

Yes, that should work as well.
