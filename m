From: hch@lst.de (Christoph Hellwig)
Date: Wed, 8 Nov 2017 19:17:54 +0100
Subject: [PATCH 1/1] nvme-rdma: Introduce
 nvme_rdma_configure_blk/nvme_rdma_destroy_blk
In-Reply-To: <1510060989-10391-1-git-send-email-maxg@mellanox.com>
References: <1510060989-10391-1-git-send-email-maxg@mellanox.com>
Message-ID: <20171108181754.GA471@lst.de>

On Tue, Nov 07, 2017@03:23:09PM +0200, Max Gurtovoy wrote:
> Create new helpers to avoid code and logic duplication between admin/IO
> block layer resources creation and destruction.

How is this going to interact with Sagi's refactoring in this area?
