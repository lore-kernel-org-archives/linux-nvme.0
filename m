From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 15 Dec 2016 00:32:36 -0800
Subject: [PATCH] nvme: simplify stripe quirk
In-Reply-To: <1481760655-25877-1-git-send-email-keith.busch@intel.com>
References: <1481760655-25877-1-git-send-email-keith.busch@intel.com>
Message-ID: <20161215083236.GA32244@infradead.org>

On Wed, Dec 14, 2016@07:10:55PM -0500, Keith Busch wrote:
> Some subsystem vendors believe they own the Identify Controller vendor
> specific region, and will repurpose it with their own values.

Well, it's vendor specific, right?

I don't understand this patch at all - you hardcode a value that was
previously vendor specific, and your argument for that is that the
vendor specific value is used by the value - heck, that's exactly why
the value is there.
