From: hch@lst.de (Christoph Hellwig)
Date: Thu, 23 Nov 2017 09:08:58 +0100
Subject: [PATCH v5 2/4] nvme-rdma: don't complete requests before a
 send work request has completed
In-Reply-To: <20171122185838.28855-3-sagi@grimberg.me>
References: <20171122185838.28855-1-sagi@grimberg.me>
 <20171122185838.28855-3-sagi@grimberg.me>
Message-ID: <20171123080858.GA20524@lst.de>

>  static void nvme_rdma_send_done(struct ib_cq *cq, struct ib_wc *wc)
>  {
> -	if (unlikely(wc->status != IB_WC_SUCCESS))
> +	struct nvme_rdma_qe *qe;
> +	struct nvme_rdma_request *req;
> +	struct request *rq;
> +
> +	if (unlikely(wc->status != IB_WC_SUCCESS)) {
>  		nvme_rdma_wr_error(cq, wc, "SEND");
> +		return;
> +	}
> +
> +	qe = container_of(wc->wr_cqe, struct nvme_rdma_qe, cqe);
> +	req = container_of(qe, struct nvme_rdma_request, sqe);
> +	rq = blk_mq_rq_from_pdu(req);

This add least needs a comment that this is for the AEN request.

Or we'll just use a separate completion handler for the AEN.  In fact
it seems to me that we might want to just stop using nvme_rdma_post_send
for the AEN request and just open code the sending in both callers.
