From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 26 Jan 2016 08:54:15 -0800
Subject: [PATCH 2/2] NVMe: Fix io incapable return values
In-Reply-To: <1453757017-13640-2-git-send-email-keith.busch@intel.com>
References: <1453757017-13640-1-git-send-email-keith.busch@intel.com>
 <1453757017-13640-2-git-send-email-keith.busch@intel.com>
Message-ID: <20160126165415.GC609@infradead.org>

On Mon, Jan 25, 2016@02:23:37PM -0700, Keith Busch wrote:
> The function returns true when the controller can't handle IO.

Ooops.  I though I had actually seen a fix for this a short while
ago, not sure why that got missed.

Acked-by: Christoph Hellwig <hch at lst.de>
