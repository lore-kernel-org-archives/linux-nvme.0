From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 11 Jun 2018 13:38:20 +0200
Subject: [PATCH V2 13/14] blktests: add NVMeOF many bdev-ns creation test
In-Reply-To: <20180611091554.19639-14-chaitanya.kulkarni@wdc.com>
References: <20180611091554.19639-1-chaitanya.kulkarni@wdc.com>
 <20180611091554.19639-14-chaitanya.kulkarni@wdc.com>
Message-ID: <20180611113820.2nb7bwccpotyxgpq@linux-x5ow.site>

On Mon, Jun 11, 2018@05:15:53AM -0400, Chaitanya Kulkarni wrote:
> This patch adds a new testcase to exercise a large number of ns
> creation and deletion along with discovery command.

How would we actually detect an error with this test?
All we do is issuing a discovery, this doesn't give us a list of
namespaces.

Maybe add something like 'ls /dev/${nvmedev}n* | wc -l' to verify we
really have $iterations namespaces created?

[...]

> +	_create_nvmet_subsystem "${subsys_nqn}" "${loop_dev}"
> +
> +	for ((i = 2; i <= iterations; i++)); do

Ahm I don't understand why  you start with i = 2 here.

Thanks,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
