From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 10 Aug 2017 11:05:06 +0200
Subject: [PATCH 1/2] nvme: Fix nvme reset command timeout handling
In-Reply-To: <20170810085716.GA23246@lst.de>
References: <1501174721-8253-1-git-send-email-keith.busch@intel.com>
 <20170728075834.GC4043@linux-x5ow.site>
 <20170810083827.GB22739@lst.de>
 <20170810084818.GM4841@linux-x5ow.site>
 <20170810085716.GA23246@lst.de>
Message-ID: <20170810090506.GN4841@linux-x5ow.site>

On Thu, Aug 10, 2017@10:57:16AM +0200, Christoph Hellwig wrote:
> On Thu, Aug 10, 2017@10:48:18AM +0200, Johannes Thumshirn wrote:
> > On Thu, Aug 10, 2017@10:38:27AM +0200, Christoph Hellwig wrote:
> > > Agreed.
> > > 
> > > We probably should get this series into 4.13, so other comments would
> > > be welcome.
> > 
> > So with my proposed change I'm fine with it, so 
> > Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> > IFF the change is made. 
> 
> Given that you're awake now: can you resend a full patch with your
> proposed changes included so that it can be tested when the Americans
> get up? :)

It was originally Keith's patch, but sure, if you want me to.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
