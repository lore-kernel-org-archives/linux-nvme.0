From: guenther@tum.de (Stephan =?utf-8?Q?G=C3=BCnther?=)
Date: Thu, 29 Oct 2015 18:59:12 +0100
Subject: [PATCH] nvme: prepare support for Apple NVMe controller
In-Reply-To: <CAKajsGOy_JjQFvDePw=A1xmP-o_JPoHxE48VvXW5Gsi18gC49A@mail.gmail.com>
References: <bd1f730603ee00205657774a362aab10@localhost>
 <20151029151056.GA2580@localhost.localdomain>
 <CAKajsGOy_JjQFvDePw=A1xmP-o_JPoHxE48VvXW5Gsi18gC49A@mail.gmail.com>
Message-ID: <aa2cd8baee2f28f08559aef8be46bac0@localhost>

On 2015/October/29 10:06, Vedant Lath wrote:
> Hi Stephan,
> 
> Thank you! I am glad to see that Linux support for this SSD is workable.
> 
> I have a MacBookAir7,1 (11" Macbook Air (Early 2015)) which uses the
> same (or similar) SSD (PCI ID 106b:2001). I am extremely interested to

You are right, the latest 11" MacBook Air presumably uses the same
controller.

> test the patch on this laptop. Which kernel tree should I apply this
> patch on? Can I apply it on stable (4.2.5)?

I tested against 4.3-rc7. However, since the patch consits of 2 lines it 
is very likely that it it also applies to older kernels.

> 
> I had thought it might have been something related to initialising the
> controller because lspci showed correctable errors (DevSta: CorrErr+)
> on Linux but not on OS X. I also got discouraged because of the
> vendor-specific PCI class (018002) instead of the nvme PCI class
> (010802) which indicated a non-standard protocol. It's a nice feeling
> to know it only requires a quirk to work.

Do not forget to bind it manually. And there is still a long way, at 
least for the MacBook8,1 as there is still no clue why the internal 
keyboard is not working...

> 
> On Thu, Oct 29, 2015@8:40 PM, Jon Derrick <jonathan.derrick@intel.com> wrote:
> >> +#define readq lo_hi_readq
> >> +#define writeq lo_hi_writeq
> >> +
> >
> > Good job figuring that one out. But this should be a quirk:
> > a) It will sacrifice some io cycles on other devices
> > b) It may get lost at some point in the name of performance
> >
> > Christoph recently added a quirks mechanism where I think it would fit
> >
> > _______________________________________________
> > Linux-nvme mailing list
> > Linux-nvme at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-nvme
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
