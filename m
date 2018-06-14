From: hch@lst.de (Christoph Hellwig)
Date: Thu, 14 Jun 2018 14:30:13 +0200
Subject: remove nvme_reinit_tagset and blk_mq_tagset_iter
Message-ID: <20180614123015.5989-1-hch@lst.de>

Now that nvme-fc moved off the reinit request concept both the core nvme
and blk-mq code for it becomes unused.

Jens, are you ok with queuing up the blk-mq side with the pending nvme
changes?
