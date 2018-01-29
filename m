From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 29 Jan 2018 20:34:26 +0200
Subject: [PATCH v2 1/1] nvme: Add fault injection feature
In-Reply-To: <1516825390-3324-2-git-send-email-thomas.tai@oracle.com>
References: <1516825390-3324-1-git-send-email-thomas.tai@oracle.com>
 <1516825390-3324-2-git-send-email-thomas.tai@oracle.com>
Message-ID: <e3a91c4c-b63e-24a2-63f1-d873fbc63e9c@grimberg.me>


> +void nvme_should_fail(struct request *req)
> +{
> +	struct gendisk *disk = req->rq_disk;
> +	struct nvme_ns *ns = NULL;
> +
> +	/*
> +	 * make sure this request is coming from a valid namespace
> +	 */
> +	if (!disk)
> +		return;
> +
> +	ns = disk->private_data;
> +	if (ns && should_fail(&ns->fault_inject.attr, 1))
> +		/* inject the error status, do not retry */
> +		nvme_req(req)->status =	NVME_SC_INVALID_OPCODE | NVME_SC_DNR;

I think it can be useful to control the status code (and DNR) as stuff
like request retries and multipathing take it into account..
