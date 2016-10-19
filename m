From: hch@lst.de (Christoph Hellwig)
Date: Wed, 19 Oct 2016 12:34:23 +0200
Subject: [PATCH] nvmet-rdma: Fix REJ status code
In-Reply-To: <10b8f472-ea1b-5449-e24a-f6bbee8a4d54@sandisk.com>
References: <10b8f472-ea1b-5449-e24a-f6bbee8a4d54@sandisk.com>
Message-ID: <20161019103423.GC525@lst.de>

On Tue, Oct 18, 2016@12:59:47PM -0700, Bart Van Assche wrote:
> nvmet_sq_init() returns a value <= 0. nvmet_rdma_cm_reject() expects
> a second argument that is a NVME_RDMA_CM_* constant. Hence this patch.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
