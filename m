From: kbusch@kernel.org (Keith Busch)
Date: Wed, 14 Aug 2019 13:31:32 -0600
Subject: [PATCH] nvme: Add quirk for LiteON CL1 devices running FW 22301111
In-Reply-To: <1565798749-15672-1-git-send-email-mario.limonciello@dell.com>
References: <1565798749-15672-1-git-send-email-mario.limonciello@dell.com>
Message-ID: <20190814193132.GD3256@localhost.localdomain>

On Wed, Aug 14, 2019@09:05:49AM -0700, Mario Limonciello wrote:
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 8f3fbe5..47c7754 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2251,6 +2251,29 @@ static const struct nvme_core_quirk_entry core_quirks[] = {
>  		.vid = 0x1179,
>  		.mn = "THNSF5256GPUK TOSHIBA",
>  		.quirks = NVME_QUIRK_NO_APST,
> +	},
> +	/*
> +	 * This LiteON CL1 firmware version has a race condition associated with
> +	 * actions related to suspend to idle.  LiteON has resolved the problem
> +	 * in future firmware.
> +	 */
> +	{
> +		.vid = 0x14a4,
> +		.mn = "CL1-3D128-Q11 NVMe LITEON 128GB",
> +		.fr = "22301111",
> +		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
> +	},
> +	{
> +		.vid = 0x14a4,
> +		.mn = "CL1-3D256-Q11 NVMe LITEON 256GB",
> +		.fr = "22301111",
> +		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
> +	},
> +	{
> +		.vid = 0x14a4,
> +		.mn = "CL1-3D512-Q11 NVMe LITEON 512GB",
> +		.fr = "22301111",
> +		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
>  	}
>  };

Are there models from this vendor with this same 'fr' that don't need
this quirk? If not, you can leave .mn blank and just use a single entry.
