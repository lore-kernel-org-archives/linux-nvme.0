From: hare@suse.de (Hannes Reinecke)
Date: Tue, 17 Oct 2017 08:08:23 +0200
Subject: [PATCH v2 4/8] nvmet/rdma: Use sgl_alloc() and sgl_free()
In-Reply-To: <20171016224940.1332-5-bart.vanassche@wdc.com>
References: <20171016224940.1332-1-bart.vanassche@wdc.com>
 <20171016224940.1332-5-bart.vanassche@wdc.com>
Message-ID: <3169fd91-8a1c-5b9f-cdb0-2ffafe25f41e@suse.de>

On 10/17/2017 12:49 AM, Bart Van Assche wrote:
> Use the sgl_alloc() and sgl_free() functions instead of open coding
> these functions.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche at wdc.com>
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> Cc: Keith Busch <keith.busch at intel.com>
> Cc: Christoph Hellwig <hch at lst.de>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> ---
>  drivers/nvme/target/Kconfig |  1 +
>  drivers/nvme/target/rdma.c  | 63 +++------------------------------------------
>  2 files changed, 5 insertions(+), 59 deletions(-)
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
