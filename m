From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 10 Dec 2018 12:31:32 -0800
Subject: [PATCH 06/12] nvmet: add error log support for bdev backend
In-Reply-To: <20181210055011.3146-7-chaitanya.kulkarni@wdc.com>
References: <20181210055011.3146-1-chaitanya.kulkarni@wdc.com>
 <20181210055011.3146-7-chaitanya.kulkarni@wdc.com>
Message-ID: <63b30134-e65a-fde4-3500-708e31bc3da9@grimberg.me>


> +static u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
> +{
> +	u16 status = NVME_SC_SUCCESS;
> +
> +	if (likely(blk_sts == BLK_STS_OK))
> +		return status;
> +	/*
> +	 * Right now there exists M : 1 mapping between block layer error
> +	 * to the NVMe status code (see nvme_error_status()). For consistency,
> +	 * when we reverse map we use most appropriate NVMe Status code from
> +	 * the group of the NVMe staus codes used in the nvme_error_status().
> +	 */
> +	switch (blk_sts) {
> +	case BLK_STS_NOSPC:
> +		status = NVME_SC_CAP_EXCEEDED | NVME_SC_DNR;
> +		req->error_loc = offsetof(struct nvme_rw_command, length);
> +		break;
> +	case BLK_STS_TARGET:
> +		status = NVME_SC_LBA_RANGE | NVME_SC_DNR;
> +		req->error_loc = offsetof(struct nvme_rw_command, slba);
> +		break;
> +	case BLK_STS_NOTSUPP:
> +		req->error_loc = offsetof(struct nvme_common_command, opcode);
> +		switch (req->cmd->common.opcode) {
> +		case nvme_cmd_dsm:
> +		case nvme_cmd_write_zeroes:
> +			status = NVME_SC_ONCS_NOT_SUPPORTED | NVME_SC_DNR;
> +			break;
> +		default:
> +			status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
> +		}
> +		break;
> +	case BLK_STS_MEDIUM:
> +		status = NVME_SC_ACCESS_DENIED;
> +		req->error_loc = offsetof(struct nvme_rw_command, nsid);
> +		break;
> +	case BLK_STS_PROTECTION:
> +		status = NVME_SC_INVALID_PI;
> +		req->error_loc = offsetof(struct nvme_rw_command, nsid);

Is this really the nsid (not PRINFO)? Moreover, I think we should not
propagate this if the host did not send us any PI...

> @@ -205,6 +268,7 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
>   	u16 status = NVME_SC_SUCCESS;
>   	sector_t sector;
>   	sector_t nr_sector;
> +	int ret;
>   
>   	sector = le64_to_cpu(write_zeroes->slba) <<
>   		(req->ns->blksize_shift - 9);
> @@ -215,6 +279,9 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
>   				GFP_KERNEL, &bio, 0))
>   		status = NVME_SC_INTERNAL | NVME_SC_DNR;
>   
> +	ret = __blkdev_issue_zeroout(req->ns->bdev, sector, nr_sector,
> +			GFP_KERNEL, &bio, 0);

Shouldn't this erase the former __blkdev_issue_zeroout?
