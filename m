From: james.smart@broadcom.com (James Smart)
Date: Wed, 18 Oct 2017 14:41:37 -0700
Subject: [PATCH 2/3] nvme-fc: Add BLK_MQ_F_NO_SCHED flag to admin tag set
In-Reply-To: <1508330306-26844-3-git-send-email-israelr@mellanox.com>
References: <1508330306-26844-1-git-send-email-israelr@mellanox.com>
 <1508330306-26844-3-git-send-email-israelr@mellanox.com>
Message-ID: <d0e51f56-401c-b1cb-90ad-a3cc8e208bd4@broadcom.com>

On 10/18/2017 5:38 AM, Israel Rukshin wrote:
> Since commit b86dd81
> "block: get rid of blk-mq default scheduler choice Kconfig entries",
> when setting nr_hw_queues to 1 the admin tag set uses mq-deadline scheduler.
> This flag is useful for admin queues that aren't used for normal IO.
>
> Signed-off-by: Israel Rukshin <israelr at mellanox.com>
> ---
>   drivers/nvme/host/fc.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index af075e9..b383735 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2796,6 +2796,7 @@ enum {
>   	ctrl->admin_tag_set.driver_data = ctrl;
>   	ctrl->admin_tag_set.nr_hw_queues = 1;
>   	ctrl->admin_tag_set.timeout = ADMIN_TIMEOUT;
> +	ctrl->admin_tag_set.flags = BLK_MQ_F_NO_SCHED;
>   
>   	ret = blk_mq_alloc_tag_set(&ctrl->admin_tag_set);
>   	if (ret)

Looks fine

Signed-off-by: James Smart? <james.smart at broadcom.com>
