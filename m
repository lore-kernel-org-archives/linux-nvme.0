From: keith.busch@intel.com (Keith Busch)
Date: Tue, 23 Dec 2014 17:58:39 +0000 (UTC)
Subject: [PATCH][qemu-nvme] Improved support for CMBLOC and CMBSZ
In-Reply-To: <36F6EBABA23FEF4391AF72944D2289016ECA91F8@BBYEXM01.pmc-sierra.internal>
References: <36F6EBABA23FEF4391AF72944D2289016ECA91F8@BBYEXM01.pmc-sierra.internal>
Message-ID: <alpine.LNX.2.00.1412231748490.4026@localhost.lm.intel.com>

On Tue, 23 Dec 2014, Stephen Bates wrote:
> Added the ability to set the fields of the CMBLOC and CMBSZ registers
> and ensured those registers are set correctly at initialization.

Looks good to me, I'll apply this.

> Signed-off-by: Stephen Bates <stephen.bates at pmcs.com>
> ---
> hw/block/nvme.c |   14 ++++++++++++--
> hw/block/nvme.h |   19 +++++++++++++++++++
> 2 files changed, 31 insertions(+), 2 deletions(-)
