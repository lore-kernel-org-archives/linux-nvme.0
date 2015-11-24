From: axboe@fb.com (Jens Axboe)
Date: Tue, 24 Nov 2015 12:42:54 -0700
Subject: [PATCHv2 1/2] blk-mq: allow timer to freeze its own queue
In-Reply-To: <1448390128-25758-1-git-send-email-keith.busch@intel.com>
References: <1448390128-25758-1-git-send-email-keith.busch@intel.com>
Message-ID: <5654BDBE.1020509@fb.com>

On 11/24/2015 11:35 AM, Keith Busch wrote:
> This patch removes synchronizing the timeout work so that the timer can
> start a freeze on its own queue. The timer enters the queue, so timer
> context can only start a freeze, but not wait for frozen.

This looks good.

-- 
Jens Axboe
