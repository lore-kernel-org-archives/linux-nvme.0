From: hare@suse.de (Hannes Reinecke)
Date: Tue, 17 Oct 2017 08:34:19 +0200
Subject: [PATCH v9 10/10] block, nvme: Introduce blk_mq_req_flags_t
In-Reply-To: <20171016232905.5047-11-bart.vanassche@wdc.com>
References: <20171016232905.5047-1-bart.vanassche@wdc.com>
 <20171016232905.5047-11-bart.vanassche@wdc.com>
Message-ID: <56950f16-7c51-3e58-edd8-2cdf9049f686@suse.de>

On 10/17/2017 01:29 AM, Bart Van Assche wrote:
> Several block layer and NVMe core functions accept a combination
> of BLK_MQ_REQ_* flags through the 'flags' argument but there is
> no verification at compile time whether the right type of block
> layer flags is passed. Make it possible for sparse to verify this.
> This patch does not change any functionality.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche at wdc.com>
> Cc: linux-nvme at lists.infradead.org
> Cc: Christoph Hellwig <hch at lst.de>
> Cc: Hannes Reinecke <hare at suse.com>
> Cc: Johannes Thumshirn <jthumshirn at suse.de>
> Cc: Ming Lei <ming.lei at redhat.com>
> ---
>  block/blk-core.c          | 12 ++++++------
>  block/blk-mq.c            |  4 ++--
>  block/blk-mq.h            |  2 +-
>  drivers/nvme/host/core.c  |  5 +++--
>  drivers/nvme/host/nvme.h  |  5 +++--
>  include/linux/blk-mq.h    | 17 +++++++++++------
>  include/linux/blk_types.h |  2 ++
>  include/linux/blkdev.h    |  4 ++--
>  8 files changed, 30 insertions(+), 21 deletions(-)
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
