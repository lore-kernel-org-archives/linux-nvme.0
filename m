From: hare@suse.de (Hannes Reinecke)
Date: Mon, 29 Oct 2018 08:27:29 +0100
Subject: [PATCH 01/14] blk-mq: kill q->mq_map
In-Reply-To: <20181025211626.12692-2-axboe@kernel.dk>
References: <20181025211626.12692-1-axboe@kernel.dk>
 <20181025211626.12692-2-axboe@kernel.dk>
Message-ID: <d3d4aad8-8300-7561-9951-16b9c351b33a@suse.de>

On 10/25/18 11:16 PM, Jens Axboe wrote:
> It's just a pointer to set->mq_map, use that instead.
> 
> Signed-off-by: Jens Axboe <axboe at kernel.dk>
> ---
>   block/blk-mq.c         | 13 ++++---------
>   block/blk-mq.h         |  4 +++-
>   include/linux/blkdev.h |  2 --
>   3 files changed, 7 insertions(+), 12 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
