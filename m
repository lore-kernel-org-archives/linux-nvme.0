From: hch@lst.de (Christoph Hellwig)
Date: Tue, 29 Aug 2017 10:29:31 +0200
Subject: [PATCH 07/10] nvme: track shared namespaces
In-Reply-To: <ec2a91f0-5825-9cfc-50ca-afea27fd8ef3@huawei.com>
References: <20170823175815.3646-1-hch@lst.de>
 <20170823175815.3646-8-hch@lst.de>
 <ec2a91f0-5825-9cfc-50ca-afea27fd8ef3@huawei.com>
Message-ID: <20170829082931.GB10487@lst.de>

On Mon, Aug 28, 2017@08:41:23PM +0800, Guan Junxiong wrote:
> If a namespace can be accessed by another subsystem,  the above line
> will ignore such namespace.
>
> Or does the NVMe/NVMf specification constrain that any namespace
> can only be accessed by a subsystem?

A namespace is a part of a NVMe subsystem.  You must not reuse the
uniqueue identifier outside the subsystem scope or your implementation
will be non-compliant.
