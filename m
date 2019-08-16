From: kbusch@kernel.org (Keith Busch)
Date: Fri, 16 Aug 2019 14:01:26 -0600
Subject: [PATCH v2] nvme: Add quirk for LiteON CL1 devices running FW
 22301111
In-Reply-To: <d71fc97ef6c8428f96ecfb2cec6077ab@AUSX13MPC101.AMER.DELL.COM>
References: <1565813304-16710-1-git-send-email-mario.limonciello@dell.com>
 <32f20898-b9af-eee0-97de-0a568de54b57@grimberg.me>
 <20190814201900.GA3511@localhost.localdomain>
 <0cafca37-011d-4c19-4462-14687046a153@grimberg.me>
 <d71fc97ef6c8428f96ecfb2cec6077ab@AUSX13MPC101.AMER.DELL.COM>
Message-ID: <20190816200125.GB6883@localhost.localdomain>

On Fri, Aug 16, 2019@12:43:02PM -0700, Mario.Limonciello@dell.com wrote:
> > We need to coordinate with Jens, don't think its a good idea if I'll
> > just randomly get stuff from linus' tree and send an rc pull request.
> 
> The dependent commit is in Linus' tree now.
> 4eaefe8c621c6195c91044396ed8060c179f7aae
> 
> Also it was reported to me after this was submitted that the comment
> whitespace should have been aligned during the switchover from v1 to v2.
> 
> V1 the whitespace was further left since it was applying to 3 drives, but now
> that they're combined in v2 the whitespace wasn't adjusted.
> 
> Let me know if you want me to resubmit v3 w/ whitespace modification or
> if you will want to adjust that locally when you pull it in.

Go ahead and resend the patch with your fixes included. This is going to
have to wait till next week anyway in order to have a clean pull request
through our normal path to mainline.
