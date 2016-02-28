From: hch@lst.de (Christoph Hellwig)
Date: Sun, 28 Feb 2016 10:10:46 +0100
Subject: [PATCH] nvme: expose cntlid in sysfs
In-Reply-To: <1456521859-26357-1-git-send-email-mlin@kernel.org>
References: <1456521859-26357-1-git-send-email-mlin@kernel.org>
Message-ID: <20160228091046.GB18953@lst.de>

On Fri, Feb 26, 2016@01:24:19PM -0800, Ming Lin wrote:
> From: Ming Lin <ming.l at ssi.samsung.com>
> 
> For NVMe over Fabrics, the cntlid will be used by systemd/udev to
> create link to the device, for example,

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
