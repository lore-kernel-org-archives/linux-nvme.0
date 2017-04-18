From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Tue, 18 Apr 2017 22:50:18 +0000
Subject: blk-mq: remove the error argument to blk_mq_complete_request
In-Reply-To: <20170418155229.5977-16-hch@bombadil.infradead.org>
References: <20170418155229.5977-1-hch@bombadil.infradead.org>
 <20170418155229.5977-16-hch@bombadil.infradead.org>
Message-ID: <1492555816.2689.20.camel@sandisk.com>

On Tue, 2017-04-18@08:52 -0700, Christoph Hellwig wrote:
> Now that we always have a ->complete callback we can remove the direct
> call to blk_mq_end_request, as well as the error argument to
> blk_mq_complete_request.

Hello Christoph,

Please add a runtime check that issues a warning early if a .complete
callback function is missing.

Are you sure that all blk-mq drivers have a .complete callback? In the
request-errors branch of your block git tree I found the following:

static const struct blk_mq_ops rbd_mq_ops = {
	.queue_rq	= rbd_queue_rq,
	.init_request	= rbd_init_request,
};

static const struct blk_mq_ops ubiblock_mq_ops = {
	.queue_rq???????= ubiblock_queue_rq,
	.init_request	= ubiblock_init_request,
};

Thanks,

Bart.
