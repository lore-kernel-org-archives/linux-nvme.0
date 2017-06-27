From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 27 Jun 2017 07:11:15 -0700
Subject: [PATCH 9/9] nvme: add support for streams and directives
In-Reply-To: <d2dcae41-d0b2-71a7-a63d-b7ef25ae47d2@kernel.dk>
References: <1498004526-4543-1-git-send-email-axboe@kernel.dk>
 <1498004526-4543-10-git-send-email-axboe@kernel.dk>
 <20170626095907.GG14057@infradead.org>
 <d2dcae41-d0b2-71a7-a63d-b7ef25ae47d2@kernel.dk>
Message-ID: <20170627141115.GA2541@infradead.org>

On Mon, Jun 26, 2017@07:56:22AM -0600, Jens Axboe wrote:
> >  - do we even need the < 4 streams fallback now that they are global
> >    instead of per-ns instead of just disabling the feature for now?
> 
> Maybe the device only supports 2? or 3?

My crystal ball indicates that those are unlikely too see the
light.  IFF we need to handle them we can still add code for it.
