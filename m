From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 6 Jun 2018 09:47:02 +0200
Subject: [PATCH 09/12] blktests: add NVMeOF mkfs test for bdev-ns
In-Reply-To: <20180606005210.4197-10-chaitanya.kulkarni@wdc.com>
References: <20180606005210.4197-1-chaitanya.kulkarni@wdc.com>
 <20180606005210.4197-10-chaitanya.kulkarni@wdc.com>
Message-ID: <20180606074702.wij66kdponr3kjj6@linux-x5ow.site>

On Tue, Jun 05, 2018@08:52:07PM -0400, Chaitanya Kulkarni wrote:

> +requires() {
> +	_have_program nvme && _have_program fio && _have_module loop && \
> +		_have_configfs
> +}

This will need a "_have_program mkfs.xfs" as well.


-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
