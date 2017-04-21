From: hch@lst.de (Christoph Hellwig)
Date: Fri, 21 Apr 2017 08:44:27 +0200
Subject: [PATCH v2 3/4] nvme: enable SG gaps support
In-Reply-To: <2bd673ee-8455-32b7-1bad-34fa9eebb076@grimberg.me>
References: <1492098977-5231-1-git-send-email-maxg@mellanox.com>
 <1492098977-5231-4-git-send-email-maxg@mellanox.com>
 <2bd673ee-8455-32b7-1bad-34fa9eebb076@grimberg.me>
Message-ID: <20170421064427.GB6095@lst.de>

On Thu, Apr 20, 2017@02:27:59PM +0300, Sagi Grimberg wrote:
> I think it would be better if the ctrl will hold a virt_boundary
> provided by the fabric driver? Then we would always
> blk_queue_virt_boundary but with capable devices the fabric driver
> can set it to 0. This will also allow for dword aligned sgls to
> fit in pretty easily.

All our block I/O must be cache line aligned, so dword aligned SGLs
should not be an issue.  And for PRPs or MRs we'll always use the
host page size.

But I don't think I really care in the end..
