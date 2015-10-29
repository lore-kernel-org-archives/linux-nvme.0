From: guenther@tum.de (Stephan =?utf-8?Q?G=C3=BCnther?=)
Date: Thu, 29 Oct 2015 20:46:38 +0100
Subject: [PATCH] nvme: prepare support for Apple NVMe controller
In-Reply-To: <20151029151056.GA2580@localhost.localdomain>
References: <bd1f730603ee00205657774a362aab10@localhost>
 <20151029151056.GA2580@localhost.localdomain>
Message-ID: <1765c91018bf3b7840ce79d9b51762e8@localhost>

On 2015/October/29 09:10, Jon Derrick wrote:
> > +#define readq lo_hi_readq
> > +#define writeq lo_hi_writeq
> > +
> 
> Good job figuring that one out. But this should be a quirk:
> a) It will sacrifice some io cycles on other devices
> b) It may get lost at some point in the name of performance

Yep.

> 
> Christoph recently added a quirks mechanism where I think it would fit

To be honest we don't know what mechanism you are referring to. Please 
give us pointer.


I assume that we concur that this workaround--as well as making the nvme 
driver claim the Apple controller--should be a runtime-decisions based 
on the device id. That avoids both penalties in terms of cpu cycles and 
the tedious manual binding.

How to do that sanely is a bit unclear to me. Detection at runtime would 
require that

1) the nvme driver attempts to bind to non-nvme devices (pci class 
018002),

2) checks whether or not that is Apples special controller (106b 2001), 
and in that case

3) binds to the device while using ordered split writes on 64bit 
platforms, which probably requires a set of function pointers to 
low-level ops.


Another approach might be to write an intermediate driver that relies on 
the nvme driver but encapsulates the remaining stuff.


If Apple's controller is expected to be the only exception, the latter 
approach would make sense. But I don't believe that Apple builds the 
only custom nvme controller that is "almost" compatible. (assuming that 
018002 instead of 010802 isn't a typo anyways).


Best,
Stephan
