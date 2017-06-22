From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 22 Jun 2017 15:06:00 +0200
Subject: Booting from NVMe over Fabrics
Message-ID: <20170622130600.GK5670@linux-x5ow.site>

Hey Folks,

I know this is a rather unpopular topic, but one day someone will come up with
it and I'd like to be prepared.

The big blocking points Hannes and I have discovered are a) discovery (no pun
intented) and b) connection establishment. Currently we need the nvme-cli for
both and thus can't do a auto connect from the kernel at boot time (iscsiadm
or fcoemon anyone?). We could do it the very same way, i.e. fire up nvme
connect-all from the initrd (and pray we have /etc/nvme/discovery.conf) but
the hand-over of parameters from the HCA/HBA firmware is a major PITA at least
from iSCSI (ibft doesn't fix things).

So do you (especially the ones of you in the nvmexpress committe) have special
plans or do we repeat or previous errors?

Thanks a lot,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
