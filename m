From: james.smart@broadcom.com (James Smart)
Date: Tue, 26 Feb 2019 11:58:30 -0800
Subject: [PATCH 2/2] nvme-fc: use nr_phys_segments when map rq to sgl
In-Reply-To: <20190221041335.22806-3-chaitanya.kulkarni@wdc.com>
References: <20190221041335.22806-1-chaitanya.kulkarni@wdc.com>
 <20190221041335.22806-3-chaitanya.kulkarni@wdc.com>
Message-ID: <7c31f86e-5ee3-e270-67dd-0659886019a9@broadcom.com>

On 2/20/2019 8:13 PM, Chaitanya Kulkarni wrote:
> Use blk_rq_nr_phys_segments() instead of blk_rq_payload_bytes() to check
> if a command contains data to be mapped.  This fixes the case where
> a struct request contains LBAs, but it has no payload, such as
> Write Zeroes support.
>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> ---
>   drivers/nvme/host/fc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 89accc76d71c..fdfaf5e914aa 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2119,7 +2119,7 @@ nvme_fc_map_data(struct nvme_fc_ctrl *ctrl, struct request *rq,
>   
>   	freq->sg_cnt = 0;
>   
> -	if (!blk_rq_payload_bytes(rq))
> +	if (!blk_rq_nr_phys_segments(req))

This is broken - needs to be "rq" not "req". Not sure how it passed a 
compile test.

>   		return 0;
>   
>   	freq->sg_table.sgl = freq->first_sgl;
> @@ -2316,7 +2316,7 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
>   	if (ret)
>   		return ret;
>   
> -	data_len = blk_rq_payload_bytes(rq);
> +	data_len = (rq);
>   	if (data_len)
>   		io_dir = ((rq_data_dir(rq) == WRITE) ?
>   					NVMEFC_FCP_WRITE : NVMEFC_FCP_READ);

This is also broken as data_len is used elsewhere to specify the size of 
the payload (data outside of sqe) that is to be transferred. So although 
it was ok for the local check, you switched things that cared about a 
real length from a bytecount to a segment count. Needless to say it 
killed things.

So what does blk_rq_payload_bytes(rq) on a Write Zeros command returns 
?? Why isn't returning 0 valid for Write Zeros ?

Can you describe what the issue is that prompted this change.

-- james
