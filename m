From: keith.busch@intel.com (Keith Busch)
Date: Wed, 22 Jun 2016 13:01:22 -0400
Subject: [PATCH] nvme: Limit command retries
In-Reply-To: <20160622161442.GB10592@infradead.org>
References: <1466444691-29448-1-git-send-email-keith.busch@intel.com>
 <20160622161442.GB10592@infradead.org>
Message-ID: <20160622170122.GH1448@localhost.localdomain>

On Wed, Jun 22, 2016@09:14:42AM -0700, Christoph Hellwig wrote:
> How urgent is this patch?  If it fixes an actual major issue seen
> in the field we should probably but the ->retries use in as-is,
> otherwise I'd prefer to avoid introducing more users of it for now.

Cool, thanks. This is not an urgent issue for us, but was hoping to make
the 4.8 window. If we can flush something better out, I'm happy to wait.
