From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Thu, 30 Jul 2015 12:04:19 +0300
Subject: [PATCH] blk: add vector gaps queue parameter
In-Reply-To: <1438189313-29722-1-git-send-email-keith.busch@intel.com>
References: <1438189313-29722-1-git-send-email-keith.busch@intel.com>
Message-ID: <55B9E893.7050509@dev.mellanox.co.il>


> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 12600bf..4acd505 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -111,6 +111,7 @@ void blk_set_default_limits(struct queue_limits *lim)
>   	lim->max_segments = BLK_MAX_SEGMENTS;
>   	lim->max_integrity_segments = 0;
>   	lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
> +	lim->virt_mask = 0;

I wander if its better to default to PAGE_SIZE to not change the
existing functionality? Or do we want to force drivers to set virt_mask?
