From: hch@lst.de (Christoph Hellwig)
Date: Fri, 29 Dec 2017 10:59:39 +0100
Subject: [PATCH V2 5/6] blk-mq: fix race between updating nr_hw_queues
 and switching io sched
In-Reply-To: <20171214023103.18272-6-ming.lei@redhat.com>
References: <20171214023103.18272-1-ming.lei@redhat.com>
 <20171214023103.18272-6-ming.lei@redhat.com>
Message-ID: <20171229095939.GE24507@lst.de>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
