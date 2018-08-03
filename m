From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 3 Aug 2018 05:17:40 -0700
Subject: [PATCH V3 3/3] nvmet: add ns write protect support
In-Reply-To: <20180802211100.8404-4-chaitanya.kulkarni@wdc.com>
References: <20180802211100.8404-1-chaitanya.kulkarni@wdc.com>
 <20180802211100.8404-4-chaitanya.kulkarni@wdc.com>
Message-ID: <20180803121740.GB14282@infradead.org>

> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index f517bc562d26..f8c8d41212be 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -32,6 +32,26 @@ static inline void nvmet_clear_aen(struct nvmet_req *req, u32 aen_bit)
>  		clear_bit(aen_bit, &req->sq->ctrl->aen_masked);
>  }
>  
> +bool nvmet_ns_wp_cmd_allow(struct nvmet_req *req)
> +{
> +	bool ret = false;
> +
> +	if (likely(req->sq->qid != 0)) {
> +		switch (req->cmd->common.opcode) {
> +		case nvme_cmd_read:
> +		case nvme_cmd_flush:
> +			/* fall thru */
> +			ret = true;
> +		}
> +		return ret;
> +	}
> +	if (le32_to_cpu(req->cmd->common.nsid) == 0 ||
> +			le32_to_cpu(req->cmd->common.nsid) == NVME_NSID_ALL)
> +		ret = true;
> +
> +	return ret;

Currently this function is only called from the I/O command path,
so the admin part is dead code.  I think just split this into two
helpers in core.c and admin.c respectively:

	if (unlikely(req->ns->readonly &&
			(req->cmd->common.opcode != nvme_cmd_read &&
			 req->cmd->common.opcode != nvme_cmd_flush))

functions, one in admin-cmd.c for the admin command:

static inline bool nvmet_io_cmd_check_access(struct nvmet_req *req)
{
	if (likely(!req->ns->readonly))
		return true;

	switch (req->cmd->common.opcode) {
	case nvme_cmd_read:
	case nvme_cmd_flush:
		return true;
	default:
		return false;
	}
}

static inline bool nvmet_admin_cmd_check_access(struct nvmet_req *req)
{
	if (likely(!req->ns->readonly))
		return true;

	if (req->cmd->common.nsid == 0 ||
	    req->cmd->common.nsid == cpu_to_le32(NVME_NSID_ALL))
		return true;

	return false;
}

this also prepares for a later addition of persistent reservations.

> +u16 nvmet_bdev_flush(struct nvmet_req *req)
> +{
> +	int ret;
> +
> +	ret = blkdev_issue_flush(req->ns->bdev, GFP_KERNEL, NULL);
> +
> +	return ret ? NVME_SC_INTERNAL | NVME_SC_DNR : 0;
> +}

This could be further simplified down to:

	if (blkdev_issue_flush(req->ns->bdev, GFP_KERNEL, NULL))
		return NVME_SC_INTERNAL | NVME_SC_DNR;
	return 0;

> +static void nvmet_file_flush_work(struct work_struct *w)
> +{
> +	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
> +	u16 status;
> +
> +	status = nvmet_file_flush(req);
> +
> +	nvmet_req_complete(req, status);

	nvmet_req_complete(req, nvmet_file_flush(req));
