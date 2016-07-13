From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 12 Jul 2016 19:22:06 -0700
Subject: [PATCHv3 for-4.7] nvme: Remove RCU namespace protection
In-Reply-To: <57857A01.1080004@kernel.dk>
References: <1467825770-27355-1-git-send-email-keith.busch@intel.com>
 <20160709010754.GA28997@localhost.localdomain>
 <57857A01.1080004@kernel.dk>
Message-ID: <20160713022206.GA17034@infradead.org>

On Tue, Jul 12, 2016@04:15:13PM -0700, Jens Axboe wrote:
> I'm going back and forth on this... This isn't a regression for 4.7, is it?
> If so, I'd be a lot more comfortable queuing this up for 4.8 (marked stable)
> instead. It'll be another late addition, causing issues when it comes time
> to merge for-4.8/drivers in the next merge window.

It's a 4.7 regression.
