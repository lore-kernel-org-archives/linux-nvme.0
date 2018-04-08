From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Sun, 8 Apr 2018 23:47:44 +0000
Subject: [PATCH 1/2 V2] nvme-rdma: Fix race between queue timeout and
 error recovery
In-Reply-To: <bdab697b-70dc-7c10-b7e2-5919f665924d@grimberg.me>
References: <1523196519-23268-1-git-send-email-israelr@mellanox.com>
 <1523196519-23268-2-git-send-email-israelr@mellanox.com>
 <bf223d7b-42fb-1a85-fd22-9f93e68015ff@grimberg.me>
 <586fda65-2038-f157-c278-f189b7524fdf@mellanox.com>
 <bdab697b-70dc-7c10-b7e2-5919f665924d@grimberg.me>
Message-ID: <15e2fadf6113efbb60d31cbcd0cff7e551fa4f0d.camel@wdc.com>

On Mon, 2018-04-09@00:02 +0300, Sagi Grimberg wrote:
> But we first update aborted_gstate (with interrupts disabled), sync srcu
> and only them terminate expired requests. So I still don't understand
> how we can end up completing a request twice.

There is a bug in the current blk-mq timeout mechanism that can cause both a
regular completion and a completion due to a timeout to occur. I will repost
tomorrow the patch that I came up with to fix that issue. See also "[PATCH
v2] blk-mq: Fix race between resetting the timer and completion handling"
(https://marc.info/?l=linux-block&m=151796816127318).

Bart.
