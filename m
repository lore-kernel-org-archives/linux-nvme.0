From: hare@suse.de (Hannes Reinecke)
Date: Mon, 29 Oct 2018 08:40:57 +0100
Subject: [PATCH 09/14] blk-mq: ensure that plug lists don't straddle
 hardware queues
In-Reply-To: <20181025211626.12692-10-axboe@kernel.dk>
References: <20181025211626.12692-1-axboe@kernel.dk>
 <20181025211626.12692-10-axboe@kernel.dk>
Message-ID: <3782335d-54a8-44fc-75f6-a2a495b6caf1@suse.de>

On 10/25/18 11:16 PM, Jens Axboe wrote:
> Since we insert per hardware queue, we have to ensure that every
> request on the plug list being inserted belongs to the same
> hardware queue.
> 
> Signed-off-by: Jens Axboe <axboe at kernel.dk>
> ---
>   block/blk-mq.c | 27 +++++++++++++++++++++++++--
>   1 file changed, 25 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
