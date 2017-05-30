From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 30 May 2017 13:18:55 +0300
Subject: [PATCH V2] nvme: fix nvme_remove going to uninterruptible sleep
 for ever
In-Reply-To: <20170530071610.GA2679@hercules.tuxera.com>
References: <20170530071610.GA2679@hercules.tuxera.com>
Message-ID: <4da7c939-1f54-80e5-48fc-06e58e14f018@grimberg.me>


>  	/*
> +	 * Avoid configuration and syncing commands if controller is already
> +	 * being removed and queues have been killed.
> +	 */
> +	if (ctrl->state == NVME_CTRL_DELETING || ctrl->state == NVME_CTRL_DEAD)
> +		return;
> +

Hey Rakesh, Christoph,

Given that the issue is for sync command submission during controller
removal, I'm wandering if we should perhaps move this check to
__nvme_submit_sync_cmd?

AFAICT user-space can just as easily trigger set_features in the same
condition which will trigger the hang couldn't it?
