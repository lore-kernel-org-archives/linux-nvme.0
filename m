From: hch@lst.de (Christoph Hellwig)
Date: Mon, 28 Aug 2017 16:30:11 +0200
Subject: [PATCH 07/10] nvme: track shared namespaces
In-Reply-To: <ec2a91f0-5825-9cfc-50ca-afea27fd8ef3@huawei.com>
References: <20170823175815.3646-1-hch@lst.de>
 <20170823175815.3646-8-hch@lst.de>
 <ec2a91f0-5825-9cfc-50ca-afea27fd8ef3@huawei.com>
Message-ID: <20170828143011.GA29260@lst.de>

On Mon, Aug 28, 2017@08:41:23PM +0800, Guan Junxiong wrote:
> If a namespace can be accessed by another subsystem,  the above line
> will ignore such namespace.

And that's intentional.

> Or does the NVMe/NVMf specification constrain that any namespace
> can only be accessed by a subsystem?

Yes, inside the NVMe spec a Namespace is contained inside a Subsystem.
That doesn't preclude other ways to access the LBAs, but they are outside
the specification (e.g. also exporting them as SCSI).
