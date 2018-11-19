From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 18 Nov 2018 23:58:17 -0800
Subject: [PATCH 1/7] block: avoid ordered task state change for polled IO
In-Reply-To: <20181117214354.822-2-axboe@kernel.dk>
References: <20181117214354.822-1-axboe@kernel.dk>
 <20181117214354.822-2-axboe@kernel.dk>
Message-ID: <20181119075817.GA9622@infradead.org>

On Sat, Nov 17, 2018@02:43:48PM -0700, Jens Axboe wrote:
> For the core poll helper, the task state setting don't need
> to imply any atomics, as it's the current task itself that
> is being modified and we're not going to sleep.
> 
> For IRQ driven, the wakeup path have the necessary barriers
> to not need us using the heavy handed version of the task
> state setting.

Looks good (except for the horizontally challegened commit log):

Reviewed-by: Christoph Hellwig <hch at lst.de>
