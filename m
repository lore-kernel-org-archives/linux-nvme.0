From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 24 May 2016 17:59:38 +0200
Subject: [PATCHv2] NVMe: Sync reset and scan work
In-Reply-To: <1464102370-11283-1-git-send-email-keith.busch@intel.com>
References: <1464102370-11283-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160524155938.wzzsmje6bhlkghwk@c203.arch.suse.de>

On Tue, May 24, 2016@09:06:10AM -0600, Keith Busch wrote:
> This adds a new state for scheduling a reset and synchronizes that state
> with active scanning work. This is so a user can't interrupt namespace
> discovery, which can cause identification to fail.
> 
> Reported-by: Ming Lin <mlin at kernel.org>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
> v1 -> v2: 
>   added appropriate state transition from the new schedule reset state.
> 

[...]

>  
> +static int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
> +{
> +	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_SCHED_RESET))
> +		return -EPERM;

Is there a specific reason why you're using EPERM instead of EINVAL? I always
understood EPERM as a privilege level error code, while EINVAL would be a more
appropriate error code for an illegal state transition, IMHO.

Thanks,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
