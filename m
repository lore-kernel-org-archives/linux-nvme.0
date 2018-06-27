From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 27 Jun 2018 09:33:28 +0200
Subject: [PATCH] nvme: trace: add disk name to tracepoints
In-Reply-To: <20180626150106.GB6628@localhost.localdomain>
References: <20180626135141.14088-1-jthumshirn@suse.de>
 <20180626135141.14088-3-jthumshirn@suse.de>
 <20180626150106.GB6628@localhost.localdomain>
Message-ID: <20180627073328.aws2apvc357jobge@linux-x5ow.site>

On Tue, Jun 26, 2018@09:01:06AM -0600, Keith Busch wrote:
> Not related to your patch, but I did notice that the req->q->id isn't
> really useful here since that's not the hardware context identifier.
> That's just some ida assigned software identifier. For the admin command
> completion trace, it's actually a little confusing to see the qid in the
> trace.

It was actually requested by Martin so we can easily see which request
got dispatched/completed on which request queue.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
