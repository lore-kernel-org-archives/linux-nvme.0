From: hch@lst.de (Christoph Hellwig)
Date: Mon, 11 Mar 2019 19:40:31 +0100
Subject: [PATCH 5/5] nvme/pci: Remove queue IO flushing hack
In-Reply-To: <20190308174006.5032-5-keith.busch@intel.com>
References: <20190308174006.5032-1-keith.busch@intel.com>
 <20190308174006.5032-5-keith.busch@intel.com>
Message-ID: <20190311184031.GA11707@lst.de>

>From a quick look the code seems reasonably sensible here,
but any chance we could have this in common code?

> +static bool nvme_fail_queue_request(struct request *req, void *data, bool reserved)
> +{
> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +	struct nvme_queue *nvmeq = iod->nvmeq;
> +
> +	if (!test_bit(NVMEQ_ENABLED, &nvmeq->flags))
> +		blk_mq_end_request(req, BLK_STS_IOERR);
> +	return true;
> +}

The only thing not purely block layer here is the enabled flag.
So if we had a per-hctx enabled flag we could lift this out of nvme,
and hopefully start reusing it in other drivers.
