From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 10 Feb 2016 10:54:04 -0800
Subject: [PATCH for-4.5 13/13] NVMe: Rate limit nvme IO warnings
In-Reply-To: <1455128250-5984-14-git-send-email-keith.busch@intel.com>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
 <1455128250-5984-14-git-send-email-keith.busch@intel.com>
Message-ID: <20160210185404.GB10459@infradead.org>

On Wed, Feb 10, 2016@11:17:30AM -0700, Keith Busch wrote:
> We don't need to spam the kernel logs with thousands of messages. We
> can infer all IO's are being cancelled with fewer messages.

Do we need this message at all?
