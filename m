From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 30 Dec 2015 09:49:54 -0800
Subject: [PATCH 1/5] NVMe: Fix admin queue ring wrap
In-Reply-To: <1451496471-29370-2-git-send-email-keith.busch@intel.com>
References: <1451496471-29370-1-git-send-email-keith.busch@intel.com>
 <1451496471-29370-2-git-send-email-keith.busch@intel.com>
Message-ID: <20151230174954.GB21400@infradead.org>

On Wed, Dec 30, 2015@10:27:47AM -0700, Keith Busch wrote:
> The tag set queue depth needs to be one less than the h/w queue depth
> so we don't wrap the circular buffer. This conforms to the specification
> defined "Full Queue" condition.

You'll need to change NVME_AQ_DEPTH to make sure the magic for the
AEN commands still work.

But can you explain the actual issue a little more while we're at it?
Preferably in a comment in the code!
