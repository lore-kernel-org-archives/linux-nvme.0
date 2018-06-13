From: hch@lst.de (Christoph Hellwig)
Date: Wed, 13 Jun 2018 09:42:25 +0200
Subject: [PATCH 08/12] nvmet: mask pending AERs
In-Reply-To: <b0427eb1-5bba-4c2b-c7fd-8df3b6dad2cf@mellanox.com>
References: <20180530164600.26856-1-hch@lst.de>
 <20180530164600.26856-9-hch@lst.de>
 <b0427eb1-5bba-4c2b-c7fd-8df3b6dad2cf@mellanox.com>
Message-ID: <20180613074225.GA22725@lst.de>

On Tue, Jun 12, 2018@06:41:53PM +0300, Israel Rukshin wrote:
> There is a backwards compatibility issue with this patch.
> I tested the latest nvme target with an older initiator that doesn't use
> the changed namespaces list log to clear ns data changed AENs.
> The target doesn't send the second NS_CHANGED event because the
> NVME_AEN_CFG_NS_ATTR bit is not clear.
> I have a simple fix that clear the bit also at 
> nvmet_execute_identify_ctrl().
>
> What do you think? is there a better way to solve it?

No.  Clearing it in nvmet_execute_identify_ctrl is bogus.  The problem
is that the old target did not comply with the spec.

Note that the old host code would have had the same problem with other
non-Linux targets.  So the only fix is to backport the host fix to
older kernels.
