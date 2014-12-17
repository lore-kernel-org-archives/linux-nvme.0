From: keith.busch@intel.com (Keith Busch)
Date: Wed, 17 Dec 2014 16:25:15 +0000 (UTC)
Subject: [PATCH][qemu-nvme] Enhancements to the CMB feature for NVM
 Express 1.2 devices.
In-Reply-To: <36F6EBABA23FEF4391AF72944D2289016ECA0C7F@BBYEXM01.pmc-sierra.internal>
References: <36F6EBABA23FEF4391AF72944D2289016ECA0C7F@BBYEXM01.pmc-sierra.internal>
Message-ID: <alpine.LNX.2.00.1412171613450.4026@localhost.lm.intel.com>

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

If you're going to allow cmb read/write data supported, you need to make
sure it works. For that I think you need to change read/write action to
use blk_aio_readv/writev instead of the dma helper if the PRPs point
in the CMB. That was too much work and I did't see that feature as
particularly useful for Linux, so I skipped it.
