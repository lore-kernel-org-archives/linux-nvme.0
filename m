From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 6 Jun 2018 09:30:26 +0200
Subject: [PATCH 03/12] blktests: add NVMeOF bdev-ns target creation test
In-Reply-To: <20180606005210.4197-4-chaitanya.kulkarni@wdc.com>
References: <20180606005210.4197-1-chaitanya.kulkarni@wdc.com>
 <20180606005210.4197-4-chaitanya.kulkarni@wdc.com>
Message-ID: <20180606073026.pg76kaxtnh3qnpxa@linux-x5ow.site>

On Tue, Jun 05, 2018@08:52:01PM -0400, Chaitanya Kulkarni wrote:
> This adds a new unit test to create NVMeOF target with block-device
> backed namespace.

Where's the big difference to nvme/004 or nvme/005 which implicitly do
this as well?

And furthermore your nvme/006 tests the creation of 999 bdev backed
namespaces as well, so I think this one is superfluous.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
