From: hare@suse.de (Hannes Reinecke)
Date: Mon, 29 Oct 2018 08:48:21 +0100
Subject: [PATCH 14/14] nvme: add separate poll queue map
In-Reply-To: <20181025211626.12692-15-axboe@kernel.dk>
References: <20181025211626.12692-1-axboe@kernel.dk>
 <20181025211626.12692-15-axboe@kernel.dk>
Message-ID: <024e93e5-a265-4e71-840f-6bd469f08bbc@suse.de>

On 10/25/18 11:16 PM, Jens Axboe wrote:
> Adds support for defining a variable number of poll queues, currently
> configurable with the 'poll_queues' module parameter. Defaults to
> a single poll queue.
> 
> And now we finally have poll support without triggering interrupts!
> 
> Signed-off-by: Jens Axboe <axboe at kernel.dk>
> ---
>   drivers/nvme/host/pci.c | 103 +++++++++++++++++++++++++++++++++-------
>   include/linux/blk-mq.h  |   2 +-
>   2 files changed, 88 insertions(+), 17 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
