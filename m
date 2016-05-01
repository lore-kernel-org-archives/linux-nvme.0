From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 1 May 2016 11:05:41 -0700
Subject: [PATCH] NVMe: nvme_core_exit() should do cleanup in the reverse
 order as nvme_core_init does
In-Reply-To: <1461831571-5248-1-git-send-email-shhuiw@foxmail.com>
References: <1461831571-5248-1-git-send-email-shhuiw@foxmail.com>
Message-ID: <20160501180541.GA8879@infradead.org>

On Thu, Apr 28, 2016@04:19:31PM +0800, Wang Sheng-Hui wrote:
> nvme_core_init does:
>     1) register_blkdev
>     2) __register_chrdev
>     3) class_create
> 
> nvme_core_exit should do cleanup in the reverse order.

Not sure why this would matter, but it looks correct to me:

Reviewed-by: Christoph Hellwig <hch at lst.de>
