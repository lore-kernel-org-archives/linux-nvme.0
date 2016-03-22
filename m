From: axboe@fb.com (Jens Axboe)
Date: Tue, 22 Mar 2016 14:50:35 -0600
Subject: [PATCH v2 0/4] rewrites discard support
In-Reply-To: <1458631486-14120-1-git-send-email-mlin@kernel.org>
References: <1458631486-14120-1-git-send-email-mlin@kernel.org>
Message-ID: <56F1B01B.6030400@fb.com>

On 03/22/2016 01:24 AM, Ming Lin wrote:
> From: Ming Lin <ming.l at ssi.samsung.com>
>
> This rewrites nvme_setup_discard() with blk_add_request_payload().
> And moves it to common code so fabrics driver can also use it.
>
> v2:
>   - add helper nvme_map_len()
>   - allocates only 16 bytes for discard payload
>   - moves command setup to common helper nvme_setup_cmd()
>   - returns BLK_MQ_RQ_QUEUE_BUSY when out of memory
>
> Ming Lin (4):
>    nvme: add helper nvme_map_len()
>    block: add offset in blk_add_request_payload()
>    nvme: rewrite discard support
>    nvme: add helper nvme_setup_cmd()
>
>   block/blk-core.c         |   5 ++-
>   drivers/block/skd_main.c |   2 +-
>   drivers/nvme/host/core.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h |  55 ++++---------------------
>   drivers/nvme/host/pci.c  |  68 +++++++-----------------------
>   drivers/scsi/sd.c        |   2 +-
>   include/linux/blkdev.h   |   2 +-
>   7 files changed, 133 insertions(+), 106 deletions(-)

Looks good to me, I'll queue it up for 4.7. Thanks.


-- 
Jens Axboe
