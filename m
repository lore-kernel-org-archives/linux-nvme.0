From: hare@suse.de (Hannes Reinecke)
Date: Tue, 24 Oct 2017 09:07:19 +0200
Subject: [PATCH 04/17] block: add a blk_steal_bios helper
In-Reply-To: <20171023145126.2471-5-hch@lst.de>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-5-hch@lst.de>
Message-ID: <c1a19718-bb24-0a36-8d89-874c79291bc0@suse.de>

On 10/23/2017 04:51 PM, Christoph Hellwig wrote:
> This helpers allows to bounce steal the uncompleted bios from a request so
> that they can be reissued on another path.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  block/blk-core.c       | 20 ++++++++++++++++++++
>  include/linux/blkdev.h |  2 ++
>  2 files changed, 22 insertions(+)
> Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
