From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 7 Jun 2018 09:00:37 +0200
Subject: [PATCH 07/12] blktests: add NVMeoF data verification test for
 bdev-ns
In-Reply-To: <DM5PR04MB12138A3A89F921B64F6D2C5686650@DM5PR04MB1213.namprd04.prod.outlook.com>
References: <20180606005210.4197-1-chaitanya.kulkarni@wdc.com>
 <20180606005210.4197-8-chaitanya.kulkarni@wdc.com>
 <20180606074144.cd4fmoecaiw2hlzt@linux-x5ow.site>
 <DM5PR04MB12138A3A89F921B64F6D2C5686650@DM5PR04MB1213.namprd04.prod.outlook.com>
Message-ID: <20180607070037.7f6bmleeufjpk3b3@linux-x5ow.site>

On Wed, Jun 06, 2018@06:12:13PM +0000, Chaitanya Kulkarni wrote:
>  In this test we don't have any dynamic configurations here including the
> device size and all the fio config, then why add an extra code?

Well you add extra code, by adding the fio file and even use it for
the subsequent tests as well.

Currently all fio based tests use the functions in common/fio instead
of a fio config file. At the end of the day it's the same. I'm just up
for consistency.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
