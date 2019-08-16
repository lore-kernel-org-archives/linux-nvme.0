From: Mario.Limonciello@dell.com (Mario.Limonciello@dell.com)
Date: Fri, 16 Aug 2019 19:43:02 +0000
Subject: [PATCH v2] nvme: Add quirk for LiteON CL1 devices running FW
 22301111
In-Reply-To: <0cafca37-011d-4c19-4462-14687046a153@grimberg.me>
References: <1565813304-16710-1-git-send-email-mario.limonciello@dell.com>
 <32f20898-b9af-eee0-97de-0a568de54b57@grimberg.me>
 <20190814201900.GA3511@localhost.localdomain>
 <0cafca37-011d-4c19-4462-14687046a153@grimberg.me>
Message-ID: <d71fc97ef6c8428f96ecfb2cec6077ab@AUSX13MPC101.AMER.DELL.COM>

> -----Original Message-----
> From: Sagi Grimberg <sagi at grimberg.me>
> Sent: Thursday, August 15, 2019 12:19 PM
> To: Keith Busch
> Cc: Limonciello, Mario; Jens Axboe; Christoph Hellwig; linux-
> nvme at lists.infradead.org; LKML; Hong, Ryan; Wang, Crag; sjg at google.com;
> Hyde, Charles - Dell Team; Dominguez, Jared
> Subject: Re: [PATCH v2] nvme: Add quirk for LiteON CL1 devices running FW
> 22301111
> 
> 
> [EXTERNAL EMAIL]
> 
> 
> >> Mario,
> >>
> >> Can you please respin a patch that applies cleanly on nvme-5.4?
> >
> > This fixes a regression we introduced in 5.3, so it should go in
> > 5.3-rc. For this to apply cleanly, though, we'll need to resync to Linus'
> > tree to get Rafael's PCIe ASPM check after he sends his linux-pm pull
> > request.
> 
> We need to coordinate with Jens, don't think its a good idea if I'll
> just randomly get stuff from linus' tree and send an rc pull request.

The dependent commit is in Linus' tree now.
4eaefe8c621c6195c91044396ed8060c179f7aae

Also it was reported to me after this was submitted that the comment
whitespace should have been aligned during the switchover from v1 to v2.

V1 the whitespace was further left since it was applying to 3 drives, but now
that they're combined in v2 the whitespace wasn't adjusted.

Let me know if you want me to resubmit v3 w/ whitespace modification or
if you will want to adjust that locally when you pull it in.
