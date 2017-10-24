From: hare@suse.de (Hannes Reinecke)
Date: Tue, 24 Oct 2017 09:20:19 +0200
Subject: [PATCH 07/17] block: add a poll_fn callback to struct
 request_queue
In-Reply-To: <20171023145126.2471-8-hch@lst.de>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-8-hch@lst.de>
Message-ID: <bffdb2ae-3abf-279f-b07a-ce1f7ea067c4@suse.de>

On 10/23/2017 04:51 PM, Christoph Hellwig wrote:
> That we we can also poll non blk-mq queues.  Mostly needed for
> the NVMe multipath code, but could also be useful elsewhere.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  block/blk-core.c             | 11 +++++++++++
>  block/blk-mq.c               | 14 +++++---------
>  drivers/nvme/target/io-cmd.c |  2 +-
>  fs/block_dev.c               |  4 ++--
>  fs/direct-io.c               |  2 +-
>  fs/iomap.c                   |  2 +-
>  include/linux/blkdev.h       |  4 +++-
>  mm/page_io.c                 |  2 +-
>  8 files changed, 25 insertions(+), 16 deletions(-)
> Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
