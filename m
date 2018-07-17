From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 17 Jul 2018 15:56:20 +0200
Subject: [PATCH 2/2] blktests: add test for ANA state transition
In-Reply-To: <20180717133118.39026-3-hare@suse.de>
References: <20180717133118.39026-1-hare@suse.de>
 <20180717133118.39026-3-hare@suse.de>
Message-ID: <20180717135620.7gomzfbnauneu2x4@linux-x5ow.site>

On Tue, Jul 17, 2018@03:31:18PM +0200, Hannes Reinecke wrote:
> +requires() {
> +	_have_program nvme && _have_module nvme-loop && _have_module loop && \
> +		_have_configfs && _have_fio
> +}

this needs '_have_module_param nvme-core multipath' as well.


-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
