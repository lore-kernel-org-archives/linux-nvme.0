From: keith.busch@linux.intel.com (Keith Busch)
Date: Fri, 18 May 2018 11:23:35 -0600
Subject: [PATCH] PCI/sysfs: do not allow enabling/disabling a device with
 a driver
In-Reply-To: <20180518165624.13993-1-hch@lst.de>
References: <20180518165624.13993-1-hch@lst.de>
Message-ID: <20180518172335.GB27795@localhost.localdomain>

On Fri, May 18, 2018@06:56:24PM +0200, Christoph Hellwig wrote:
> Manpulating the enable_cnt behind the back of the driver will wreck
> complete havok with the kernel state, so disallow it.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Nice, looks like you beat me to it, and used device locking that I
missed.

Acked-by: Keith Busch <keith.busch at intel.com>

Bjorn,
Please disregard https://marc.info/?l=linux-pci&m=152666267830742&w=2
