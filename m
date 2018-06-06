From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 6 Jun 2018 09:41:44 +0200
Subject: [PATCH 07/12] blktests: add NVMeoF data verification test for
 bdev-ns
In-Reply-To: <20180606005210.4197-8-chaitanya.kulkarni@wdc.com>
References: <20180606005210.4197-1-chaitanya.kulkarni@wdc.com>
 <20180606005210.4197-8-chaitanya.kulkarni@wdc.com>
Message-ID: <20180606074144.cd4fmoecaiw2hlzt@linux-x5ow.site>

On Tue, Jun 05, 2018@08:52:05PM -0400, Chaitanya Kulkarni wrote:
> diff --git a/tests/nvme/verify.fio b/tests/nvme/verify.fio
> new file mode 100644
> index 0000000..873e47e
> --- /dev/null
> +++ b/tests/nvme/verify.fio
> @@ -0,0 +1,9 @@
> +[write-and-verify]
> +rw=randwrite
> +bs=4k
> +direct=1
> +ioengine=libaio
> +iodepth=16
> +verify=crc32c
> +size=950m
> +group_reporting

One thing I would change is to not have a verify.fio file but pass the
contents on the command line. Maybe even have a _fio_verify() function
in common/fio for this.


-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
