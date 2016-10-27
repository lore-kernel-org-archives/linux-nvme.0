From: hch@lst.de (Christoph Hellwig)
Date: Thu, 27 Oct 2016 14:44:09 +0200
Subject: [PATCH 06/12] blk-mq: Add a kick_requeue_list argument to
 blk_mq_requeue_request()
In-Reply-To: <3944826d-bfde-f1e6-40ec-2c9a3c259e3a@sandisk.com>
References: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
 <3944826d-bfde-f1e6-40ec-2c9a3c259e3a@sandisk.com>
Message-ID: <20161027124409.GE13200@lst.de>

On Wed, Oct 26, 2016@03:53:39PM -0700, Bart Van Assche wrote:
> Most blk_mq_requeue_request() and blk_mq_add_to_requeue_list() calls
> are followed by kicking the requeue list. Hence add an argument to
> these two functions that allows to kick the requeue list. This was
> proposed by Christoph Hellwig.

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
