From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 8 May 2016 02:04:06 -0700
Subject: RFC: what to do about abort?
In-Reply-To: <20160505215633.GF8503@localhost.localdomain>
References: <20160504100313.GA22726@infradead.org> <5729CCC9.9060307@suse.de>
 <20160504105815.GA20848@infradead.org>
 <B58D82457FDA0744A320A2FC5AC253B93D57C119@fmsmsx104.amr.corp.intel.com>
 <20160505141118.GA5260@infradead.org>
 <20160505215633.GF8503@localhost.localdomain>
Message-ID: <20160508090406.GA27077@infradead.org>

On Thu, May 05, 2016@05:56:33PM -0400, Keith Busch wrote:
> If you don't find a deterministic event on failure to be useful for the
> device side, you must have better visibility into your internal device
> state than most others do. :)

I get a deterministic error: the controller reset.

> The spec so badly defines abort, though, I have to agree you're right
> to remove it. Since having a dependable event greatly helps debugging
> field issues when device makers desperately want to blame the driver
> for command timeouts, does it sound okay to have a module param toggle
> its use, defaulting to off?

Let's just keep it.  I don't think it's helpful, but it's not that bad
that we have to get rid of it.
