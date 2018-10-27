From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Sat, 27 Oct 2018 22:19:29 +0800
Subject: [PATCH 01/14] blk-mq: kill q->mq_map
In-Reply-To: <20181025211626.12692-2-axboe@kernel.dk>
References: <20181025211626.12692-1-axboe@kernel.dk>
 <20181025211626.12692-2-axboe@kernel.dk>
Message-ID: <f0b01bcc-fa62-880d-80ef-c44095d82077@oracle.com>

Hi Jens

On 10/26/18 5:16 AM, Jens Axboe wrote:
> It's just a pointer to set->mq_map, use that instead.
Instead of using the set->mq_map and then a two-dimensional set->mq_map,
how about migrate the mq_map from per-set to per-cpuctx ?
something like:
q->queue_hw_ctx[ctx->map[type]]


Thanks
Jianchao
