From: keith.busch@intel.com (Keith Busch)
Date: Mon, 4 Jan 2016 15:08:48 +0000
Subject: [PATCH 3/4] nvme: fixes for NVME_IOCTL_IO_CMD on the char device
In-Reply-To: <1450967222-10404-4-git-send-email-hch@lst.de>
References: <1450967222-10404-1-git-send-email-hch@lst.de>
 <1450967222-10404-4-git-send-email-hch@lst.de>
Message-ID: <20160104150847.GD31375@localhost.localdomain>

On Thu, Dec 24, 2015@03:27:01PM +0100, Christoph Hellwig wrote:
> Make sure we synchronize access to the namespaces list and grab a reference
> to the namespace before doing I/O.  Make sure to reject the ioctl if multiple
> namespaces are present as it's entirely unsafe, and warn when using it even
> with a single namespace.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Sagi Grimberg <sagig at mellanox.com>

Okay, I accept the argument for allowing these to "hidden" namespaces
is not sufficiently justified.

Acked-by: Keith Busch <keith.busch at intel.com>
