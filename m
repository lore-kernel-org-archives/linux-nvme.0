From: bvanassche@acm.org (Bart Van Assche)
Date: Fri, 08 Mar 2019 10:19:08 -0800
Subject: [PATCH 5/5] nvme/pci: Remove queue IO flushing hack
In-Reply-To: <20190308174006.5032-5-keith.busch@intel.com>
References: <20190308174006.5032-1-keith.busch@intel.com>
 <20190308174006.5032-5-keith.busch@intel.com>
Message-ID: <1552069148.45180.32.camel@acm.org>

On Fri, 2019-03-08@10:40 -0700, Keith Busch wrote:
> +static bool nvme_fail_queue_request(struct request *req, void *data, bool reserved)
> +{
> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +	struct nvme_queue *nvmeq = iod->nvmeq;
> +
> +	if (!test_bit(NVMEQ_ENABLED, &nvmeq->flags))
> +		blk_mq_end_request(req, BLK_STS_IOERR);
> +	return true;
> +}

Same question here as for patch 4/5: what prevents concurrent calls of
blk_mq_complete_request() with the blk_mq_end_request() call in the
above function?

Thanks,

Bart.
