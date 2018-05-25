From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 25 May 2018 16:22:17 +0200
Subject: [PATCH 0/3] Provide more fine grained control over multipathing
In-Reply-To: <20180525130535.GA24239@lst.de>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de>
Message-ID: <20180525142217.zedv7hz6ov6s45qk@linux-x5ow.site>

On Fri, May 25, 2018@03:05:35PM +0200, Christoph Hellwig wrote:
> On Fri, May 25, 2018@02:53:19PM +0200, Johannes Thumshirn wrote:
> > Hi,
> > 
> > This patch series aims to provide a more fine grained control over
> > nvme's native multipathing, by allowing it to be switched on and off
> > on a per-subsystem basis instead of a big global switch.
> 
> No.  The only reason we even allowed to turn multipathing off is
> because you complained about installer issues.  The path forward
> clearly is native multipathing and there will be no additional support
> for the use cases of not using it.

First of all, it wasn't my idea and I'm just doing my job here, as I
got this task assigned at LSF and tried to do my best here.

Personally I _do_ agree with you and do not want to use dm-mpath in
nvme either (mainly because I don't really know the code and don't
want to learn yet another subsystem).

But Mike's and Hannes' arguments where reasonable as well, we do not
know if there are any existing setups we might break leading to
support calls, which we have to deal with. Personally I don't believe
there are lot's of existing nvme multipath setups out there, but who
am I to judge.

So can we find a middle ground to this? Or we'll have the
all-or-nothing situation we have in scsi-mq now again. How about
tieing the switch to a config option which is off per default?

Byte,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
