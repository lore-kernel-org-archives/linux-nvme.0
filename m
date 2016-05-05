From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 5 May 2016 07:11:18 -0700
Subject: RFC: what to do about abort?
In-Reply-To: <B58D82457FDA0744A320A2FC5AC253B93D57C119@fmsmsx104.amr.corp.intel.com>
References: <20160504100313.GA22726@infradead.org> <5729CCC9.9060307@suse.de>
 <20160504105815.GA20848@infradead.org>
 <B58D82457FDA0744A320A2FC5AC253B93D57C119@fmsmsx104.amr.corp.intel.com>
Message-ID: <20160505141118.GA5260@infradead.org>

On Wed, May 04, 2016@02:59:11PM +0000, Busch, Keith wrote:
> That's an unfortunate way to the spec describes this command. All my
> controllers immediately post success status with the CQE's DWORD0 set
> to 0;abort is essentially a no-op.

That's one of the most common behaviors instead.

> Even though it's a no-op for me, the main benefit is that abort makes
> for an awesome trigger for analyzers and firmware. It's been a valuable
> tool for debugging issues, and I'd hate to lose it.

You're the maintainer, so it's up to you - it just doesn't seem very
useful to me from both the host and device perspectice.

> Can we propose changing the spec instead?

Good luck changing existing NVMe behavior.  We could probably introduce
an optional well defined abort, but I'm not sure lots of vendors would
even bother to implement it unless there is a hard requirement for it.
