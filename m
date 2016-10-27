From: snitzer@redhat.com (Mike Snitzer)
Date: Thu, 27 Oct 2016 10:01:21 -0400
Subject: [PATCH 07/12] dm: Use BLK_MQ_S_STOPPED instead of
 QUEUE_FLAG_STOPPED in blk-mq code
In-Reply-To: <a0733adf-065e-2099-3850-cb1c55df1e35@sandisk.com>
References: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
 <a0733adf-065e-2099-3850-cb1c55df1e35@sandisk.com>
Message-ID: <20161027140121.GA16816@redhat.com>

On Wed, Oct 26 2016 at  6:54pm -0400,
Bart Van Assche <bart.vanassche@sandisk.com> wrote:

> Instead of manipulating both QUEUE_FLAG_STOPPED and BLK_MQ_S_STOPPED
> in the dm start and stop queue functions, only manipulate the latter
> flag. Change blk_queue_stopped() tests into blk_mq_queue_stopped().
> 
> Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> Cc: Mike Snitzer <snitzer at redhat.com>

Acked-by: Mike Snitzer <snitzer at redhat.com>
