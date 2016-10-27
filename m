From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 27 Oct 2016 12:58:38 +0200
Subject: [PATCH rfc 0/6] convert nvme pci to use irq-poll service
In-Reply-To: <a99705df-4f4c-3b2e-e9cc-9f3ca00e17c4@grimberg.me>
References: <1475660534-16681-1-git-send-email-sagi@grimberg.me>
 <20161027100918.j62izkq6hmos6sc4@linux-x5ow.site>
 <a99705df-4f4c-3b2e-e9cc-9f3ca00e17c4@grimberg.me>
Message-ID: <20161027105838.h5taoylgelvopmde@linux-x5ow.site>

On Thu, Oct 27, 2016@01:31:47PM +0300, Sagi Grimberg wrote:
> 
> > Hi Sagi,
> 
> Hey Johannes,
> 
> > I'm wondering if I've somehow missed the v2 of this series?
> 
> You didn't miss it.
> 
> I currently have it in:
> git://git.infradead.org/nvme-fabrics.git   nvme-irq-poll

pulled thanks.

> 
> From my tests with Qemu nvme I still see ~10% performance
> degradation for 4K IOs and cannot explain where its
> coming from. But I think we need some real setup tests as
> well.

Are just using the Qemu NVMe over PCI emulation or some Fabrics thingy? Maybe
I can have a look at it as well and at least act as your test monkey here.

> 
> Hence, I don't feel comfortable getting this in at this point.
> I would appreciate if people can also try it out and provide
> some insight (Jens, Christoph, Keith).
> 
> The networking folks are using napi everywhere and can reach
> much lower latencies than NVMe so IMO we just need to identify
> some gaps. I have some micro-optimization patches for irq-poll
> but they don't seem to make a real difference.

I'll have a look.

Byte,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
