From: jack@suse.cz (Jan Kara)
Date: Thu, 18 Apr 2019 15:52:23 +0200
Subject: [PATCH v4 5/7] nvme: register stream info with block layer
In-Reply-To: <1555523406-2380-6-git-send-email-joshi.k@samsung.com>
References: <1555523406-2380-1-git-send-email-joshi.k@samsung.com>
 <CGME20190417175400epcas2p2b166bfaef69f5a02e856743be76199f3@epcas2p2.samsung.com>
 <1555523406-2380-6-git-send-email-joshi.k@samsung.com>
Message-ID: <20190418135223.GK28541@quack2.suse.cz>

On Wed 17-04-19 23:20:04, Kanchan Joshi wrote:
> Make nvme driver register number of streams with block layer. Block
> layer will use that for write-hint to stream-id conversion. Registration
> is done for each namespace. Since NVMe spec allow all available
> streams (within subsystem) to be used by all namespaces, no attempt
> has been made to add reservation at namespace level.
> 
> Signed-off-by: Kanchan Joshi <joshi.k at samsung.com>
> ---
>  drivers/nvme/host/core.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 2c43e12..81b86fa 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -464,10 +464,6 @@ static int nvme_toggle_streams(struct nvme_ctrl *ctrl, bool enable)
>  	return nvme_submit_sync_cmd(ctrl->admin_q, &c, NULL, 0);
>  }
>  
> -static int nvme_disable_streams(struct nvme_ctrl *ctrl)
> -{
> -	return nvme_toggle_streams(ctrl, false);
> -}
>  
>  static int nvme_enable_streams(struct nvme_ctrl *ctrl)
>  {
> @@ -510,14 +506,7 @@ static int nvme_configure_directives(struct nvme_ctrl *ctrl)
>  		return ret;
>  
>  	ctrl->nssa = le16_to_cpu(s.nssa);
> -	if (ctrl->nssa < BLK_MAX_WRITE_HINTS - 1) {
> -		dev_info(ctrl->device, "too few streams (%u) available\n",
> -					ctrl->nssa);
> -		nvme_disable_streams(ctrl);
> -		return 0;
> -	}
> -
> -	ctrl->nr_streams = min_t(unsigned, ctrl->nssa, BLK_MAX_WRITE_HINTS - 1);
> +	ctrl->nr_streams = ctrl->nssa;
>  	dev_info(ctrl->device, "Using %u streams\n", ctrl->nr_streams);
>  	return 0;
>  }

This changes the current behavior, doesn't it? Previously devices with less
than 5 hints got streams completely disabled, now they will have streams
enabled but ids beyond supported max will be mapped to 0. I'm not against
this but I guess it should be spelled out explicitely in the changelog.

								Honza
-- 
Jan Kara <jack at suse.com>
SUSE Labs, CR
