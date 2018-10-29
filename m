From: hare@suse.de (Hannes Reinecke)
Date: Mon, 29 Oct 2018 08:35:01 +0100
Subject: [PATCH 04/14] blk-mq: pass in request/bio flags to queue mapping
In-Reply-To: <20181025211626.12692-5-axboe@kernel.dk>
References: <20181025211626.12692-1-axboe@kernel.dk>
 <20181025211626.12692-5-axboe@kernel.dk>
Message-ID: <c3a33e18-41c5-9771-1f62-bb3a8e6c8245@suse.de>

On 10/25/18 11:16 PM, Jens Axboe wrote:
> Prep patch for being able to place request based not just on
> CPU location, but also on the type of request.
> 
> Signed-off-by: Jens Axboe <axboe at kernel.dk>
> ---
>   block/blk-flush.c      |  7 +++---
>   block/blk-mq-debugfs.c |  4 +++-
>   block/blk-mq-sched.c   | 16 ++++++++++----
>   block/blk-mq-tag.c     |  5 +++--
>   block/blk-mq.c         | 50 +++++++++++++++++++++++-------------------
>   block/blk-mq.h         |  8 ++++---
>   block/blk.h            |  6 ++---
>   7 files changed, 58 insertions(+), 38 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
