From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 27 Oct 2016 12:24:24 +0300
Subject: [PATCH 1/2] nvme: introduce struct nvme_request
In-Reply-To: <1477411779-2993-2-git-send-email-hch@lst.de>
References: <1477411779-2993-1-git-send-email-hch@lst.de>
 <1477411779-2993-2-git-send-email-hch@lst.de>
Message-ID: <5293ea38-f0ee-f0a0-9469-537444aab0db@grimberg.me>


> +/*
> + * Common request structure for NVMe passthrough.  All drivers must have
> + * this structure as the first member of their request-private data.
> + */
> +struct nvme_request {
> +	struct nvme_command	*cmd;
> +	union nvme_result	result;
> +};

I sorta agree with James, can we not enforce a "hidden assumption"
of the core on how the transport drivers structures are built?

> +
> +static inline struct nvme_request *nvme_req(struct request *req)
> +{
> +	return blk_mq_rq_to_pdu(req);
> +}

Maybe this can be a ctrl->ops->nvme_req() instead?
