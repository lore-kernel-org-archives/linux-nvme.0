From: hch@lst.de (Christoph Hellwig)
Date: Fri, 25 May 2018 15:31:03 +0200
Subject: [PATCHv2 08/11] nvme: add ANA support
In-Reply-To: <BN7PR06MB4033432F1B35CFF325D6502E926B0@BN7PR06MB4033.namprd06.prod.outlook.com>
References: <20180522091004.39620-1-hare@suse.de>
 <20180522091004.39620-9-hare@suse.de>
 <BN7PR06MB4033432F1B35CFF325D6502E926B0@BN7PR06MB4033.namprd06.prod.outlook.com>
Message-ID: <20180525133103.GC24601@lst.de>

On Wed, May 23, 2018@11:52:05AM +0000, Popuri, Sriram wrote:
> Thanks for addressing our comments. Overall looks good and have few comments as below:
> 
> 1) I guess it should be bit 6 not bit 7.
> - if (ctrl->anacap & (1 << 7))
> +if (ctrl->anacap & (1 << 6))
> 2) If you resubmit because ana_xfer_size is restricted by mdts, you need to get nvme_ana_rsp_hdr at last and revalidate chgcnt. Otherwise the log you read might be corrupt.

We can sensibly chunk the ANA log page anyway.  So if a controller
has NANAGRPID/MNAN config where we can't sensible read it in a single
operation we better reject the ANA support as buggy early on.

> 3) NVME_SC_ANA_TRANSITION used instead of NVME_ANA_CHANGE in nvme_process_ana_log (two places)

> 4) Can you add info level debug for ANA state changes so its helpful for debugging.

My original code had, and Hannes code has it at least in some places.
