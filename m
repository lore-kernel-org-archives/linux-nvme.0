From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 11 Jun 2018 13:40:13 +0200
Subject: [PATCH V2 00/14] blktests: NVMeOF new testcases for file and
 bdev ns
In-Reply-To: <20180611091554.19639-1-chaitanya.kulkarni@wdc.com>
References: <20180611091554.19639-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180611114013.wj3pziu2yfje56ju@linux-x5ow.site>

On Mon, Jun 11, 2018@05:15:40AM -0400, Chaitanya Kulkarni wrote:
> Hi,
> 
> This patch series restructures the target side namespace creation code and 
> adds new testcases for NVMeOF loop target (nvme_loop). Also, we add one 
> fio helper for basic data verification, new testcases like basic
> creation/deletion of the host/target, fio based data verification testcases
> for both block device and file backed target namespace and file system
> formatting and data verification from the host side.
> 
> -Regards,
> Chaitanya
> 
> Changes Since V1:-
> 
> 1. Add fio data verification helper.
> 2. Add a new test for many namespaces creation for file-backed ns.
> 3. Minor fixes and cleanups.

Can you please add the already issued Reviewed-by's next time you do a
re-submission?

Thanks,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
