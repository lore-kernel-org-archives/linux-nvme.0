From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 11 Jan 2017 14:43:12 +0100
Subject: [LSF/MM TOPIC][LSF/MM ATTEND] NAPI polling for block drivers
Message-ID: <20170111134312.GH6286@linux-x5ow.site>

Hi all,

I'd like to attend LSF/MM and would like to discuss polling for block drivers.

Currently there is blk-iopoll but it is neither as widely used as NAPI in the
networking field and accoring to Sagi's findings in [1] performance with
polling is not on par with IRQ usage.

On LSF/MM I'd like to whether it is desirable to have NAPI like polling in
more block drivers and how to overcome the currently seen performance issues.

[1] http://lists.infradead.org/pipermail/linux-nvme/2016-October/006975.html

Byte,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
