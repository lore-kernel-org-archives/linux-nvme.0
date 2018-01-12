From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 12 Jan 2018 11:16:57 +0100
Subject: [PATCH 1/2] nvme-fabrics: Fix memory leak when parsing host ID
 option
In-Reply-To: <20180111213800.1767-1-roland@kernel.org>
References: <20180111213800.1767-1-roland@kernel.org>
Message-ID: <20180112101656.cscb4rhv3dj264cc@linux-x5ow.site>

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

Do you mind fixing the same pattern on:
- NVMF_OPT_TRANSPORT
- NVMF_OPT_NQN
- NVMF_OPT_TRADDR
- NVMF_OPT_TRSVCID
- NVMF_OPT_HOST_TRADDR
as well?

Thanks,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
