From: hare@suse.de (Hannes Reinecke)
Date: Tue, 24 Oct 2017 09:08:21 +0200
Subject: [PATCH 05/17] block: don't look at the struct device dev_t in
 disk_devt
In-Reply-To: <20171023145126.2471-6-hch@lst.de>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-6-hch@lst.de>
Message-ID: <e4c00ca1-44ca-4e48-cec7-ba5ea15e340e@suse.de>

On 10/23/2017 04:51 PM, Christoph Hellwig wrote:
> The hidden gendisks introduced in the next patch need to keep the dev
> field in their struct device empty so that udev won't try to create
> block device nodes for them.  To support that rewrite disk_devt to
> look at the major and first_minor fields in the gendisk itself instead
> of looking into the struct device.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  block/genhd.c         | 4 ----
>  include/linux/genhd.h | 2 +-
>  2 files changed, 1 insertion(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
