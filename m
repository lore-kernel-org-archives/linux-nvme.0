From: logang@deltatee.com (Logan Gunthorpe)
Date: Fri, 14 Apr 2017 11:30:14 -0600
Subject: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
In-Reply-To: <1492169849.25766.3.camel@kernel.crashing.org>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1491974532.7236.43.camel@kernel.crashing.org>
 <5ac22496-56ec-025d-f153-140001d2a7f9@deltatee.com>
 <1492034124.7236.77.camel@kernel.crashing.org>
 <81888a1e-eb0d-cbbc-dc66-0a09c32e4ea2@deltatee.com>
 <20170413232631.GB24910@bhelgaas-glaptop.roam.corp.google.com>
 <20170414041656.GA30694@obsidianresearch.com>
 <1492169849.25766.3.camel@kernel.crashing.org>
Message-ID: <630c1c63-ff17-1116-e069-2b8f93e50fa2@deltatee.com>



On 14/04/17 05:37 AM, Benjamin Herrenschmidt wrote:
> I object to designing a subsystem that by design cannot work on whole
> categories of architectures out there.

Hardly. That's extreme. We'd design a subsystem that works for the easy
cases and needs more work to support the offset cases. It would not be
designed in such a way that it could _never_ support those
architectures. It would simply be such that it only permits use by the
cases that are known to work. Then those cases could be expanded as time
goes on and people work on adding more support.

There's tons of stuff that needs to be done to get this upstream. I'd
rather not require it to work for every possible architecture from the
start. The testing alone would be impossible. Many subsystems start by
working for x86 first and then adding support in other architectures
later. (Often with that work done by the people who care about those
systems and actually have the hardware to test with.)

Logan
