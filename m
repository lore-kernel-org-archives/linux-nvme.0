From: hch@lst.de (Christoph Hellwig)
Date: Wed, 20 Feb 2019 15:17:01 +0100
Subject: Regression: NVMe: kernel BUG at lib/sg_pool.c:103!
In-Reply-To: <20190220031122.GA17298@ming.t460p>
References: <20190220031122.GA17298@ming.t460p>
Message-ID: <20190220141701.GA26537@lst.de>

We shouldn't be allocating a scatterlist for a command that doesn't
have a payload.

The blk_rq_payload_bytes check in nvme_rdma_map_data is supposed to
prevent that.

Chaitanya, can you try to debug why this is not working?  I'm on
vacation and don't have much time right now unfortunately.
