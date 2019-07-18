From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 18 Jul 2019 16:00:48 +1000
Subject: Duplicate tag error with 5.2
In-Reply-To: <f5de042adc383df7cb040859f13ce92412977467.camel@kernel.crashing.org>
References: <0007d555cf4586c4ae43fdca66766b6b11863078.camel@kernel.crashing.org>
 <dbb6572c3d0b8ad1f20fd5f89ee112995676375b.camel@kernel.crashing.org>
 <6e4b08daaa0482bd863b63cc5a85fa58ed871045.camel@kernel.crashing.org>
 <CAOSXXT6Z=zEpWqac2k1ydk2LynAEtFr-4jXJVCtTa5yn8H7f3Q@mail.gmail.com>
 <ee8eb3c8855942eb22391dd6137f3b969abce303.camel@kernel.crashing.org>
 <f5de042adc383df7cb040859f13ce92412977467.camel@kernel.crashing.org>
Message-ID: <8936e370b7ae272c8810780ee26ae3cebc8525b9.camel@kernel.crashing.org>

On Thu, 2019-07-18@15:27 +1000, Benjamin Herrenschmidt wrote:
> 
> Actually the original printk's ignored the qid. I have a theory, trying
> to test it now.
> 
> The problem tends to happens around when smartd starts. I wonder if the
> Apple drive is assuming a unique tag set accross both IO and admin
> queue...
> 
> I'll do more digging.

Ok. I think that's it.

I reduced the IO queue to 4 entries (3 usable) and the admin queue to 6
(4 usable), and added printk's of submitted and completed tags.

I can trigger the problem easily now running smartctl -c /dev/nvme0n1
and doing a bit of IOs. It seems to happen when the IO and Admin queue
use the same tag.

I verified after the crash, going to MacOS and getting the log from the
T2 chip, that the tag it complains about *is* the one that we happened
to have used accross both queues at the point where it dies.

Now, I am not that familiar with the tag management/allocation code,
how hard would it be to split the tags accross the queues ? I suppose I
could easily add a quirk to do +32 to the tags used on the IO queue...

(Provided they support arbitrary sized tags up to 16 bits).

Cheers,
Ben.
