From: jonathan.derrick@intel.com (Jon Derrick)
Date: Thu, 19 Jan 2017 12:32:50 -0700
Subject: [PATCH v4 5/6] nvme: Add Support for Opal: Unlock from S3 & Opal
 Allocation/Ioctls
In-Reply-To: <1483039615-22407-6-git-send-email-scott.bauer@intel.com>
References: <1483039615-22407-1-git-send-email-scott.bauer@intel.com>
 <1483039615-22407-6-git-send-email-scott.bauer@intel.com>
Message-ID: <20170119193249.GA6489@localhost.localdomain>

[snip]
> +static int nvme_opal_initialize(struct nvme_ns *ns)
> +{
> +
> +#ifdef CONFIG_BLK_DEV_SED_OPAL
> +	/* Opal dev has already been allocated for this controller */
> +	if (ns->sed_ctx.dev)
> +		return 0;
> +
> +	ns->sed_ctx.dev = alloc_opal_dev(ns->ctrl->admin_q);
> +	if (!ns->sed_ctx.dev)
> +		return -ENOMEM;
> +	ns->sed_ctx.send_recv = &nvme_sec_submit;
> +
> +	/* In the future when we have to determine whether or not we're in
> +	 * Multi-LR Mult-NS mode or Single-LR Multi-NS mode we'll
> +	 * pass pointers into is_opal_supported
> +	 */
> +	if (is_opal_supported(&ns->sed_ctx, NULL, NULL) != 1) {
I don't know if it's helpful to have is_opal_supported able to return
errno if we're just going to ignore the error. Maybe change that to
check_opal_support, which has less true/false connotation, and can
return 0 for success and positive if we need it for any unknowns.

Then do:
        if (check_opal_support(..) < 0)
                cleanup...



> +		dev_warn(ns->ctrl->device, "Opal is not supported\n");
> +		kfree(ns->sed_ctx.dev);
> +		ns->sed_ctx.dev = NULL;
I might get some pushback since it's only two lines, but I'd say move the two
lines above into a free_opal_dev to match the alloc_opal_dev. Also if there's
any more de-initialization we need to do in the future (opal buffers, etc),
then the free_opal_dev() will be ready for it.
