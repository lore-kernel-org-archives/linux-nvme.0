From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 16 Nov 2016 18:47:22 +0200
Subject: [PATCH 5/5] nvmet: add support for the Write Zeroes command
In-Reply-To: <1479279039-25818-6-git-send-email-chaitanya.kulkarni@hgst.com>
References: <1479279039-25818-1-git-send-email-chaitanya.kulkarni@hgst.com>
 <1479279039-25818-6-git-send-email-chaitanya.kulkarni@hgst.com>
Message-ID: <6591bf30-6f66-c4e6-e304-9b580489a9b9@grimberg.me>


> +static void nvmet_execute_write_zeroes(struct nvmet_req *req)
> +{
> +	struct nvme_write_zeroes_cmd *write_zeroes = &req->cmd->write_zeroes;
> +	struct bio *bio = NULL;
> +	u16 status = NVME_SC_SUCCESS;
> +	sector_t sector;
> +	sector_t nr_sector;
> +
> +	sector = le64_to_cpu(write_zeroes->slba) <<
> +		(req->ns->blksize_shift - 9);
> +	nr_sector = (((sector_t)le32_to_cpu(write_zeroes->length)) <<
> +		(req->ns->blksize_shift - 9)) + 1;
> +
> +	if (__blkdev_issue_zeroout(req->ns->bdev, sector, nr_sector,
> +				GFP_KERNEL, &bio, false))
> +		status = NVME_SC_INTERNAL | NVME_SC_DNR;
> +
> +	if (bio) {
> +		bio->bi_private = req;
> +		bio->bi_end_io = nvmet_bio_done;
> +		if (status) {

if (status != NVME_SC_SUCCESS) can this happen?
can we end up with a bio if __blkdev_issue_zeroout
failed?

> +			bio->bi_error = -EIO;
> +			bio_endio(bio);

Something looks odd here, how does the status propagate in
this case?
