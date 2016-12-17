From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 16 Dec 2016 23:13:15 -0800
Subject: [PATCH] nvme: simplify stripe quirk
In-Reply-To: <20161216154800.GB8888@localhost.localdomain>
References: <1481760655-25877-1-git-send-email-keith.busch@intel.com>
 <20161215083236.GA32244@infradead.org>
 <20161215155958.GA29688@localhost.localdomain>
 <20161216080753.GB22912@infradead.org>
 <20161216154800.GB8888@localhost.localdomain>
Message-ID: <20161217071315.GA30294@infradead.org>

On Fri, Dec 16, 2016@10:48:01AM -0500, Keith Busch wrote:
> It's fortunately not common for an OEM to break the decoding assumptions
> we were promised, but the problem exists. I think this patch is the best
> I can do for these devices.

With a small change to the changelog including the above and clearly
stating that it's an OEM changing it (and not the subsystem vendor
which sounds weird in NVMe context):


Reluctantly-Acked-by: Christoph Hellwig <hch at lst.de>
