From: hch@lst.de (Christoph Hellwig)
Date: Tue, 18 Jul 2017 19:39:54 +0200
Subject: [PATCH] nvme/pci: Fix HMB size calculation
In-Reply-To: <1500335139-6338-1-git-send-email-keith.busch@intel.com>
References: <1500335139-6338-1-git-send-email-keith.busch@intel.com>
Message-ID: <20170718173954.GA7511@lst.de>

On Mon, Jul 17, 2017@07:45:39PM -0400, Keith Busch wrote:
> It's possible the preferred HMB size may not be a multiple of the
> chunk_size. This patch will set the chunk_size to the descriptor's actual
> length so the last iteration doesn't cause the total size to exceed the
> allocated HMB size.

This looks a little weird, and might do the wrong thing
if we hit the retry loop after reducing chunk_size.

I suspect we just need to change to

	for (size = 0; size < preferred; size += len) {

and move len to function scope.
