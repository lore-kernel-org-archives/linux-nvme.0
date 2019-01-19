From: hch@lst.de (Christoph Hellwig)
Date: Sat, 19 Jan 2019 14:08:10 +0100
Subject: [PATCH] nvme-fc: use pci device as parent for nvme controller
In-Reply-To: <20190117074241.40672-1-hare@suse.de>
References: <20190117074241.40672-1-hare@suse.de>
Message-ID: <20190119130810.GA24374@lst.de>

On Thu, Jan 17, 2019@08:42:41AM +0100, Hannes Reinecke wrote:
> To allow system tools to figure out which pci device provides a
> given NVMe controller this patch moves the nvme controller sysfs
> entry as a child of the PCI device.
> 
> With this tools like dracut can traverse the device hierarchy to figure
> out which modules to include.

Doesn't ->create_ctrl consumer the reference to the passed in device,
or in other words you create a leak on the fabrics device here?
