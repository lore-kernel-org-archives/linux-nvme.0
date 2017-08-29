From: hch@lst.de (Christoph Hellwig)
Date: Tue, 29 Aug 2017 10:30:42 +0200
Subject: [PATCH 07/10] nvme: track shared namespaces
In-Reply-To: <33a56620-f615-71b0-9321-bde8494132db@huawei.com>
References: <20170823175815.3646-1-hch@lst.de>
 <20170823175815.3646-8-hch@lst.de>
 <ec2a91f0-5825-9cfc-50ca-afea27fd8ef3@huawei.com>
 <20170828143011.GA29260@lst.de>
 <33a56620-f615-71b0-9321-bde8494132db@huawei.com>
Message-ID: <20170829083042.GC10487@lst.de>

On Tue, Aug 29, 2017@10:42:18AM +0800, Guan Junxiong wrote:
> As for the __nvme_find_ns_head function, can it lookup the namespace
> globally, not in the current subsytem.

No.

> Take hypermetro scenario for

Please define "hypermetro"

> example, two namespaces which should be viewed as the same namespaces
> from the database application but exist in two different cities respectively.
> Some vendors maybe specify those two namespaces with the same UUID.

Then these vendors are non-compliant IFF the controllers don't belong
to the same subsystem.

> In addition, could you add a switch to turn on/off finding namespaces in
> a subsystem-wide level or globally?

No.

> Can namespace be shared between two subsystem?

No - if you share namespace access you are in the same subsystem.
