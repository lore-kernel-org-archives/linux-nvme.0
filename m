From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 6 Jun 2017 14:04:15 +0200
Subject: [PATCH v4 3/8] nvmet: implement namespace identify descriptor list
In-Reply-To: <20170605053545.GD19480@lst.de>
References: <20170604103649.22130-1-jthumshirn@suse.de>
 <20170604103649.22130-4-jthumshirn@suse.de> <20170605053545.GD19480@lst.de>
Message-ID: <f1b1528a-7abd-fd7d-f134-8306ea8d3434@suse.de>

On 06/05/2017 07:35 AM, Christoph Hellwig wrote:
> I think this needs to zero the remainder of the 4k
> buffer, quoting the spec:

*gah* yeah, my initial version with the kzalloc() took care of it.

> It could be easily done by copying the zero page to userspace.
> Eventually I want to add a helper to zero parts of a sglist to
> lib/scatterlist.c, but I don't want to burden that on you.

I'll have a look.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
