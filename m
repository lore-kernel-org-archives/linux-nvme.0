From: josef@toxicpanda.com (Josef Bacik)
Date: Wed, 30 May 2018 13:27:32 -0400
Subject: [PATCH] blk-mq: only iterate over inflight requests in
 blk_mq_tagset_busy_iter
In-Reply-To: <20180530165100.31186-1-hch@lst.de>
References: <20180530165100.31186-1-hch@lst.de>
Message-ID: <20180530172731.md54u3wuri3qmfbv@destiny>

On Wed, May 30, 2018@06:51:00PM +0200, Christoph Hellwig wrote:
> We already check for started commands in all callbacks, but we should
> also protect against already completed commands.  Do this by taking
> the checks to common code.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Acked-by: Josef Bacik <josef at toxicpanda.com>

for the nbd portion.  Thanks,

Josef
