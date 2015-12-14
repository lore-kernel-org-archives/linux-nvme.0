From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 14 Dec 2015 02:15:47 -0800
Subject: [PATCH] nvme: Move nvme_freeze/unfreeze_queues to nvme core
In-Reply-To: <1450024038-1694-1-git-send-email-sagig@mellanox.com>
References: <1450024038-1694-1-git-send-email-sagig@mellanox.com>
Message-ID: <20151214101547.GA5783@infradead.org>

On Sun, Dec 13, 2015@06:27:18PM +0200, Sagi Grimberg wrote:
> Nothing pci specific about them and We'll need them exported
> in other transports too.

Note that except for the loop over the namespaces there isn't anything
nvme specific either.  I'm fine with the patch for now, but in the
long run it might make sense to move most of it to the block layer.

Reviewed-by: Christoph Hellwig <hch at lst.de>
