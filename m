From: kbusch@kernel.org (Keith Busch)
Date: Mon, 11 Mar 2019 13:37:53 -0600
Subject: [PATCH 5/5] nvme/pci: Remove queue IO flushing hack
In-Reply-To: <20190311184031.GA11707@lst.de>
References: <20190308174006.5032-1-keith.busch@intel.com>
 <20190308174006.5032-5-keith.busch@intel.com>
 <20190311184031.GA11707@lst.de>
Message-ID: <20190311193753.GE10411@localhost.localdomain>

On Mon, Mar 11, 2019@07:40:31PM +0100, Christoph Hellwig wrote:
> From a quick look the code seems reasonably sensible here,
> but any chance we could have this in common code?
> 
> > +static bool nvme_fail_queue_request(struct request *req, void *data, bool reserved)
> > +{
> > +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> > +	struct nvme_queue *nvmeq = iod->nvmeq;
> > +
> > +	if (!test_bit(NVMEQ_ENABLED, &nvmeq->flags))
> > +		blk_mq_end_request(req, BLK_STS_IOERR);
> > +	return true;
> > +}
> 
> The only thing not purely block layer here is the enabled flag.
> So if we had a per-hctx enabled flag we could lift this out of nvme,
> and hopefully start reusing it in other drivers.

Okay, I may even be able to drop the new block exports if we do request
termination in generic block layer. That's probably the right thing
anyway since that layer is in a better position to check the necessary
conditions that make tag iteration safe. Bart did point out that is
generally not safe for drives to do, so it'd be good to safegaurd against
incorrect usage.
