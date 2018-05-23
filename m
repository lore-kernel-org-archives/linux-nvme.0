From: hare@suse.de (Hannes Reinecke)
Date: Wed, 23 May 2018 15:19:43 +0200
Subject: [PATCHv2 08/11] nvme: add ANA support
In-Reply-To: <BN7PR06MB4033432F1B35CFF325D6502E926B0@BN7PR06MB4033.namprd06.prod.outlook.com>
References: <20180522091004.39620-1-hare@suse.de>
 <20180522091004.39620-9-hare@suse.de>
 <BN7PR06MB4033432F1B35CFF325D6502E926B0@BN7PR06MB4033.namprd06.prod.outlook.com>
Message-ID: <392582fa-f000-5cb8-4df2-62ff671cf036@suse.de>

On 05/23/2018 01:52 PM, Popuri, Sriram wrote:
> Thanks for addressing our comments. Overall looks good and have few comments as below:
> 
> 1) I guess it should be bit 6 not bit 7.
> - if (ctrl->anacap & (1 << 7))
> +if (ctrl->anacap & (1 << 6))
Ah. Correct.
Will be fixing it up.

> 2) If you resubmit because ana_xfer_size is restricted by mdts, you need to get nvme_ana_rsp_hdr
> at last and revalidate chgcnt. Otherwise the log you read might be corrupt.
Indeed. This whole mdts stuff is pretty raw, so I'm not surprised that 
we're getting errors here.
Maybe it's worthwhile moving it into the generic function; let's see.

> 3) NVME_SC_ANA_TRANSITION used instead of NVME_ANA_CHANGE in nvme_process_ana_log (two places)

Did I? That would've been wrong indeed. Will be fixing it up.

> 4) Can you add info level debug for ANA state changes so its helpful for debugging.
> 
Thought about it myself (and actually did so during development), but 
then decided against it as the entire nvme stack is pretty silent.
Probably I'll make it a conditional logging entry here.

Thanks for the review.

Cheers,

Hannes
