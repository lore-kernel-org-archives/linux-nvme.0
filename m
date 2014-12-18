From: keith.busch@intel.com (Keith Busch)
Date: Thu, 18 Dec 2014 00:14:34 +0000 (UTC)
Subject: [PATCHv2][qemu-nvme] Enhancements to the CMB feature for NVM
 Express 1.2 devices.
In-Reply-To: <36F6EBABA23FEF4391AF72944D2289016ECA2B15@BBYEXM01.pmc-sierra.internal>
References: <36F6EBABA23FEF4391AF72944D2289016ECA2B15@BBYEXM01.pmc-sierra.internal>
Message-ID: <alpine.LNX.2.00.1412180013220.4026@localhost.lm.intel.com>

On Wed, 17 Dec 2014, Stephen Bates wrote:
> This patch adds additional configurability to the Controller Memory
> Buffer of the QEMU 1.2 device and adds support for the CMBLOC and
> CMBSZ registers which were added as part of the 1.2 specification.
>
> The command-line argument cmb=<cmb> is now more than a flag and can be
> used to set the size of the CMB (in MB). In additional the CMBLOC and
> CMBSZ register are setup to reflect their appropriate values.
>
> Signed-off-by: Stephen Bates <sbates at raithlin.com>

Thanks! Applied:

http://git.infradead.org/users/kbusch/qemu-nvme.git/commitdiff/4ab1b31f4281b758cba21dff6571843069e7ec1f
