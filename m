From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 13 Jul 2017 15:11:21 +0200
Subject: [PATCH] nvmet: preserve controller serial number between reboots
In-Reply-To: <20170713130652.GA24376@lst.de>
References: <20170713104806.12353-1-jthumshirn@suse.de>
 <d32c32f6-3f8f-c63a-f961-ee16407c2fd6@grimberg.me>
 <20170713130652.GA24376@lst.de>
Message-ID: <20170713131121.GJ5212@linux-x5ow.site>

On Thu, Jul 13, 2017@03:06:52PM +0200, Christoph Hellwig wrote:
> On Thu, Jul 13, 2017@03:30:39PM +0300, Sagi Grimberg wrote:
> > It seems weird that a subsystem has a serial.
> 
> But that's actually how NVMe defines them.  Which mean we first
> need to fix our code to generate a serial number per subsystem,
> and on top of that the patch from Johannes seems perfectly reasonable.

Well no problem, I can easily add that.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
