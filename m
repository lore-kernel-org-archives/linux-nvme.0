From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 23 Aug 2016 16:59:41 +0200
Subject: NVMe pci driver unable to create queues
In-Reply-To: <20160823144652.GG28276@localhost.localdomain>
References: <20160823092641.hczs3ya7niztlwxl@c203.arch.suse.de>
 <20160823144652.GG28276@localhost.localdomain>
Message-ID: <20160823145941.2qa5e3vgyz42bvnq@c203.arch.suse.de>

On Tue, Aug 23, 2016@10:46:53AM -0400, Keith Busch wrote:
> On Tue, Aug 23, 2016@11:26:41AM +0200, Johannes Thumshirn wrote:
> > Hi,
> > 
> > I have the follwing errors on a ARM 64 device:
> > 
> > $ dmesg  | grep nvme
> > [   14.490744] nvme nvme0: pci function 0005:90:00.0
> > [   15.913973] nvme 0005:90:00.0: Could not set queue count (6)
> > [   15.913986] nvme nvme0: IO queues not created
> > 
> > but cannot really debug why the driver isn't able to create it's IO
> > queues.
> > 
> > Has anybody seen a similar error? All I've found was
> > https://lkml.org/lkml/2016/4/26/1557 and that wasn't really helpfull.
> 
> The return code "6" means "internal device error" and indicates the
> device is in a bad state incapable of IO.
> 
> The driver should have provided a character device handle at /dev/nvme0
> that you can issue admin commands to query and potentially fix the
> device. You may need to check with the device vendor for those steps.

Thanks for the answer.

As nvme get-log and nvme error-log don't return something different
than INTERNAL(6) I think "it's dead jim".

Thanks anyways.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
