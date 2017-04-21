From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 21 Apr 2017 10:54:50 +0200
Subject: [PATCH 2/7] nvme/fc: don't byte swap command_id
In-Reply-To: <20170421085005.5945-3-hch@lst.de>
References: <20170421085005.5945-1-hch@lst.de>
 <20170421085005.5945-3-hch@lst.de>
Message-ID: <20170421085450.GF26346@linux-x5ow.site>

On Fri, Apr 21, 2017@10:50:00AM +0200, Christoph Hellwig wrote:
> The command ID is a field for host only use and thus always is in
> native endian.
> 
> Found by sparse.
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
