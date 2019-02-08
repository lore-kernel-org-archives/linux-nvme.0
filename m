From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 8 Feb 2019 16:39:47 +0100
Subject: [PATCH 1/1] nvme: add get-feature to admin cmds tracer
In-Reply-To: <20190208153039.GA32695@localhost.localdomain>
References: <1548947610-9330-1-git-send-email-maxg@mellanox.com>
 <20190131161108.GA20811@localhost.localdomain>
 <63c08f3a-a109-9441-df53-6a65b1db9ab9@mellanox.com>
 <bcbfb9ea-88ff-d8c7-22ba-8f1df7104930@suse.de>
 <f973dcd6-3455-449d-bf5b-117647d04b12@mellanox.com>
 <20190208084216.GA23155@lst.de>
 <c4db17c4-c9fb-cf79-12ae-e2d3ceab123a@suse.de>
 <20190208153039.GA32695@localhost.localdomain>
Message-ID: <20190208153947.GC8038@linux-x5ow.site>

On Fri, Feb 08, 2019@08:30:40AM -0700, Keith Busch wrote:
> That's fine, I certainly won't nak this and am okay to see this staged for
> the next merge window. I just wanted to confirm preference on maintaining
> the kernel vs tooling as the spec changes.

Sure and I'm not totally sure doing the decoding in the kernel as is should be
carved in stone either.

I guess we have to revisit this decision some day in the future, possibly due
to spec changes and so on.

Byte,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
