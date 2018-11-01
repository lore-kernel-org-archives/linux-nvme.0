From: hare@suse.de (Hannes Reinecke)
Date: Thu, 1 Nov 2018 10:28:48 +0100
Subject: [PATCH 10/16] blk-mq: cleanup and improve list insertion
In-Reply-To: <20181030183252.17857-11-axboe@kernel.dk>
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-11-axboe@kernel.dk>
Message-ID: <579cc1b0-0147-d5b9-a507-85b56c2e0546@suse.de>

On 10/30/18 7:32 PM, Jens Axboe wrote:
> It's somewhat strange to have a list insertion function that
> relies on the fact that the caller has mapped things correctly.
> Pass in the hardware queue directly for insertion, which makes
> for a much cleaner interface and implementation.
> 
> Signed-off-by: Jens Axboe <axboe at kernel.dk>
> ---
>   block/blk-mq-sched.c |  8 +-------
>   block/blk-mq-sched.h |  2 +-
>   block/blk-mq.c       | 25 ++++++++++++++-----------
>   3 files changed, 16 insertions(+), 19 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
