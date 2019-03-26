From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 26 Mar 2019 10:16:28 +0800
Subject: [PATCH 1/2] nvme: target: fix nvmet_file_init_bvec()
In-Reply-To: <a850ff6c-f006-9b1b-5425-19cc6a1693c7@grimberg.me>
References: <20190325100708.24172-1-ming.lei@redhat.com>
 <20190325100708.24172-2-ming.lei@redhat.com>
 <20190325105231.GA24907@lst.de> <20190326013935.GC30669@ming.t460p>
 <a850ff6c-f006-9b1b-5425-19cc6a1693c7@grimberg.me>
Message-ID: <20190326021627.GE30669@ming.t460p>

On Mon, Mar 25, 2019@07:03:23PM -0700, Sagi Grimberg wrote:
> 
> > > The scatterlist in the nvme target is always allocated by the nvmet
> > > code itself an thus never contains multi-page sg list entries.
> > 
> > I am wondering if it is true.
> > 
> > Not look at other target code yet, however seems it isn't true for loop,
> > see the following code in nvme_loop_queue_rq():
> > 
> > 	iod->req.sg = iod->sg_table.sgl;
> > 	iod->req.sg_cnt = blk_rq_map_sg(req->q, req, iod->sg_table.sgl);
> > 	iod->req.transfer_len = blk_rq_payload_bytes(req);
> > 
> > And it has been triggered by nvme/011 in Yi's test.
> 
> Yes, loop is an exception in this case.

Thanks for the clarification!

Another candidate fix is to set nvmet-loop's queue segment boundary mask
as PAGE_SIZE - 1.

Also there is the same issue for block device backed target.

If no one objects, I'd like to take the approach of adjusting segment
boundary mask.

Thanks,
Ming
