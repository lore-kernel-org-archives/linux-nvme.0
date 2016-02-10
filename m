From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 10 Feb 2016 10:47:09 -0800
Subject: [PATCH for-4.5 07/13] NVMe: Requeue requests on suspended queues
In-Reply-To: <1455128250-5984-8-git-send-email-keith.busch@intel.com>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
 <1455128250-5984-8-git-send-email-keith.busch@intel.com>
Message-ID: <20160210184709.GB26933@infradead.org>

On Wed, Feb 10, 2016@11:17:24AM -0700, Keith Busch wrote:
> It's possible a request may get to the driver after the nvme queue was
> disabled. This has the request requeue if that happens.
> 
> Note the request is still "started" by the driver, but requeuing will
> clear the start state for timeout handling.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
