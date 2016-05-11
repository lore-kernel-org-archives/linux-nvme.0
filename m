From: keith.busch@intel.com (Keith Busch)
Date: Wed, 11 May 2016 15:16:33 -0400
Subject: [PATH v2] NVMe: init nvme queue before enabling irq
In-Reply-To: <e41c65a6b6637ef16f7f11ac147a9466@suse.de>
References: <1453286915-18814-1-git-send-email-mail_weber_wang@163.com>
 <e41c65a6b6637ef16f7f11ac147a9466@suse.de>
Message-ID: <20160511191632.GC31047@localhost.localdomain>

On Wed, May 11, 2016@11:25:16AM +0200, Johannes Thumshirn wrote:
> What ever happened to this patch?
> I can easily reproduce the bug using
> while [ true ]; do rmmod nvme nvme_core; modprobe nvme; done

This patch was supposed to fix using a doorbell between resets when the
driver had BAR0 unmapped. We don't ever unmap the bar anymore, so this
patch shouldn't be necessary: the doorbell is already set during queue
allocation before requset_irq.

The test doesn't seem like this patch would help either. It sounds
more like you're hitting somethine else if you don't have this fix:

  https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git/commit/?h=for-linus&id=9bf2b972afeaffd173fe2ce211ebc555ea7e8a87

If you do have that fix already, I'd like to see the panic stack trace
(assuming that's what happened).
