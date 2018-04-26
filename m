From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 26 Apr 2018 14:01:59 -0600
Subject: [PATCH] nvme: change order of qid and cmdid in completion trace
In-Reply-To: <20180426194926.18767-1-jthumshirn@suse.de>
References: <20180426194926.18767-1-jthumshirn@suse.de>
Message-ID: <3e927f7f-fa84-1792-b80e-bf5679e71bcf@kernel.dk>

On 4/26/18 1:49 PM, Johannes Thumshirn wrote:
> Keith reported that command submission and command completion
> tracepoints have the order of the cmdid and qid fileds swapped.
> 
> While it isn't easily possible to change the command submission
> tracepoint, as there is a regression test parsing it in blktests we
> can swap the command completion tracepoint to have the fileds aligned.

It also makes more sense to have qid before cmdid.

Also, fileds -> fields, in two spots.

With that:

Reviewed-by: Jens Axboe <axboe at kernel.dk>

-- 
Jens Axboe
