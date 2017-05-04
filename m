From: keith.busch@intel.com (Keith Busch)
Date: Wed, 3 May 2017 22:40:13 -0400
Subject: [PATCH] nvme-core: add apst_override param to force APST if
 controller does not report APSTA=1
In-Reply-To: <1493863327-18024-1-git-send-email-agk@godking.net>
References: <1493863327-18024-1-git-send-email-agk@godking.net>
Message-ID: <20170504024013.GA30314@localhost.localdomain>

On Wed, May 03, 2017@07:02:07PM -0700, Alexander Kappner wrote:
> Some buggy NVMe controllers support APST (autonomous power
> state transitions), but do not report APSTA=1. On these controllers, the NVMe
> driver does not enable APST support. I have verified this problem occurring
> on
> 	- Samsung 960 Pro 2TB (Firmware 2B6QCXP7, current as of 5/4/17) 
> 	- Samsung 960 Pro 1TB (Firmware 3L0QCXY7) 
> 
> These disks support APST, but
> assert APSTA=0 and so never get enabled in the driver.
> 
> This patch introduces an apst_override module parameter.
> By booting with nvme_core.apst_override=1, the driver can force using APST
> on disks which claim to not support it. This patch
> successfully enables APST on both Samsung disks.
> 
> This patch also introduces an additional sanity check on the NPSS to mitigate
> the risk of force-enabling APST on disks that genuinely do not support it.

It sounds like you really want to target this to specific devices rather
than on the module. This param potenially does undefined things if you set
it on a system with a mixure of devices. We've at least 27 bits left for
quirks so maybe you want to reserve one for these devices while they're
still available.


> +	if (nvme_apst_override != -1 && ctrl->apsta != nvme_apst_override) {
> +		dev_dbg(ctrl->device, "Overriding APSTA.\n");
> +		ctrl->apsta = nvme_apst_override;
> +	}
> +	/*
>  	 * If APST isn't supported or if we haven't been initialized yet,
>  	 * then don't do anything.
>  	 */
>  	if (!ctrl->apsta)
> +		dev_dbg(ctrl->device, "APSTA not set, disabling APST.\n");
>  		return;

You're missing some { brackets } here.
