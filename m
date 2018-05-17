From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 17 May 2018 08:33:34 -0700
Subject: [PATCH 3/3] nvme: drop IRQ disabling on submission queue lock
In-Reply-To: <1526569337-3489-4-git-send-email-axboe@kernel.dk>
References: <1526569337-3489-1-git-send-email-axboe@kernel.dk>
 <1526569337-3489-4-git-send-email-axboe@kernel.dk>
Message-ID: <20180517153334.GE19042@infradead.org>

On Thu, May 17, 2018@09:02:17AM -0600, Jens Axboe wrote:
> Since we aren't sharing the lock for completions now, we don't
> have to make it IRQ safe.

Ah, you did this as a separate patch..

Reviewed-by: Christoph Hellwig <hch at lst.de>

for both.
