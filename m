From: kenneth.heitke@intel.com (Heitke, Kenneth)
Date: Fri, 29 Mar 2019 10:58:25 -0600
Subject: [PATCH v3 4/7] nvme: register stream info with block layer
In-Reply-To: <1553846032-4451-5-git-send-email-joshi.k@samsung.com>
References: <1553846032-4451-1-git-send-email-joshi.k@samsung.com>
 <CGME20190329075753epcas1p16ce37362f83ccb8520a782b845dcb905@epcas1p1.samsung.com>
 <1553846032-4451-5-git-send-email-joshi.k@samsung.com>
Message-ID: <87e172d4-dcc2-d0db-9bd1-b76afc7a9d01@intel.com>


On 3/29/2019 1:53 AM, Kanchan Joshi wrote:
> nvme registes number of streams with block layer, which will use that

s/registes/registers/ ??

> for write-hint to streamid conversion. Registration is done for each
> namespace. Since NVMe spec allow all available streams (within subsystem)
> to be used by all namespaces, no attempt has been made to add reservation
> at namespace level.
>
> Signed-off-by: Kanchan Joshi <joshi.k at samsung.com>
> ---
>   drivers/nvme/host/core.c | 19 ++++++-------------
>   1 file changed, 6 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 150e497..e34386b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -513,14 +513,7 @@ static int nvme_configure_directives(struct nvme_ctrl *ctrl)
>   		return ret;
>   
>   	ctrl->nssa = le16_to_cpu(s.nssa);
> -	if (ctrl->nssa < BLK_MAX_WRITE_HINTS - 1) {
> -		dev_info(ctrl->device, "too few streams (%u) available\n",
> -					ctrl->nssa);
> -		nvme_disable_streams(ctrl);
> -		return 0;
> -	}
> -
> -	ctrl->nr_streams = min_t(unsigned, ctrl->nssa, BLK_MAX_WRITE_HINTS - 1);
> +	ctrl->nr_streams = ctrl->nssa;
>   	dev_info(ctrl->device, "Using %u streams\n", ctrl->nr_streams);
>   	return 0;
>   }
> @@ -533,12 +526,9 @@ static void nvme_assign_write_stream(struct nvme_ctrl *ctrl,
>   				     struct request *req, u16 *control,
>   				     u32 *dsmgmt)
>   {
> -	enum rw_hint streamid = req->write_hint;
> +	enum rw_hint streamid = req->streamid;
>   
> -	if (streamid == WRITE_LIFE_NOT_SET || streamid == WRITE_LIFE_NONE)
> -		streamid = 0;
> -	else {
> -		streamid--;
> +	if (streamid != 0) {
>   		if (WARN_ON_ONCE(streamid > ctrl->nr_streams))
>   			return;
>   
> @@ -3138,6 +3128,7 @@ static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
>   {
>   	struct streams_directive_params s;
>   	int ret;
> +	u16 nr_streams;
>   
>   	if (!ctrl->nr_streams)
>   		return 0;
> @@ -3149,6 +3140,8 @@ static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
>   	ns->sws = le32_to_cpu(s.sws);
>   	ns->sgs = le16_to_cpu(s.sgs);
>   
> +	nr_streams = min_t(unsigned, ctrl->nr_streams, BLK_MAX_WRITE_HINTS - 1);
> +	blk_queue_stream_limits(ns->queue, nr_streams);
>   	if (ns->sws) {
>   		unsigned int bs = 1 << ns->lba_shift;
>   
