From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Sat, 5 Nov 2016 10:15:08 +0100
Subject: [PATCH v4 3/7] nvme-fabrics: Add FC transport FC-NVME definitions
In-Reply-To: <581cf3c3.4us0uUeKGsPaE1P5%james.smart@broadcom.com>
References: <581cf3c3.4us0uUeKGsPaE1P5%james.smart@broadcom.com>
Message-ID: <20161105091508.mwllnohg24n6326k@linux-x5ow.site>

On Fri, Nov 04, 2016@01:46:59PM -0700, James Smart wrote:
> 
> nvme-fabrics: Add FC transport FC-NVME definitions:
> - Formats for Cmd, Data, Rsp IUs
> - Formats FC-4 LS definitions
> - cmd_iu changed in T11. The 2 reserved words, previous at words
>   2 and 3, were moved to after the sqe.
> - Add to MAINTAINERS file
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> Reviewed-by: Christoph Hellwig <hch at lst.de>

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
