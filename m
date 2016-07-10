From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 10 Jul 2016 02:47:42 -0700
Subject: [PATCH] nvme: Limit command retries
In-Reply-To: <20160622170122.GH1448@localhost.localdomain>
References: <1466444691-29448-1-git-send-email-keith.busch@intel.com>
 <20160622161442.GB10592@infradead.org>
 <20160622170122.GH1448@localhost.localdomain>
Message-ID: <20160710094742.GB5897@infradead.org>

On Wed, Jun 22, 2016@01:01:22PM -0400, Keith Busch wrote:
> On Wed, Jun 22, 2016@09:14:42AM -0700, Christoph Hellwig wrote:
> > How urgent is this patch?  If it fixes an actual major issue seen
> > in the field we should probably but the ->retries use in as-is,
> > otherwise I'd prefer to avoid introducing more users of it for now.
> 
> Cool, thanks. This is not an urgent issue for us, but was hoping to make
> the 4.8 window. If we can flush something better out, I'm happy to wait.

Given that even the prep patches for that work aren't merged yet
they aren't likely to make it for 4.8.

Based on that I think we should get this patch in for the merge window:

Reviewed-by: Christoph Hellwig <hch at lst.de>
