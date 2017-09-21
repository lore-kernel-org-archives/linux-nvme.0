From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 21 Sep 2017 07:19:15 +0200
Subject: [PATCH] nvme: make controller 'state' sysfs attribute pollable
In-Reply-To: <20170920145931.GA5208@lst.de>
References: <20170920104032.14014-1-jthumshirn@suse.de>
 <20170920145931.GA5208@lst.de>
Message-ID: <20170921051915.cfj2j5vu4bjqn5za@linux-x5ow.site>

On Wed, Sep 20, 2017@04:59:31PM +0200, Christoph Hellwig wrote:
> On Wed, Sep 20, 2017@12:40:32PM +0200, Johannes Thumshirn wrote:
> > Notify sysfs about changes of a nvme controller so user-space can watch the
> > file via poll() or select() in order to react to a state change.
> 
> Userspace has no business polling for the state.

So why exposing it then in the first time? I know you don't want dm-mpath in
NVMe (neither do I) but we have to have something until your patchset and ANA
is merged. And with this patch it's trivial to build a path checker that just
looks at the state attribute in sysfs.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
