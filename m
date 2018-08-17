From: hch@lst.de (Christoph Hellwig)
Date: Fri, 17 Aug 2018 10:12:14 +0200
Subject: [PATCH 5/6] nvme-list-subsys: Print PCIe controller address
In-Reply-To: <20180817072908.56784-6-hare@suse.de>
References: <20180817072908.56784-1-hare@suse.de>
 <20180817072908.56784-6-hare@suse.de>
Message-ID: <20180817081214.GE13230@lst.de>

On Fri, Aug 17, 2018@09:29:07AM +0200, Hannes Reinecke wrote:
> An NVMe PCIe controller doesn't have an address, so we should be
> using the PCIe bus address.

Can we do this in the kernel instead of having to fix up every user
of the sysfs interface?
