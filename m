From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 4 Jan 2019 10:07:10 -0800
Subject: [PATCH v2] nvme-pci: fix dbbuf_sq_db point to freed memory
In-Reply-To: <E5D59058E6941147BD3ACF9CB4AA49E3B3572EC2@DGGEMA505-MBX.china.huawei.com>
References: <E5D59058E6941147BD3ACF9CB4AA49E3B3572EC2@DGGEMA505-MBX.china.huawei.com>
Message-ID: <20190104180710.GA4642@infradead.org>

On Fri, Dec 21, 2018@01:07:25AM +0000, Lulina (A) wrote:
> The case is that nvme device support NVME_CTRL_OACS_DBBUF_SUPP, and
> return failed when the driver sent nvme_admin_dbbuf. The nvmeq->dbbuf_sq_db
> point to freed memory, as nvme_dbbuf_set is called after nvme_dbbuf_init.

But we never use those pointers in that state, do we?  Can you explain
the problem in a little more detail?
