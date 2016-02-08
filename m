From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 8 Feb 2016 10:11:50 -0800
Subject: [PATCH 2/4] NVMe: Sync stopped queues with block layer
In-Reply-To: <1454515543-21683-3-git-send-email-keith.busch@intel.com>
References: <1454515543-21683-1-git-send-email-keith.busch@intel.com>
 <1454515543-21683-3-git-send-email-keith.busch@intel.com>
Message-ID: <20160208181150.GB13126@infradead.org>

I don't think a driver call to blk_sync_queue is a good idea.  It might
be useful as part of a bigger hammer, but then it should be hidden
behind that API.
