From: keith.busch@gmail.com (Keith Busch)
Date: Fri, 5 Apr 2019 17:36:32 -0600
Subject: [PATCH] blk-mq: Wait for for hctx requests on CPU unplug
In-Reply-To: <d4a4b6c0-3ea8-f748-85b0-6b39c5023a6f@kernel.dk>
References: <20190405215920.27085-1-keith.busch@intel.com>
 <226503cd-53ac-902c-7944-b2748407b1d3@kernel.dk>
 <20190405223719.GC25081@localhost.localdomain>
 <d4a4b6c0-3ea8-f748-85b0-6b39c5023a6f@kernel.dk>
Message-ID: <CAOSXXT7V3E2j_Ut=hJ2X3QcdLwuWGRFtgzTs4iTe+RDMeHg8nA@mail.gmail.com>

On Fri, Apr 5, 2019@5:04 PM Jens Axboe <axboe@kernel.dk> wrote:
> Looking at current peak testing, I've got around 1.2% in queue enter
> and exit. It's definitely not free, hence my question. Probably safe
> to assume that we'll double that cycle counter, per IO.

Okay, that's not negligible at all. I don't know of a faster reference
than the percpu_ref, but that much overhead would have to rule out
having a per hctx counter.
