From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 30 Jul 2015 09:11:04 -0700
Subject: [PATCH] blk: add vector gaps queue parameter
In-Reply-To: <55B9E893.7050509@dev.mellanox.co.il>
References: <1438189313-29722-1-git-send-email-keith.busch@intel.com>
 <55B9E893.7050509@dev.mellanox.co.il>
Message-ID: <20150730161104.GA30014@infradead.org>

On Thu, Jul 30, 2015@12:04:19PM +0300, Sagi Grimberg wrote:
> I wander if its better to default to PAGE_SIZE to not change the
> existing functionality? Or do we want to force drivers to set virt_mask?

I'd say we should remove the SG_GAPS flag (which is horribly misnamed
anyway) and just have this field.  0 means we don't need to check at
all, and any actual value checks for that value.
