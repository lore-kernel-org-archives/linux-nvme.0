From: elliott@hpe.com (Elliott, Robert (Persistent Memory))
Date: Fri, 10 Feb 2017 16:46:09 +0000
Subject: [PATCH v2 4/4] Maintainers: Add Information for SED Opal library
In-Reply-To: <1480456322-27339-5-git-send-email-scott.bauer@intel.com>
References: <1480456322-27339-1-git-send-email-scott.bauer@intel.com>
 <1480456322-27339-5-git-send-email-scott.bauer@intel.com>
Message-ID: <DF4PR84MB0169EB8A90CC23F59135B464AB440@DF4PR84MB0169.NAMPRD84.PROD.OUTLOOK.COM>



> -----Original Message-----
> From: linux-block-owner at vger.kernel.org [mailto:linux-block-
> owner at vger.kernel.org] On Behalf Of Scott Bauer
> Sent: Tuesday, November 29, 2016 3:52 PM
> To: linux-nvme at lists.infradead.org
> Cc: Rafael.Antognolli at intel.com; axboe at fb.com; keith.busch at intel.com;
> jonathan.derrick at intel.com; j.naumann at fu-berlin.de; hch at infradead.org;
> linux-block at vger.kernel.org; sagi at grimberg.me; Scott Bauer
> <scott.bauer at intel.com>
> Subject: [PATCH v2 4/4] Maintainers: Add Information for SED Opal library
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d414840..929eba3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10846,6 +10846,16 @@ L:	linux-mmc at vger.kernel.org
>  S:	Maintained
>  F:	drivers/mmc/host/sdhci-spear.c
> 
> +SECURE ENCRYPTING DEVICE (SED) OPAL DRIVER
> +M:	Scott Bauer <scott.bauer at intel.com>
> +M:	Jonathan Derrick <jonathan.derrick at intel.com>
> +M:	Rafael Antognolli <rafael.antognolli at intel.com>
> +L:	linux-nvme at lists.infradead.org
> +S:	Supported
> +F:	block/sed*
> +F:	include/linux/sed*
> +F:	include/uapi/linux/sed*

Since this is in the block tree and is not nvme specific, could you use 
linux-block as the main list?

Apparently the series has progressed to v6, but only on the 
linux-nvme list.

---
Robert Elliott, HPE Persistent Memory
