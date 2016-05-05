From: keith.busch@intel.com (Keith Busch)
Date: Thu, 5 May 2016 17:56:33 -0400
Subject: RFC: what to do about abort?
In-Reply-To: <20160505141118.GA5260@infradead.org>
References: <20160504100313.GA22726@infradead.org> <5729CCC9.9060307@suse.de>
 <20160504105815.GA20848@infradead.org>
 <B58D82457FDA0744A320A2FC5AC253B93D57C119@fmsmsx104.amr.corp.intel.com>
 <20160505141118.GA5260@infradead.org>
Message-ID: <20160505215633.GF8503@localhost.localdomain>

On Thu, May 05, 2016@07:11:18AM -0700, Christoph Hellwig wrote:
> You're the maintainer, so it's up to you - it just doesn't seem very
> useful to me from both the host and device perspectice.

If you don't find a deterministic event on failure to be useful for the
device side, you must have better visibility into your internal device
state than most others do. :)

The spec so badly defines abort, though, I have to agree you're right
to remove it. Since having a dependable event greatly helps debugging
field issues when device makers desperately want to blame the driver
for command timeouts, does it sound okay to have a module param toggle
its use, defaulting to off?
