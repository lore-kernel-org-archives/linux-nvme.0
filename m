From: hch@lst.de (Christoph Hellwig)
Date: Mon, 22 May 2017 20:48:12 +0200
Subject: [PATCH v3 0/3] nvme: fix hang in path of removing disk
In-Reply-To: <20170522150505.452-1-ming.lei@redhat.com>
References: <20170522150505.452-1-ming.lei@redhat.com>
Message-ID: <20170522184812.GA1360@lst.de>

Thanks Ming,

I'll add the three patches to the nvme-4.12 queue, assuming Jens
is okay with us queueing up the block path to remove
blk_mq_abort_requeue_list.
