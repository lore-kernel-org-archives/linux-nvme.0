From: hch@lst.de (Christoph Hellwig)
Date: Mon, 12 Oct 2015 19:42:46 +0200
Subject: [PATCH] NVMe: Add explicit block config dependency
In-Reply-To: <1444671458-9947-1-git-send-email-keith.busch@intel.com>
References: <1444671458-9947-1-git-send-email-keith.busch@intel.com>
Message-ID: <20151012174246.GA30222@lst.de>

On Mon, Oct 12, 2015@11:37:38AM -0600, Keith Busch wrote:
> The nvme driver was moved from drivers/block, losing our implicit
> dependency on CONFIG_BLOCK. This makes it an explicit driver dependency.
> 
> Reported-by: Jim Davis <jim.epost at gmail.com>
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Oh, that explains the odd errors - I actually just got a similar one
from the buildbot and couldn't make sense of it.

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
