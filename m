From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 31 Jul 2015 20:26:57 -0700
Subject: [PATCH] NVMe: Add device id to vendor specific chunk size
In-Reply-To: <1438380239-29643-1-git-send-email-keith.busch@intel.com>
References: <1438380239-29643-1-git-send-email-keith.busch@intel.com>
Message-ID: <20150801032657.GA8488@infradead.org>

On Fri, Jul 31, 2015@04:03:59PM -0600, Keith Busch wrote:
> A controller with a new device id supports the same striping feature
> currently used with DID 0953h, so appending the new device identifier
> to the check that enables this feature.

Eww.   Why do we need these workarounds for new hardware?  If this is
something Intel want to be stuck with it should be pushed as something
reported in IDENTIFY data.
