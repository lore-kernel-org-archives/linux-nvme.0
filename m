From: hch@lst.de (Christoph Hellwig)
Date: Wed, 19 Oct 2016 15:17:34 +0200
Subject: [PATCH v3 01/11] blk-mq: Do not invoke .queue_rq() for a
 stopped queue
In-Reply-To: <595d4b59-3892-ef24-ef91-b7cab6611af7@sandisk.com>
References: <b39eb0e7-1007-eb63-8e7f-9a7f08508379@sandisk.com>
 <595d4b59-3892-ef24-ef91-b7cab6611af7@sandisk.com>
Message-ID: <20161019131734.GA6323@lst.de>

Good catch,

Reviewed-by: Christoph Hellwig <hch at lst.de>
