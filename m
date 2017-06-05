From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Mon, 5 Jun 2017 21:31:52 +0000
Subject: [PATCH v4 05/11] blk-mq: use the introduced
 blk_mq_unquiesce_queue()
In-Reply-To: <20170605155925.7896-6-ming.lei@redhat.com>
References: <20170605155925.7896-1-ming.lei@redhat.com>
 <20170605155925.7896-6-ming.lei@redhat.com>
Message-ID: <1496698311.2623.27.camel@sandisk.com>

On Mon, 2017-06-05@23:59 +0800, Ming Lei wrote:
> blk_mq_unquiesce_queue() is used for unquiescing the
> queue explicitly, so replace blk_mq_start_stopped_hw_queues()
> with it.

Reviewed-by: Bart Van Assche <Bart.VanAssche at sandisk.com>
