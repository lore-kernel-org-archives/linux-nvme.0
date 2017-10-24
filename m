From: hare@suse.de (Hannes Reinecke)
Date: Tue, 24 Oct 2017 09:21:03 +0200
Subject: [PATCH 08/17] nvme: use kref_get_unless_zero in nvme_find_get_ns
In-Reply-To: <20171023145126.2471-9-hch@lst.de>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-9-hch@lst.de>
Message-ID: <e6c92822-7c64-b11b-8bb3-41c456ad4c8b@suse.de>

On 10/23/2017 04:51 PM, Christoph Hellwig wrote:
> For kref_get_unless_zero to protect against lookup vs free races we need
> to use it in all places where we aren't guaranteed to already hold a
> reference.  There is no such guarantee in nvme_find_get_ns, so switch to
> kref_get_unless_zero in this function.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  drivers/nvme/host/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
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
