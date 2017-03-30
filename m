From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 30 Mar 2017 04:23:12 -0700
Subject: [PATCH 0/3] update request retries (loop, rdma, fc)
In-Reply-To: <1490810427-27776-1-git-send-email-sagi@grimberg.me>
References: <1490810427-27776-1-git-send-email-sagi@grimberg.me>
Message-ID: <20170330112312.GA29643@infradead.org>

On Wed, Mar 29, 2017@09:00:24PM +0300, Sagi Grimberg wrote:
> Keep a consistent behavior with what's checked in the core which
> does not requeue if we exhausted nvme_max_retries.

Looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>

But we really need to move this to common code.  I'll send a series
to do that, but it will be on top of your series.
