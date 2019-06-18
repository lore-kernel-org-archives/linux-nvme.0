From: hare@suse.de (Hannes Reinecke)
Date: Tue, 18 Jun 2019 09:46:48 +0200
Subject: [PATCH] PCI: Add Intel remapped NVMe device support
In-Reply-To: <CAD8Lp47Vu=w+Lj77_vL05JYV1WMog9WX3FHGE+TseFrhcLoTuA@mail.gmail.com>
References: <20190610074456.2761-1-drake@endlessm.com>
 <CAOSXXT7OFzHeTxNqZ1sS6giRxhDcrUUnVjURWBiFUc5T_8p=MA@mail.gmail.com>
 <CAD8Lp45djPU_Ur8uCO2Y5Sbek_5N9QKkxLXdKNVcvkr6rFPLUQ@mail.gmail.com>
 <CAOSXXT7H6HxY-za66Tr9ybRQyHsTdwwAgk9O2F=xK42MT8HsuA@mail.gmail.com>
 <20190613085402.GC13442@lst.de>
 <CAD8Lp47Vu=w+Lj77_vL05JYV1WMog9WX3FHGE+TseFrhcLoTuA@mail.gmail.com>
Message-ID: <06c38b3e-603b-5bae-4959-9965ab40db62@suse.de>

On 6/14/19 4:26 AM, Daniel Drake wrote:
> On Thu, Jun 13, 2019@4:54 PM Christoph Hellwig <hch@lst.de> wrote:
>> So until we get very clear and good documentation from Intel on that
>> I don't think any form of upstream support will fly.  And given that
>> Dan who submitted the original patch can't even talk about this thing
>> any more and apparently got a gag order doesn't really give me confidence
>> any of this will ever work.
> 
> I realise the architecture here seems badly thought out, and the lack
> of a decent spec makes the situation worse, but I'd encourage you to
> reconsider this from the perspectives of:
>  - Are the patches really more ugly than the underlying architecture?
>  - We strive to make Linux work well on common platforms and sometimes
> have to accept that hardware vendors do questionable things & do not
> fully cooperate
>  - It works out of the box on Windows
> 
Actually, there _is_ a register description:

https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/300-series-chipset-pch-datasheet-vol-2.pdf

Look for section 15: Intel RST for PCIe Storage.

That gives you a reasonable description of the various registers etc.
You'll have to translate from Intel-speak, but that should be manageable.

In general, I am _quite_ in favour of having Linux Support for these
kind of devices.
I fully agree the interface is ugly, and badly thought out.
But these devices exist and have been sold for quite some time now, so
there is no way we can influence the design on those boxes.

And we really have come a long way from the the original Linux idea of
"hey, that's weird hardware, let's hack together a driver for it" to the
flat rejection of hardware we don't like.
I, for one, prefer the old way.

Looking at the spec I think that Daniels approach of exposing an
additional PCI device is the correct way of going about it (as the
interface design can be thought of a messed-up SR-IOV interface), but
I'll defer to Bjorn here.
But we really should have a driver to get these boxes rolling.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
