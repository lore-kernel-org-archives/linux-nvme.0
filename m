From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 18 Jul 2019 15:27:29 +1000
Subject: Duplicate tag error with 5.2
In-Reply-To: <ee8eb3c8855942eb22391dd6137f3b969abce303.camel@kernel.crashing.org>
References: <0007d555cf4586c4ae43fdca66766b6b11863078.camel@kernel.crashing.org>
 <dbb6572c3d0b8ad1f20fd5f89ee112995676375b.camel@kernel.crashing.org>
 <6e4b08daaa0482bd863b63cc5a85fa58ed871045.camel@kernel.crashing.org>
 <CAOSXXT6Z=zEpWqac2k1ydk2LynAEtFr-4jXJVCtTa5yn8H7f3Q@mail.gmail.com>
 <ee8eb3c8855942eb22391dd6137f3b969abce303.camel@kernel.crashing.org>
Message-ID: <f5de042adc383df7cb040859f13ce92412977467.camel@kernel.crashing.org>

On Thu, 2019-07-18@14:53 +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2019-07-18@12:58 +0900, Keith Busch wrote:
> > It doesn't look possible to reuse an active tag on the same queue,
> > but we can have duplicate tags on different hardware queues. Could
> > you the queue ID in addition to the tag in the prints?
> 
> There's only one IO queue on this, and my testing is on qid 1 only.
> 
> That said, I wonder whether we have a different issue that's indirectly
> causing this...
> 
> I noticed the qdepth is strange ... 129. That doesn't look right to me.
> I wonder if Apple is not properly 0-basing the capability, and thus as
> a result, we might get bogus completions or something like this.
> 
> I'll dig a bit more.

Actually the original printk's ignored the qid. I have a theory, trying
to test it now.

The problem tends to happens around when smartd starts. I wonder if the
Apple drive is assuming a unique tag set accross both IO and admin
queue...

I'll do more digging.

Cheers,
Ben.
