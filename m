From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 13 Mar 2017 08:23:14 -0600
Subject: [PATCH] blk-mq: Fix tagset reinit in the presence of cpu
 hot-unplug
In-Reply-To: <1489414211-30437-1-git-send-email-sagi@grimberg.me>
References: <1489414211-30437-1-git-send-email-sagi@grimberg.me>
Message-ID: <05295231-7e4b-7043-34df-b3611af8c7a2@kernel.dk>

On 03/13/2017 08:10 AM, Sagi Grimberg wrote:
> In case cpu was unplugged, we need to make sure not to assume
> that the tags for that cpu are still allocated. so check
> for null tags when reinitializing a tagset.

Thanks Sagi, that seems reasonable. Applied for 4.11.

-- 
Jens Axboe
