From: hch@lst.de (Christoph Hellwig)
Date: Wed, 13 Jul 2016 04:18:31 +0200
Subject: [PATCH] nvme-fabrics: get ctrl reference in nvmf_dev_write
In-Reply-To: <1468363122-11073-1-git-send-email-mlin@kernel.org>
References: <1468363122-11073-1-git-send-email-mlin@kernel.org>
Message-ID: <20160713021831.GA7782@lst.de>

On Tue, Jul 12, 2016@03:38:42PM -0700, Ming Lin wrote:
> From: Ming Lin <ming.l at samsung.com>
> 
> Below crash was triggered when shutting down a nvme host node
> via 'reboot' that has 1 target device attached.
> 
> That's because nvmf_dev_release() put the ctrl reference, but
> we didn't get the reference in nvmf_dev_write().
> 
> So the ctrl was freed in nvme_rdma_free_ctrl() before nvme_rdma_free_ring()
> was called.

The ->create_ctrl methods do a kref_init for the main refererence,
and a kref_get for the reference that nvmf_dev_release drops,
so I'm a bit confused how this case could happen.  I think we'll need to
dig a bit deeper on what's actually happening here.
