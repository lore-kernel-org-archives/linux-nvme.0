From: hch@lst.de (Christoph Hellwig)
Date: Sun, 8 Jan 2017 11:01:52 +0100
Subject: [PATCH 2/6] irq/affinity: Assign offline CPUs a vector
In-Reply-To: <1483569671-1462-3-git-send-email-keith.busch@intel.com>
References: <1483569671-1462-1-git-send-email-keith.busch@intel.com>
 <1483569671-1462-3-git-send-email-keith.busch@intel.com>
Message-ID: <20170108100152.GA26025@lst.de>

On Wed, Jan 04, 2017@05:41:07PM -0500, Keith Busch wrote:
> The offline CPUs need to assigned to something incase they come online
> later, otherwise anyone using the mapping for things other than affinity
> will have blank entries for that online CPU.

I don't really like the idea behind it.  Back when we came up with
this code I had some discussion with Thomas if we should do the
assignment only for online CPUs, or maybe for all possible CPUs.

Except for some big iron with physical node hotplug the difference
usually is just that some nodes have been temporarily offlined.  So
maybe we need to bite the bullet and move the irq and block code
to consider all possible cpus.
