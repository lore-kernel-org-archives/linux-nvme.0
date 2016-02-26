From: keith.busch@intel.com (Keith Busch)
Date: Fri, 26 Feb 2016 23:09:45 +0000
Subject: [PATCH] nvme: expose cntlid in sysfs
In-Reply-To: <1456521859-26357-1-git-send-email-mlin@kernel.org>
References: <1456521859-26357-1-git-send-email-mlin@kernel.org>
Message-ID: <20160226230944.GA4512@localhost.localdomain>

On Fri, Feb 26, 2016@01:24:19PM -0800, Ming Lin wrote:
> From: Ming Lin <ming.l at ssi.samsung.com>
> 
> For NVMe over Fabrics, the cntlid will be used by systemd/udev to
> create link to the device, for example,
> 
> /dev/disk/by-path/<fabrics-info>-<cntlid>-<namespace> -> /dev/nvme0n1

Looks good. Sounds horrific if I try to pronounce it, but the spec
abbreviated "controller" that way!

Reviewed-by: Keith Busch <keith.busch at intel.com>
