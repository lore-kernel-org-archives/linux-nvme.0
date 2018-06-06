From: hch@lst.de (Christoph Hellwig)
Date: Wed, 6 Jun 2018 14:50:42 +0200
Subject: [PATCH 5/9] nvme: add ANA support
In-Reply-To: <BN7PR06MB40338ED9C7EC6D89D2CD7A9E92650@BN7PR06MB4033.namprd06.prod.outlook.com>
References: <20180601071128.7630-1-hch@lst.de>
 <20180601071128.7630-6-hch@lst.de>
 <BN7PR06MB40333AEEF5E96A05DC6B925592650@BN7PR06MB4033.namprd06.prod.outlook.com>
 <20180606121316.GA13227@lst.de>
 <BN7PR06MB40338ED9C7EC6D89D2CD7A9E92650@BN7PR06MB4033.namprd06.prod.outlook.com>
Message-ID: <20180606125042.GA14085@lst.de>

On Wed, Jun 06, 2018@12:27:43PM +0000, Popuri, Sriram wrote:
> " In theory it could.  In practice that is going to get you very large data transfers for the ANA log, which we can't chunk."
> I don't think so. ANA log is based on num ana grps. NANAGRPID can be small, but ANAGRPMAX could be large if a sparse id space is chosen.

Still the same issue here - if we add another indirection to looking
up the ana group this is really going to mess up the fast path where
we always need to do a state check.  So for now I want to optimize
for sensible targets.  If we really see targets eventually that say
only use the high bits we'll have to find a workaround.
