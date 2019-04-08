From: kbusch@kernel.org (Keith Busch)
Date: Mon, 8 Apr 2019 09:23:02 -0600
Subject: [PATCH] blk-mq: Wait for for hctx requests on CPU unplug
In-Reply-To: <20190407075123.GA22003@infradead.org>
References: <20190405215920.27085-1-keith.busch@intel.com>
 <226503cd-53ac-902c-7944-b2748407b1d3@kernel.dk>
 <20190405223719.GC25081@localhost.localdomain>
 <d4a4b6c0-3ea8-f748-85b0-6b39c5023a6f@kernel.dk>
 <CAOSXXT7V3E2j_Ut=hJ2X3QcdLwuWGRFtgzTs4iTe+RDMeHg8nA@mail.gmail.com>
 <20190407075123.GA22003@infradead.org>
Message-ID: <20190408152302.GE32498@localhost.localdomain>

On Sun, Apr 07, 2019@12:51:23AM -0700, Christoph Hellwig wrote:
> On Fri, Apr 05, 2019@05:36:32PM -0600, Keith Busch wrote:
> > On Fri, Apr 5, 2019@5:04 PM Jens Axboe <axboe@kernel.dk> wrote:
> > > Looking at current peak testing, I've got around 1.2% in queue enter
> > > and exit. It's definitely not free, hence my question. Probably safe
> > > to assume that we'll double that cycle counter, per IO.
> > 
> > Okay, that's not negligible at all. I don't know of a faster reference
> > than the percpu_ref, but that much overhead would have to rule out
> > having a per hctx counter.
> 
> Can we just replace queue_enter/exit with the per-hctx reference
> entirely?

I don't think that we can readily do that. We still need to protect a
request_queue access prior to selecting the hctx.
