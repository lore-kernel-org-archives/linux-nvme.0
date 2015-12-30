From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 30 Dec 2015 09:52:32 -0800
Subject: [PATCH 2/5] NVMe: Use a retryable error code on reset
In-Reply-To: <1451496471-29370-3-git-send-email-keith.busch@intel.com>
References: <1451496471-29370-1-git-send-email-keith.busch@intel.com>
 <1451496471-29370-3-git-send-email-keith.busch@intel.com>
Message-ID: <20151230175232.GC21400@infradead.org>

On Wed, Dec 30, 2015@10:27:48AM -0700, Keith Busch wrote:
> Use a fake status that can potentially be retried on reset.

I thought I only added this to make you happy, so I'm fine with
changing it.

But I don't understand why NVME_SC_CANCELLED isn't retryable,
nvme_req_needs_retry doesn't treat negative error codes special.
If it did we'd need to fix it as we want to be able to rety
the other cases where it is returned as well.

Which btw brings me to a bug I noticed a while ago but didn't
have time to fully understand: nvme_req_needs_retry looks
at req->start_time vs req->timeout, but that means we'll
fail any command that times out, even if we resubmit it
after a controller reset.  Should we really have that clause
in there?
