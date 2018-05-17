From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 17 May 2018 08:30:42 -0700
Subject: [PATCH 1/3] nvme: remove ->cq_vector == -1 check in
 nvme_queue_rq()
In-Reply-To: <1526569337-3489-2-git-send-email-axboe@kernel.dk>
References: <1526569337-3489-1-git-send-email-axboe@kernel.dk>
 <1526569337-3489-2-git-send-email-axboe@kernel.dk>
Message-ID: <20180517153041.GC19042@infradead.org>

Looks good.  I somehow remember seeing an equivalent patch on the
list a while ago, though..

Reviewed-by: Christoph Hellwig <hch at lst.de>
