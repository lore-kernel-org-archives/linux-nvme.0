From: axboe@fb.com (Jens Axboe)
Date: Tue, 12 Apr 2016 13:04:03 -0600
Subject: [PATCH v2] nvme: add missing lock nesting notation
In-Reply-To: <20160412190121.GC32482@infradead.org>
References: <1459877524-15471-1-git-send-email-mlin@kernel.org>
 <20160412190121.GC32482@infradead.org>
Message-ID: <570D46A3.1040304@fb.com>

On 04/12/2016 01:01 PM, Christoph Hellwig wrote:
> Jens, is this something we could still add to 4.6 to kill this annoying
> warning?

Can't it wait until 4.7? It's not a regression in this merge window, 
looks like it happened for 4.5.

-- 
Jens Axboe
