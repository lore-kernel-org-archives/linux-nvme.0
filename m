From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 18 Sep 2017 09:05:12 -0700
Subject: [PATCH v2] nvmet: implement valid sqhd values in completions
In-Reply-To: <14692960-9fed-2d6a-28bb-16e98f28fce6@gmail.com>
References: <20170914175810.13011-1-jsmart2021@gmail.com>
 <e554b8fc-4045-eef0-44fe-ef707955bff7@mellanox.com>
 <14692960-9fed-2d6a-28bb-16e98f28fce6@gmail.com>
Message-ID: <20170918160512.GA19805@infradead.org>

On Mon, Sep 18, 2017@09:00:32AM -0700, James Smart wrote:
> I think the likely statement is erroneous. In order to get to this point the
> transport has to call nvmet_req_init(), and the first thing it does is
> assign the sq and there's never an unset. So any completion of the routine,
> even if failure to nvmet_req_init() has sq set.  There's also several other
> cases in nvmet_req_init() where if the transport set it to NULL an oops
> would occur.

That seems to be the case now - this check and comment looks like a
leftover from earlier versions where this wasn't the case.

> I'll send a revised patch that also removes the "if (likely())" test.

Yes, please do.
