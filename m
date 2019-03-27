From: hch@lst.de (Christoph Hellwig)
Date: Wed, 27 Mar 2019 09:30:10 +0100
Subject: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
In-Reply-To: <20190318032950.17770-2-ming.lei@redhat.com>
References: <20190318032950.17770-1-ming.lei@redhat.com>
 <20190318032950.17770-2-ming.lei@redhat.com>
Message-ID: <20190327083010.GO20525@lst.de>

Please make this an EXPORT_SYMBOL_GPL as for all new low-level blk-mq
exports.  Otherwise looks fine modolo any minor documentatio nitpicks
that I might have seen in the thread:

Reviewed-by: Christoph Hellwig <hch at lst.de>
