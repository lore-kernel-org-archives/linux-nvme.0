From: keith.busch@intel.com (Keith Busch)
Date: Fri, 20 Feb 2015 18:31:09 +0000 (UTC)
Subject: [PATCH] NVME: Splitting large i/o in the ioctl path
In-Reply-To: <1424421870-3151-1-git-send-email-sathya.m@samsung.com>
References: <1424421870-3151-1-git-send-email-sathya.m@samsung.com>
Message-ID: <alpine.LNX.2.00.1502201822420.32385@localhost.lm.intel.com>

On Fri, 20 Feb 2015, Sathayavathi M wrote:
> +	else
> +		dev->max_hw_sectors = BLK_DEF_MAX_SECOTRS;

I think you meant BLK_DEF_MAX_SECTORS. Sometimes I submit patches that
don't compile either. :)

Anyway, I think we need to fix the driver's adding disks of this extended
type first. Right now I think we're corrupting data and memory if we
encounter such a device. I proposed setting the capacity to 0 so you
can still access the disk media through the ioctl, but not through the
standard block layer.
