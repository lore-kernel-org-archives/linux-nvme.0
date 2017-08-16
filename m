From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 16 Aug 2017 16:29:39 +0300
Subject: [PATCH 2/3] nvme: introduce max_segments controller attribute
In-Reply-To: <1502878860-11750-2-git-send-email-maxg@mellanox.com>
References: <1502878860-11750-1-git-send-email-maxg@mellanox.com>
 <1502878860-11750-2-git-send-email-maxg@mellanox.com>
Message-ID: <390a1e0d-8b83-576f-1e9a-c9136b7daf39@grimberg.me>


> Each ctrl will limit max_segments according to it's hardware
> restrictions. Implement the restriction for RDMA transport.
> 
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> ---
>   drivers/nvme/host/core.c |    4 ++--
>   drivers/nvme/host/nvme.h |    1 +
>   drivers/nvme/host/rdma.c |    1 +
>   3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 8cf37e7..cc0681e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1495,8 +1495,8 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
>   	bool vwc = false;
>   
>   	if (ctrl->max_hw_sectors) {
> -		u32 max_segments =
> -			(ctrl->max_hw_sectors / (ctrl->page_size >> 9)) + 1;
> +		u32 max_segments = min_not_zero(ctrl->max_segments,
> +			(ctrl->max_hw_sectors / (ctrl->page_size >> 9)) + 1);

Why is this needed with patches 1,3 applied?

We set the page_size and we set max_hw_sectors accordingly.
