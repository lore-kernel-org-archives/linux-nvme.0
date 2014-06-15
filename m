From: axboe@kernel.dk (Jens Axboe)
Date: Sun, 15 Jun 2014 09:17:55 -0600
Subject: [PULL REQUEST] NVMe driver updates for 3.16
In-Reply-To: <20140615102831.GE12025@linux.intel.com>
References: <20140615102831.GE12025@linux.intel.com>
Message-ID: <539DB923.3090005@kernel.dk>

On 2014-06-15 04:28, Matthew Wilcox wrote:
>
> Hi Linus,
>
> Mostly bugfixes again for the NVMe driver.  I'd like to call out the
> exported tracepoint in the block layer; I believe Keith has cleared this
> with Jens.

I believe he has not, I haven't seen that patch before (otherwise it 
should have had an ack). But it's not deal, we just have to remember to 
undo it when the blk-mq conversion goes in.

-- 
Jens Axboe
