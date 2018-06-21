From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 21 Jun 2018 08:06:24 -0700
Subject: [PATCH] nvme: use __GFP_NOWARN for iod allocation
In-Reply-To: <87f5c54b-dc09-817b-0660-440a75af7407@kernel.dk>
References: <4cb394ca-7032-ea67-5bb1-ef331e42ace2@kernel.dk>
 <b054a000-c7ad-9926-b45f-2771a98b7d23@kernel.dk>
 <b51cce4d-d0c9-fb4e-d5ac-2e48e23e18f7@kernel.dk>
 <20180621070954.GA21304@infradead.org>
 <ce58c5ca-e2cd-de6a-a021-7f65b56d8a21@kernel.dk>
 <20180621145812.GB17825@infradead.org>
 <87f5c54b-dc09-817b-0660-440a75af7407@kernel.dk>
Message-ID: <20180621150624.GA1718@infradead.org>

On Thu, Jun 21, 2018@09:02:18AM -0600, Jens Axboe wrote:
> >From a quick look, the fabric code goes through the same nvme_queue_rq()
> and ends up doing the same iod->sg allocation. I don't see any use of
> chained sg lists, we're allocating one big sg table for the command.

nvme_queue_rq is only used for PCIe.

E.g. for RDMA the call is:

nvme_rdma_queue_rq
 -> nvme_rdma_map_data
  -> sg_alloc_table_chained

similar for FC and loop.
