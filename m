From: hch@lst.de (Christoph Hellwig)
Date: Mon, 18 Sep 2017 02:17:36 +0200
Subject: [PATCH 10/10] nvme: implement multipath access to nvme subsystems
In-Reply-To: <20170829154138.GB4428@localhost.localdomain>
References: <20170823175815.3646-1-hch@lst.de>
 <20170823175815.3646-11-hch@lst.de>
 <20170829145417.GA4428@localhost.localdomain> <20170829145559.GA32760@lst.de>
 <20170829154138.GB4428@localhost.localdomain>
Message-ID: <20170918001736.GA4441@lst.de>

On Tue, Aug 29, 2017@11:41:38AM -0400, Keith Busch wrote:
> Speaking of timeouts, nvme_req_needs_retry will fail the command
> immediately rather than try the alternate path if it was cancelled due
> to timeout handling. Should we create a new construct for a command's
> total time separate from recovery timeout so we may try an alternate
> paths?

We probably need to anyway, see the discussion with James in the
other thread.
