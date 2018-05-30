From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 31 May 2018 01:09:27 +0300
Subject: [PATCH 08/17] nvme: limit integrity segments to be <= data
 segments
In-Reply-To: <1527436222-15494-9-git-send-email-maxg@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-9-git-send-email-maxg@mellanox.com>
Message-ID: <19c8562a-8478-196c-c9f5-385d2076448e@grimberg.me>


> There is no reason for setting max_integrity_segments to be greater than
> max_segments.
> 
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> ---
>   drivers/nvme/host/core.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 197208a..e81e898 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1795,6 +1795,10 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
>   		u32 max_segments =
>   			(ctrl->max_hw_sectors / (ctrl->page_size >> 9)) + 1;
>   
> +		if (ctrl->max_integrity_segments)
> +			ctrl->max_integrity_segments = min(ctrl->max_integrity_segments,
> +							   max_segments);
> +

What is this protecting against?
