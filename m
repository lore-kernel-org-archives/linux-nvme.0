From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 2 Oct 2015 06:03:34 -0700
Subject: [PATCH 2/2] NVMe: Simplify device resume on io queue failure
In-Reply-To: <1443741251-13274-3-git-send-email-keith.busch@intel.com>
References: <1443741251-13274-1-git-send-email-keith.busch@intel.com>
 <1443741251-13274-3-git-send-email-keith.busch@intel.com>
Message-ID: <20151002130334.GB11175@infradead.org>

On Thu, Oct 01, 2015@05:14:11PM -0600, Keith Busch wrote:
> this patch removes the unnecessary indirection, and places all work
> tasks onto the global work queue.

Can you explain why nvme_workq is removed here?  I don't really
understand why it's realted, but that might be because I don't
even know why it exists in the first place.  Maybe this should be a
separate patch with a separate changelog entry?

Otherwise looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
