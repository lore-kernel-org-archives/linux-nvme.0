From: hch@lst.de (Christoph Hellwig)
Date: Tue, 7 Nov 2017 20:22:45 +0100
Subject: [PATCH 1/1] nvme-rdma: Fix nvme_rdma_create_queue_ib error flow
In-Reply-To: <1509977931-18160-1-git-send-email-maxg@mellanox.com>
References: <1509977931-18160-1-git-send-email-maxg@mellanox.com>
Message-ID: <20171107192245.GC30306@lst.de>

On Mon, Nov 06, 2017@04:18:51PM +0200, Max Gurtovoy wrote:
> QP object is created using rdma_cm api, therefore the destruction
> should use the same api for symmetry.
> 
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>

Thanks, applied to nvme-4.15.
