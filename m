From: keith.busch@intel.com (Keith Busch)
Date: Fri, 20 Oct 2017 16:29:32 -0600
Subject: [PATCHv2 5/5] nvme: Send uevent for unhandled AEN completions
In-Reply-To: <20171020221924.30659-6-keith.busch@intel.com>
References: <20171020221924.30659-1-keith.busch@intel.com>
 <20171020221924.30659-6-keith.busch@intel.com>
Message-ID: <20171020222932.GA30713@localhost.localdomain>

On Fri, Oct 20, 2017@04:19:24PM -0600, Keith Busch wrote:
> +static void nvme_aen_uevent(struct nvme_ctrl *ctrl)
> +{
> +	char *envp[2] = {NULL, NULL};
> +	u32 aen = ctrl->aen;
> +
> +	ctrl->aen = 0;
> +	if (!aen)
> +		return;
> +
> +	if (!envp[0])
> +		return;
> +	kobject_uevent_env(&ctrl->device->kobj, KOBJ_CHANGE, envp);
> +	kfree(envp[0]);
> +}

Uh, the string format dissappeared on me. Resending...
