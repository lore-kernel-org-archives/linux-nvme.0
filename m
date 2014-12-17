From: Stephen.Bates@pmcs.com (Stephen Bates)
Date: Wed, 17 Dec 2014 19:54:06 +0000
Subject: [PATCH][qemu-nvme] Enhancements to the CMB feature for NVM
 Express 1.2 devices.
In-Reply-To: <alpine.LNX.2.00.1412171613450.4026@localhost.lm.intel.com>
References: <36F6EBABA23FEF4391AF72944D2289016ECA0C7F@BBYEXM01.pmc-sierra.internal>
 <alpine.LNX.2.00.1412171613450.4026@localhost.lm.intel.com>
Message-ID: <36F6EBABA23FEF4391AF72944D2289016ECA28B8@BBYEXM01.pmc-sierra.internal>

Keith

I will v2 this patch with RDS and WDS cleared for now.

Longer term I can see a use case for WDS (and RDS) where a remote host could write data to the CMB (perhaps via RDMA) and then use a SQ to submit a command to push that CMB data to NVM.

Cheers

Stephen Bates, PhD
Technical Director, CSTO
PMC-Sierra
Cell: +1 403 609 1784
Twitter: @stepbates

-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com] 
Sent: Wednesday, December 17, 2014 9:25 AM
To: Stephen Bates
Cc: Keith Busch; linux-nvme at lists.infradead.org; Matias Bj?rling
Subject: Re: [PATCH][qemu-nvme] Enhancements to the CMB feature for NVM Express 1.2 devices.

On Tue, 16 Dec 2014, Stephen Bates wrote:
> +        /* If CMB is requested it is setup here. Currently n->cmb
> +         * determines size in MB. All other properties are hard-coded
> +         * (for now) to:
> +         * CMBSZ  = SQS=1, CQS=1, LISTS=1, RDS=1, WDS=1, SZU=1MB
> +         * CMBLOC = BIR=2, OFST=0
> +         */
> +
> +        n->bar.cmbloc = 2;
> +        n->bar.cmbsz = 0x1f | (0x2<<8) | (n->cmb << 12);

If you're going to allow cmb read/write data supported, you need to make sure it works. For that I think you need to change read/write action to use blk_aio_readv/writev instead of the dma helper if the PRPs point in the CMB. That was too much work and I did't see that feature as particularly useful for Linux, so I skipped it.
