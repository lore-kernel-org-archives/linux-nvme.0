From: hch@lst.de (Christoph Hellwig)
Date: Wed, 19 Oct 2016 15:19:00 +0200
Subject: [PATCH v3 02/11] blk-mq: Introduce blk_mq_hctx_stopped()
In-Reply-To: <b5b0ffcc-767d-1b90-9c5a-52c57690dea8@sandisk.com>
References: <b39eb0e7-1007-eb63-8e7f-9a7f08508379@sandisk.com>
 <b5b0ffcc-767d-1b90-9c5a-52c57690dea8@sandisk.com>
Message-ID: <20161019131900.GB6323@lst.de>

On Tue, Oct 18, 2016@02:49:09PM -0700, Bart Van Assche wrote:
> Multiple functions test the BLK_MQ_S_STOPPED bit so introduce
> a helper function that performs this test.

Looks sensible.  Any reason to have it in the public blk-mq.h instead
of the private one, though?  I see that dm is using it with this patch,
but that usage should go away once your full series is merged, right?
