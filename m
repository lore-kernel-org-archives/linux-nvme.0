From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 5 Oct 2016 20:43:39 +0300
Subject: [PATCH v2 3/7] [RFC] nvme: Use BLK_MQ_S_STOPPED instead of
 QUEUE_FLAG_STOPPED in blk-mq code
In-Reply-To: <9faa7607-eb3e-ce41-b09e-1e10492a5f45@sandisk.com>
References: <f153ee47-e599-c333-92b0-d5da475012f3@sandisk.com>
 <9faa7607-eb3e-ce41-b09e-1e10492a5f45@sandisk.com>
Message-ID: <94f3c8ab-9f62-889b-78a0-93f32a20c4e0@grimberg.me>

> Make nvme_requeue_req() check BLK_MQ_S_STOPPED instead of
> QUEUE_FLAG_STOPPED. Remove the QUEUE_FLAG_STOPPED manipulations
> that became superfluous because of this change. This patch fixes
> a race condition: using queue_flag_clear_unlocked() is not safe
> if any other function that manipulates the queue flags can be
> called concurrently, e.g. blk_cleanup_queue(). Untested.

This looks good to me, but I know keith had all sort of
creative ways to challenge this are so I'd wait for his
input...
