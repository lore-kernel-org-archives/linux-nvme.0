From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 19 Jul 2019 11:34:17 +1000
Subject: Duplicate tag error with 5.2
In-Reply-To: <BYAPR04MB58166A99868B66ABB31CB0DDE7CB0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <0007d555cf4586c4ae43fdca66766b6b11863078.camel@kernel.crashing.org>
 <dbb6572c3d0b8ad1f20fd5f89ee112995676375b.camel@kernel.crashing.org>
 <6e4b08daaa0482bd863b63cc5a85fa58ed871045.camel@kernel.crashing.org>
 <CAOSXXT6Z=zEpWqac2k1ydk2LynAEtFr-4jXJVCtTa5yn8H7f3Q@mail.gmail.com>
 <ee8eb3c8855942eb22391dd6137f3b969abce303.camel@kernel.crashing.org>
 <f5de042adc383df7cb040859f13ce92412977467.camel@kernel.crashing.org>
 <8936e370b7ae272c8810780ee26ae3cebc8525b9.camel@kernel.crashing.org>
 <BYAPR04MB58169C5A4EF8DFB10C5C2148E7C80@BYAPR04MB5816.namprd04.prod.outlook.com>
 <c7235187d44618bc6636da0968c8037aebf50742.camel@kernel.crashing.org>
 <BYAPR04MB581667EE6FB45D86881529E2E7CB0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <50c35ab3db7745875476c0966bf191ab42de4dd1.camel@kernel.crashing.org>
 <BYAPR04MB58163BC85D7A5351BC053D43E7CB0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <5f29b93ba4bf2f7bd8b0a77bc5f82f4cbb9e8f98.camel@kernel.crashing.org>
 <BYAPR04MB58167459AA9933C66694C2D2E7CB0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <62f188398528c74cfa8352a8cf8a7e3bce50307b.camel@kernel.crashing.org>
 <BYAPR04MB58166A99868B66ABB31CB0DDE7CB0@BYAPR04MB5816.namprd04.prod.outlook.com>
Message-ID: <817740cb3c59f82afab3a361045d05d21618a924.camel@kernel.crashing.org>

On Fri, 2019-07-19@01:24 +0000, Damien Le Moal wrote:
> > No, I think the problem is that Apple implementation (which as I said
> > is just a bit of SW running off the PCIe slave bit of the T2 chip, on
> > the ARM core), somewhat uses the tags we provide for internal tracking,
> > and they don't append the qid to them, so internally they assume all
> > tags are unique regardless of what queue they come from. It's crazy but
> > that seem to be what they did.
> 
> OK. So the device essentially operates with a shared tagset across all queues..
> And indeed that does not play well with Linux driver. Looking at the code,
> having the admin queue and io queues share the same tagset would be the cleanest
> fix, but that would also mean essentially rewriting completely pci.c and
> implementing an "apple.c" host driver :)

Yeah, that's why my approach, while sub-optimal (I have to shrink the
IO queue) is the simplest, I just "offset" the IO queue tag space to
avoid overlaps. The offset is basically the patch I posted yesterday,
just with another hack missing I'll send later to also shrink the queue
to the resulting tags don't go over 127.

Cheers,
Ben.
