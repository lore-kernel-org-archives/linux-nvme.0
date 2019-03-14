From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 14 Mar 2019 11:57:55 +0200
Subject: [PATCH 07/17] nvme-fc: use nr_phys_segments to determine
 existence of sgl
In-Reply-To: <20190313175510.20725-8-hch@lst.de>
References: <20190313175510.20725-1-hch@lst.de>
 <20190313175510.20725-8-hch@lst.de>
Message-ID: <a488077e-d68e-a388-4d45-5b966f01f96e@mellanox.com>


On 3/13/2019 7:55 PM, Christoph Hellwig wrote:
> From: James Smart <jsmart2021 at gmail.com>
>
> For some nvme command, when issued by the nvme core layer, there
> is an internal buffer which can cause blk_rq_payload_bytes() to
> return a non-zero value yet there is no actual/real command payload
> and sg list.  An example is the WRITE ZEROES command.
>
> To address this, when making choices on whether to dma map an sgl,
> use blk_rq_nr_phys_segments() instead of blk_rq_payload_bytes().
> When there is a sgl, blk_rq_payload_bytes() will return the amount
> of data to be transferred by the sgl.
>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> Signed-off-by: James Smart <jsmart2021 at gmail.com>
> Signed-off-by: Christoph Hellwig <hch at lst.de>


I guess we'll need it for all transport.

I saw that pci is covered, RDMA isn't.

Also IMO tcp should be fixed (didn't dive into it yet, just high level 
check for blk_rq_payload_bytes).

may we should have a core function for it to reduce code duplication.
