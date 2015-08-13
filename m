From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 12 Aug 2015 23:38:42 -0700
Subject: [PATCH] NVMe: Set queue max segments
In-Reply-To: <1439417874-8925-1-git-send-email-keith.busch@intel.com>
References: <1439417874-8925-1-git-send-email-keith.busch@intel.com>
Message-ID: <20150813063842.GA11272@infradead.org>

On Wed, Aug 12, 2015@04:17:54PM -0600, Keith Busch wrote:
> This sets the queue's max segment size to match the device's
> capabilities. The default of 128 is usable until a device's transfer
> capability exceeds 512k, assuming a device page size of 4k. Many nvme
> devices exceed that transfer limit, so this lets the block layer know what
> kind of commands it to allow to form rather than unnecessarily split them.
> 
> One additional segment is added to account for a transfer that may start
> in the middle of a page.

But it might not start in the middle of the page, too - in which case
you're overcounting here, aren't you?
