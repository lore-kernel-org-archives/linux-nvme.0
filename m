From: hch@lst.de (Christoph Hellwig)
Date: Thu, 6 Jul 2017 17:28:34 +0200
Subject: [PATCH] nvme-pci: compile warnings in nvme_alloc_host_mem()
In-Reply-To: <20170706092651.dshe5uxn665icxma@mwanda>
References: <20170706092651.dshe5uxn665icxma@mwanda>
Message-ID: <20170706152834.GA2160@lst.de>

On Thu, Jul 06, 2017@12:26:52PM +0300, Dan Carpenter wrote:
> "i" should be signed or it could cause a forever loop on the cleanup
> path. "size" can be used uninitialized.

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
