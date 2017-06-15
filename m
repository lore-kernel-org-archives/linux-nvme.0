From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 15 Jun 2017 14:21:08 +0200
Subject: [PATCH] nvme-rdma: fix error code in nvme_rdma_create_ctrl()
In-Reply-To: <20170614104645.GO29394@elgon.mountain>
References: <20170614104645.GO29394@elgon.mountain>
Message-ID: <20170615122108.xxih3xj44k6ltclk@infradead.org>

On Wed, Jun 14, 2017@01:46:45PM +0300, Dan Carpenter wrote:
> We accidentally return ERR_PTR(0) which is NULL.  The caller isn't
> explicitly checking for that but I couldn't immediately spot whether
> this would lead to a NULL dereference.  Anyway, we can fix add an
> error code easily enough.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter at oracle.com>

Thanks Dan,

applied to nvme-4.13.
