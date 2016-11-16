From: keith.busch@intel.com (Keith Busch)
Date: Wed, 16 Nov 2016 13:46:07 -0500
Subject: [PATCH] nvme/pci: Don't free queues on error
In-Reply-To: <20161116170855.GB5005@lst.de>
References: <1479243386-4383-1-git-send-email-keith.busch@intel.com>
 <20161116170855.GB5005@lst.de>
Message-ID: <20161116184607.GC10050@localhost.localdomain>

On Wed, Nov 16, 2016@06:08:55PM +0100, Christoph Hellwig wrote:
> should this get a Cc to stable?

Sure thing, but it'll have be a different patch going back to just
stable-4.8.y. I'll follow "option 3" from the Stable Kernel Rules once
this is applied.
