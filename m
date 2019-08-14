From: Mario.Limonciello@dell.com (Mario.Limonciello@dell.com)
Date: Wed, 14 Aug 2019 20:19:34 +0000
Subject: [PATCH v2] nvme: Add quirk for LiteON CL1 devices running FW
 22301111
In-Reply-To: <32f20898-b9af-eee0-97de-0a568de54b57@grimberg.me>
References: <1565813304-16710-1-git-send-email-mario.limonciello@dell.com>
 <32f20898-b9af-eee0-97de-0a568de54b57@grimberg.me>
Message-ID: <3e38dce0c1ae406496af3a70dfd36077@AUSX13MPC105.AMER.DELL.COM>

> -----Original Message-----
> From: Sagi Grimberg <sagi at grimberg.me>
> Sent: Wednesday, August 14, 2019 3:15 PM
> To: Limonciello, Mario; Keith Busch
> Cc: Jens Axboe; Christoph Hellwig; linux-nvme at lists.infradead.org; LKML; Hong,
> Ryan; Wang, Crag; sjg at google.com; Hyde, Charles - Dell Team; Dominguez, Jared
> Subject: Re: [PATCH v2] nvme: Add quirk for LiteON CL1 devices running FW
> 22301111
> 
> 
> [EXTERNAL EMAIL]
> 
> Mario,
> 
> Can you please respin a patch that applies cleanly on nvme-5.4?

It looks like nvme-5.4 is missing the commit coming in from Rafael's linux-next tree that it's dependent upon:
https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/drivers/nvme/host?h=linux-next&id=4eaefe8c621c6195c91044396ed8060c179f7aae

Could you cherry pick that into nvme-5.4 as well?  It should apply cleanly then.  Otherwise, would you prefer
this to come in Rafael's tree too?
