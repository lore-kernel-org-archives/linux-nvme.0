From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 5 Oct 2017 08:51:24 +0200
Subject: [PATCH 3/6] nvme: claim block devices
In-Reply-To: <yq1poa2wgd2.fsf@oracle.com>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
 <1506952559-1588-4-git-send-email-hare@suse.de>
 <20171002164218.GA11886@lst.de>
 <ece83015-0def-8e36-5645-7be00be95c40@suse.de>
 <20171003115506.GC24650@lst.de>
 <bd388bdf-25ac-8b25-f832-ba1316a64dc4@suse.de>
 <20171004061533.GA20131@lst.de>
 <19dbdf11-86c4-b6ea-a18c-a78fcae822d5@suse.de>
 <20171004071312.GA21143@lst.de> <yq1poa2wgd2.fsf@oracle.com>
Message-ID: <20171005065124.h5t3gtufptevja4s@linux-x5ow.site>

On Wed, Oct 04, 2017@09:08:57PM -0400,  Martin K. Petersen  wrote:
> 
> Christoph,
> 
> > The only other option I could think of would be to turn names around:
> > make /dev/nvmeX (chardev) and /dev/nvmeXnY the per-subsystem devices
> > that are multipathed if available.  We'd then need new devices for the
> > invdividual controllers.
> 
> I like that approach.

/me too

Byte,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
