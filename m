From: Mario.Limonciello@dell.com (Mario.Limonciello@dell.com)
Date: Wed, 14 Aug 2019 19:51:46 +0000
Subject: [PATCH] nvme: Add quirk for LiteON CL1 devices running FW 22301111
In-Reply-To: <20190814193132.GD3256@localhost.localdomain>
References: <1565798749-15672-1-git-send-email-mario.limonciello@dell.com>
 <20190814193132.GD3256@localhost.localdomain>
Message-ID: <3f5dec208f334839b56ae63bb1a3e6f3@AUSX13MPC105.AMER.DELL.COM>

> -----Original Message-----
> From: Keith Busch <kbusch at kernel.org>
> Sent: Wednesday, August 14, 2019 2:32 PM
> To: Limonciello, Mario
> Cc: Jens Axboe; Christoph Hellwig; Sagi Grimberg; linux-
> nvme at lists.infradead.org; LKML; Hong, Ryan; Wang, Crag; sjg at google.com;
> Hyde, Charles - Dell Team; Dominguez, Jared
> Subject: Re: [PATCH] nvme: Add quirk for LiteON CL1 devices running FW
> 22301111
> 
> 
> [EXTERNAL EMAIL]
> 
> On Wed, Aug 14, 2019@09:05:49AM -0700, Mario Limonciello wrote:
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 8f3fbe5..47c7754 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -2251,6 +2251,29 @@ static const struct nvme_core_quirk_entry
> core_quirks[] = {
> >  		.vid = 0x1179,
> >  		.mn = "THNSF5256GPUK TOSHIBA",
> >  		.quirks = NVME_QUIRK_NO_APST,
> > +	},
> > +	/*
> > +	 * This LiteON CL1 firmware version has a race condition associated with
> > +	 * actions related to suspend to idle.  LiteON has resolved the problem
> > +	 * in future firmware.
> > +	 */
> > +	{
> > +		.vid = 0x14a4,
> > +		.mn = "CL1-3D128-Q11 NVMe LITEON 128GB",
> > +		.fr = "22301111",
> > +		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
> > +	},
> > +	{
> > +		.vid = 0x14a4,
> > +		.mn = "CL1-3D256-Q11 NVMe LITEON 256GB",
> > +		.fr = "22301111",
> > +		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
> > +	},
> > +	{
> > +		.vid = 0x14a4,
> > +		.mn = "CL1-3D512-Q11 NVMe LITEON 512GB",
> > +		.fr = "22301111",
> > +		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
> >  	}
> >  };
> 
> Are there models from this vendor with this same 'fr' that don't need
> this quirk? If not, you can leave .mn blank and just use a single entry.

Yes, I confirmed this firmware version string is only used on the CL1 family
of devices.

I will send a v2 modifying this.  I also noticed that the
(ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND)

is unnecessary in nvme_resume because ndev->last_ps is set to U32_MAX
in nvme_suspend, so I will remove that second modification.
