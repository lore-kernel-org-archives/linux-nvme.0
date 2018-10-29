From: hare@suse.de (Hannes Reinecke)
Date: Mon, 29 Oct 2018 08:40:10 +0100
Subject: [PATCH 08/14] blk-mq: separate number of hardware queues from
 nr_cpu_ids
In-Reply-To: <20181025211626.12692-9-axboe@kernel.dk>
References: <20181025211626.12692-1-axboe@kernel.dk>
 <20181025211626.12692-9-axboe@kernel.dk>
Message-ID: <bc29ae04-f218-c702-b2b6-bc05567d752d@suse.de>

On 10/25/18 11:16 PM, Jens Axboe wrote:
> With multiple maps, nr_cpu_ids is no longer the maximum number of
> hardware queues we support on a given devices. The initializer of
> the tag_set can have set ->nr_hw_queues larger than the available
> number of CPUs, since we can exceed that with multiple queue maps.
> 
> Signed-off-by: Jens Axboe <axboe at kernel.dk>
> ---
>   block/blk-mq.c | 28 +++++++++++++++++++++-------
>   1 file changed, 21 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
