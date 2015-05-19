From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 19 May 2015 09:14:06 -0600
Subject: fix queue_lock usage in blk-mq and nvme
In-Reply-To: <20150519063709.GA22313@infradead.org>
References: <1430984294-25859-1-git-send-email-hch@lst.de>
 <20150519063709.GA22313@infradead.org>
Message-ID: <555B533E.7020702@kernel.dk>

On 05/19/2015 12:37 AM, Christoph Hellwig wrote:
> ping?

Sorry, both applied, looks fine to me and wont impact fast path.

-- 
Jens Axboe
