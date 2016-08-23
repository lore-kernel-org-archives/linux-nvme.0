From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 23 Aug 2016 11:26:41 +0200
Subject: NVMe pci driver unable to create queues
Message-ID: <20160823092641.hczs3ya7niztlwxl@c203.arch.suse.de>

Hi,

I have the follwing errors on a ARM 64 device:

$ dmesg  | grep nvme
[   14.490744] nvme nvme0: pci function 0005:90:00.0
[   15.913973] nvme 0005:90:00.0: Could not set queue count (6)
[   15.913986] nvme nvme0: IO queues not created

but cannot really debug why the driver isn't able to create it's IO
queues.

Has anybody seen a similar error? All I've found was
https://lkml.org/lkml/2016/4/26/1557 and that wasn't really helpfull.

Thanks in advance,
       Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
