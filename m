From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 5 Apr 2016 05:37:42 -0700
Subject: [PATCH] nvme: add missing lock nesting notation
In-Reply-To: <1459838543-437-1-git-send-email-mlin@kernel.org>
References: <1459838543-437-1-git-send-email-mlin@kernel.org>
Message-ID: <20160405123742.GB19495@infradead.org>

On Mon, Apr 04, 2016@11:42:23PM -0700, Ming Lin wrote:
> From: Ming Lin <ming.l at ssi.samsung.com>
> 
> When unloading driver, nvme_disable_io_queues() calls nvme_delete_queue()
> that sends nvme_admin_delete_cq command to admin sq. So when the command
> completed, the lock acquired by nvme_irq() actually belongs to admin queue.
> 
> While the lock that nvme_del_cq_end() trying to acquire belongs to io queue.
> So it will not deadlock.
> 
> This patch adds lock nesting notation to fix following report.

Looks fine, but please add a little comment that we might be called with
the AQ q_lock held and that the I/O queue q_lock should always nest
inside the AQ one.
