From: keith.busch@intel.com (Keith Busch)
Date: Wed, 4 Feb 2015 23:57:15 +0000 (UTC)
Subject: [PATCH][QEMU-NVME] Fixed NVM Express device versioning.
In-Reply-To: <36F6EBABA23FEF4391AF72944D2289019EA8725A@BBYEXM01.pmc-sierra.internal>
References: <36F6EBABA23FEF4391AF72944D2289019EA8725A@BBYEXM01.pmc-sierra.internal>
Message-ID: <alpine.LNX.2.00.1502042357020.15481@localhost.lm.intel.com>

On Wed, 4 Feb 2015, Stephen Bates wrote:
> The NVMe specification indicates how the minor and major version
> numbers should be represented in the version field of the NVMe
> controller registers. We correct the code to align with the
> specification.
>
> If CMB is requested we advertise as a 1.2 drive, if not we advertise
> 1.1.
>
> Signed-off-by: Stephen Bates <stephen.bates at pmcs.com>

Applied, thanks!
