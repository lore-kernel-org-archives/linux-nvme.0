From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 16 Jun 2017 10:29:16 +0200
Subject: [PATCH 1/6] nvme: remove an misleading comment on strut nvme_ns
In-Reply-To: <20170615163502.10548-2-hch@lst.de>
References: <20170615163502.10548-1-hch@lst.de>
 <20170615163502.10548-2-hch@lst.de>
Message-ID: <79a2352a-b6dd-2324-2ce0-247ea087e061@suse.de>

On 06/15/2017 06:34 PM, Christoph Hellwig wrote:
> While a NVMe Namespace is somewhat similar to a SCSI Logical Unit (and not
> a Logical Unit Number anyway) there are subtile differences.  Remove the
> misleading comment.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>


-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
