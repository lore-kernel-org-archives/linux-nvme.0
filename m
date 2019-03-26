From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 26 Mar 2019 09:39:36 +0800
Subject: [PATCH 1/2] nvme: target: fix nvmet_file_init_bvec()
In-Reply-To: <20190325105231.GA24907@lst.de>
References: <20190325100708.24172-1-ming.lei@redhat.com>
 <20190325100708.24172-2-ming.lei@redhat.com>
 <20190325105231.GA24907@lst.de>
Message-ID: <20190326013935.GC30669@ming.t460p>

On Mon, Mar 25, 2019@11:52:31AM +0100, Christoph Hellwig wrote:
> On Mon, Mar 25, 2019@06:07:07PM +0800, Ming Lei wrote:
> > There isn't sg iterator helper for building bvec, so invent one
> > and fix the issue in nvmet_file_init_bvec().
> > 
> > The issue is that one sg may include multipge continuous pages, and
> > only the 1st .bv_offset isn't zero, also the length for the last bvec
> > has to consider the remained length.
> 
> The scatterlist in the nvme target is always allocated by the nvmet
> code itself an thus never contains multi-page sg list entries.

I am wondering if it is true.

Not look at other target code yet, however seems it isn't true for loop,
see the following code in nvme_loop_queue_rq():

	iod->req.sg = iod->sg_table.sgl;
	iod->req.sg_cnt = blk_rq_map_sg(req->q, req, iod->sg_table.sgl);
	iod->req.transfer_len = blk_rq_payload_bytes(req);

And it has been triggered by nvme/011 in Yi's test.

Thanks,
Ming
