From: kbusch@kernel.org (Keith Busch)
Date: Mon, 13 May 2019 14:52:54 -0600
Subject: [PATCH 0/3] nvme-core: add user command filter
In-Reply-To: <SN6PR04MB4527DBCEE5CD5A54965EA0C4860F0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190508183634.4682-1-chaitanya.kulkarni@wdc.com>
 <20190510214255.GA11723@localhost.localdomain>
 <20190513132517.GB2661@infradead.org>
 <20190513164933.GC15437@localhost.localdomain>
 <SN6PR04MB4527DBCEE5CD5A54965EA0C4860F0@SN6PR04MB4527.namprd04.prod.outlook.com>
Message-ID: <20190513205254.GA18823@localhost.localdomain>

On Mon, May 13, 2019@08:36:32PM +0000, Chaitanya Kulkarni wrote:
> I agree that passthru means we should just passthru. But user-pace
> doesn't have the access to take
> 
> corrective action on clearing the AEN.
> 
> The cases where Kernel is responsible for reading and clearing out the
> log pages/AENs
> 
> if we allow userspace to clear those it will create a problem in the
> kernel code if kernel code
> 
> expects the aen bit to be set. This can lead to complex bugs where,
> 
> 1. Kernel expects the log page and aen to be present.
> 
> 2. But it is been cleared since userspace read it but did not take the
> corrective action or doesn't have the
> 
>     right interface to take corrective action so it depends on a kernel
> (driver) to take the corrective action.

But the kernel still sees the AEN, and the log the kernel wants to read
will still exist. None of the logs contents are latched to RAE, so I'm
afraid I'm not seeing what problem letting user space re-arm the AEN
creates. Could you walk me through a scenario that triggers such a bug?
