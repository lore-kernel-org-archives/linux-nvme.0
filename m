From: hare@suse.de (Hannes Reinecke)
Date: Tue, 24 Oct 2017 09:21:48 +0200
Subject: [PATCH 09/17] nvme: simplify nvme_open
In-Reply-To: <20171023145126.2471-10-hch@lst.de>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-10-hch@lst.de>
Message-ID: <da101acc-a8a8-0158-df84-4f01bea78a0d@suse.de>

On 10/23/2017 04:51 PM, Christoph Hellwig wrote:
> Now that we are protected against lookup vs free races for the namespace
> by using kref_get_unless_zero we don't need the hack of NULLing out the
> disk private data during removal.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  drivers/nvme/host/core.c | 40 ++++++++++------------------------------
>  1 file changed, 10 insertions(+), 30 deletions(-)
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
