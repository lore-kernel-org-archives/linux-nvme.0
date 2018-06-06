From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 6 Jun 2018 09:57:29 +0200
Subject: [PATCH 12/12] blktests: add NVMeOF flush test for file-ns
In-Reply-To: <20180606005210.4197-13-chaitanya.kulkarni@wdc.com>
References: <20180606005210.4197-1-chaitanya.kulkarni@wdc.com>
 <20180606005210.4197-13-chaitanya.kulkarni@wdc.com>
Message-ID: <20180606075729.pkdvtkpeppaudnkc@linux-x5ow.site>

On Tue, Jun 05, 2018@08:52:10PM -0400, Chaitanya Kulkarni wrote:
> +requires() {
> +	_have_program nvme && _have_module nvme-loop && _have_module loop && \
> +		_have_configfs
> +}

"_have_module loop" again (haven't checked the other file backed test, sorry)

Other than that,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
