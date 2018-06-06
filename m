From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 6 Jun 2018 09:14:57 +0200
Subject: [PATCH 00/10] blktests: NVMeOF new testcases for file and bdev ns
In-Reply-To: <20180606005210.4197-1-chaitanya.kulkarni@wdc.com>
References: <20180606005210.4197-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180606071457.samfrpz32qef6yir@linux-x5ow.site>

On Tue, Jun 05, 2018@08:51:58PM -0400, Chaitanya Kulkarni wrote:
> Hi,
> 
> This patch series resrtcures the target side namespace creation code and
> adds new testcases for NVMeOF loop target (nvme_loop). We add different
> testcases like basic creation/deletion of the host/target, fio based data
> verification and exercising mkfs from the host side.

Awesome, thanks a lot for doing this Chaitanya \o/

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
