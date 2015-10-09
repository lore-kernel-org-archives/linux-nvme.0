From: keith.busch@intel.com (Keith Busch)
Date: Fri, 9 Oct 2015 16:30:00 +0000 (UTC)
Subject: [PATCH] nvme: move to a new drivers/nvme/host directory
In-Reply-To: <1444407426-23072-1-git-send-email-hch@lst.de>
References: <1444407426-23072-1-git-send-email-hch@lst.de>
Message-ID: <alpine.LNX.2.00.1510091622320.27742@localhost.lm.intel.com>

On Fri, 9 Oct 2015, Christoph Hellwig wrote:
> From: Jay Sternberg <jay.e.sternberg at intel.com>
>
> This patch moves the NVMe driver from drivers/block/ to its own new
> drivers/nvme/host/ directory.  This is in preparation of splitting the
> current monolithic driver up and add support for the upcoming NVMe
> over Fabrics standard.  The drivers/nvme/host/ is chose to leave space
> for a NVMe target implementation in addition to this host side driver.
>
> Signed-off-by: Jay Sternberg <jay.e.sternberg at intel.com>
> [hch: rebased, renamed core.c to pci.c, slight tweaks]
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good to me!

Acked-by: Keith Busch <keith.busch at intel.com>
