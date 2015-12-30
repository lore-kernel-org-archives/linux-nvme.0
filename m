From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 30 Dec 2015 09:53:37 -0800
Subject: [PATCH 3/5] NVMe: Remove queue freezing on resets
In-Reply-To: <1451496471-29370-4-git-send-email-keith.busch@intel.com>
References: <1451496471-29370-1-git-send-email-keith.busch@intel.com>
 <1451496471-29370-4-git-send-email-keith.busch@intel.com>
Message-ID: <20151230175337.GD21400@infradead.org>

Looks fine to me, but this conflicts with Sagis patch to move
nvme_{un,}freeze_queues to common code and my patches that sit
on top of that.  Guess I'll need to rebase that series again.

Reviewed-by: Christoph Hellwig <hch at lst.de>
