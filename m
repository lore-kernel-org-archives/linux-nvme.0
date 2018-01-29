From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Mon, 29 Jan 2018 21:51:55 +0000
Subject: [PATCH V4] blk-mq: introduce BLK_STS_DEV_RESOURCE
In-Reply-To: <20180129214446.GD5744@redhat.com>
References: <20180129203300.50595-1-snitzer@redhat.com>
 <1517260932.2687.42.camel@wdc.com> <20180129214446.GD5744@redhat.com>
Message-ID: <1517262713.2687.56.camel@wdc.com>

On Mon, 2018-01-29@16:44 -0500, Mike Snitzer wrote:
> But regardless of which wins the race, the queue will have been run.
> Which is all we care about right?

Running the queue is not sufficient. With this patch applied it can happen
that the block driver returns BLK_STS_DEV_RESOURCE, that the two or more
concurrent queue runs finish before sufficient device resources are available
to execute the request and that blk_mq_delay_run_hw_queue() does not get
called at all. If no other activity triggers a queue run, e.g. request
completion, this will result in a queue stall.

Bart.
