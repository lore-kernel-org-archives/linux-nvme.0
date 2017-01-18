From: keith.busch@intel.com (Keith Busch)
Date: Wed, 18 Jan 2017 10:56:47 -0500
Subject: [PATCH 2/3] nvme: Add a quirk mechanism that uses identify_ctrl
In-Reply-To: <66c502d8607570266163224149b1e7f613c65a45.1484703713.git.luto@kernel.org>
References: <cover.1484703713.git.luto@kernel.org>
 <66c502d8607570266163224149b1e7f613c65a45.1484703713.git.luto@kernel.org>
Message-ID: <20170118155647.GE8989@localhost.localdomain>

On Tue, Jan 17, 2017@05:54:19PM -0800, Andy Lutomirski wrote:
> @@ -1351,6 +1394,15 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>  		return -EIO;
>  	}
>  
> +	if (!ctrl->identified) {

Part of the quirk is matching firmware revision. That potentially changes
after a reset, but you only check the quirks the first time we initialise
the controller. It's a little awkward to unmask the quirk out when it
previously set for this, though, so maybe it's just as well to have the
user reboot after a firmware upgrade fixes a quirk.

Otherwise, looks good to me.

> +		int i;
> +
> +		for (i = 0; i < ARRAY_SIZE(core_quirks); i++) {
> +			if (quirk_matches(id, &core_quirks[i]))
> +				ctrl->quirks |= core_quirks[i].quirks;
> +		}
> +	}
