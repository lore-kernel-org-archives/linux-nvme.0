From: keith.busch@intel.com (Keith Busch)
Date: Fri, 2 Oct 2015 14:17:30 +0000 (UTC)
Subject: [PATCH 2/2] NVMe: Simplify device resume on io queue failure
In-Reply-To: <20151002130334.GB11175@infradead.org>
References: <1443741251-13274-1-git-send-email-keith.busch@intel.com>
 <1443741251-13274-3-git-send-email-keith.busch@intel.com>
 <20151002130334.GB11175@infradead.org>
Message-ID: <alpine.LNX.2.00.1510021402190.23840@localhost.lm.intel.com>

On Fri, 2 Oct 2015, Christoph Hellwig wrote:
> On Thu, Oct 01, 2015@05:14:11PM -0600, Keith Busch wrote:
>> this patch removes the unnecessary indirection, and places all work
>> tasks onto the global work queue.
>
> Can you explain why nvme_workq is removed here?  I don't really
> understand why it's realted, but that might be because I don't
> even know why it exists in the first place.  Maybe this should be a
> separate patch with a separate changelog entry?

That's the part I thought may need to be separated. I noticed using the
single threaded work queue for recovery was a bad idea when confirming
the failure injection on my drives to test the rest of the patch.

So yes, the relationship is a bit dubious. I ran out of time to split
before posting yesterday. I'll resend 2/2 as two patches.

> Otherwise looks good,
>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
