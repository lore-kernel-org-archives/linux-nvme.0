From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 3 Nov 2017 00:02:51 -0700
Subject: [PATCH 1/1] nvme-rdma: Introduce nvme_rdma_destroy_qp
In-Reply-To: <1509540706-26130-1-git-send-email-maxg@mellanox.com>
References: <1509540706-26130-1-git-send-email-maxg@mellanox.com>
Message-ID: <20171103070251.GA31429@infradead.org>

On Wed, Nov 01, 2017@02:51:46PM +0200, Max Gurtovoy wrote:
> QP object is created using rdma_cm api, therefore the destruction
> should use the same api for symmetry.

Please resend against current nvme-4.15.
