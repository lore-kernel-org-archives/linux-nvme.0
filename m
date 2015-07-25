From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 24 Jul 2015 23:25:11 -0700
Subject: [PATCH v5 4/5] null_blk: LightNVM support
In-Reply-To: <55B0C660.8010509@lightnvm.io>
References: <1437587464-7964-1-git-send-email-mb@lightnvm.io>
 <1437587464-7964-5-git-send-email-mb@lightnvm.io>
 <20150723095351.GB26420@infradead.org>
 <55B0C660.8010509@lightnvm.io>
Message-ID: <20150725062511.GA26437@infradead.org>

On Thu, Jul 23, 2015@12:48:00PM +0200, Matias Bj?rling wrote:
> Only reason was to not duplicate the I/O submission/completion flow.
> With the simple code at the moment, it is little to add. However, if
> someone decides to put backing store, simulation, etc. into it, then it
> should properly go into another module.
> 
> Do you want me to move it into a new driver for this patchset?

I'd prefer to have it separate unless there's a good reason to merge it
into null_blk.  From your above descriptions it sounds like it really
should be separate.
