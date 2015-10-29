From: vedant@lath.in (Vedant Lath)
Date: Thu, 29 Oct 2015 22:06:18 +0530
Subject: [PATCH] nvme: prepare support for Apple NVMe controller
In-Reply-To: <20151029151056.GA2580@localhost.localdomain>
References: <bd1f730603ee00205657774a362aab10@localhost>
 <20151029151056.GA2580@localhost.localdomain>
Message-ID: <CAKajsGOy_JjQFvDePw=A1xmP-o_JPoHxE48VvXW5Gsi18gC49A@mail.gmail.com>

Hi Stephan,

Thank you! I am glad to see that Linux support for this SSD is workable.

I have a MacBookAir7,1 (11" Macbook Air (Early 2015)) which uses the
same (or similar) SSD (PCI ID 106b:2001). I am extremely interested to
test the patch on this laptop. Which kernel tree should I apply this
patch on? Can I apply it on stable (4.2.5)?

I had thought it might have been something related to initialising the
controller because lspci showed correctable errors (DevSta: CorrErr+)
on Linux but not on OS X. I also got discouraged because of the
vendor-specific PCI class (018002) instead of the nvme PCI class
(010802) which indicated a non-standard protocol. It's a nice feeling
to know it only requires a quirk to work.

On Thu, Oct 29, 2015@8:40 PM, Jon Derrick <jonathan.derrick@intel.com> wrote:
>> +#define readq lo_hi_readq
>> +#define writeq lo_hi_writeq
>> +
>
> Good job figuring that one out. But this should be a quirk:
> a) It will sacrifice some io cycles on other devices
> b) It may get lost at some point in the name of performance
>
> Christoph recently added a quirks mechanism where I think it would fit
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
