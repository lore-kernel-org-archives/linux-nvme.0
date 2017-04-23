From: hch@lst.de (Christoph Hellwig)
Date: Sun, 23 Apr 2017 10:45:53 +0200
Subject: [PATCH v2 3/4] nvme: enable SG gaps support
In-Reply-To: <9ff1a2e8-f84f-c772-e294-2339eee8e37d@grimberg.me>
References: <1492098977-5231-1-git-send-email-maxg@mellanox.com>
 <1492098977-5231-4-git-send-email-maxg@mellanox.com>
 <2bd673ee-8455-32b7-1bad-34fa9eebb076@grimberg.me>
 <20170421064427.GB6095@lst.de>
 <9ff1a2e8-f84f-c772-e294-2339eee8e37d@grimberg.me>
Message-ID: <20170423084553.GA24434@lst.de>

On Sun, Apr 23, 2017@10:20:59AM +0300, Sagi Grimberg wrote:
> Christoph,
>
>> All our block I/O must be cache line aligned, so dword aligned SGLs
>> should not be an issue.  And for PRPs or MRs we'll always use the
>> host page size.
>
> Where is that constraint coming from? Is that new? Back when I wrote
> GAP support in rdma I tested a single byte alignment via vectored
> direct IO and it seemed to be going through...

Each block queue has a ->dma_alignment field, which is set to 511
by default unless changed.  Everything not aligned to that will be
bounced in __blk_rq_map_user_iov and friends before we send it to
the driver.

> I also just tested Bart's unaligned test [1] on scsi_debug and it seems
> to go through as well (alignment and length are 4)...

SCSI reduces the alignment in __scsi_init_queue:

	/*
         * set a reasonable default alignment on word boundaries: the
	 * host and device may alter it using
	 * blk_queue_update_dma_alignment() later.
	 */
	blk_queue_dma_alignment(q, 0x03);

still would fit NVMe dword-alignment SGLs, though :)
