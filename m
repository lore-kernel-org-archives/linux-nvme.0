From: Alex_Gagniuc@Dellteam.com (Alex_Gagniuc@Dellteam.com)
Date: Sun, 24 Feb 2019 20:37:30 +0000
Subject: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
References: <20190222010502.2434-1-jonathan.derrick@intel.com>
 <CAHk-=wjmjHyovjtzaq=HSegEpiO2SXWaYfJ6qsJrZhXg_YSx5g@mail.gmail.com>
Message-ID: <2b7d8f45d11c47e69f56ad1bc3324dd1@ausx13mps321.AMER.DELL.COM>

On 2/22/19 3:29 PM, Linus Torvalds wrote:
> On Thu, Feb 21, 2019@5:07 PM Jon Derrick <jonathan.derrick@intel.com> wrote:
>>
>> Some platforms don't seem to easily tolerate non-posted mmio reads on
>> lost (hot removed) devices. This has been noted in previous
>> modifications to other layers where an mmio read to a lost device could
>> cause an undesired firmware intervention [1][2].
> 
> This is broken, and whatever platform that requires this is broken.
> 
> This has absolutely nothing to do with nvme, and should not be handled
> by a driver.
> 
> The platform code should be fixed.
> 
> What broken platform is this, and why is it causing problems?
> 
> None of this wishy-washy "some platforms". Name them, and let's get them fixed.

Dell r740xd to name one. r640 is even worse -- they probably didn't give 
me one because I'd have too much stuff to complain about.

On the above machines, firmware-first (FFS) tries to guess when there's 
a SURPRISE!!! removal of a PCIe card and supress any errors reported to 
the OS. When the OS keeps firing IO over the dead link, FFS doesn't know 
if it can safely supress the error. It reports is via NMI, and
drivers/acpi/apei/ghes.c panics whenever that happens.

Does this sound like horrible code?

As I see it, there's a more fundamental problem. As long as we accept 
platforms where firmware does some things first (FFS), we have much less 
control over what happens. The best we can do is wishy-washy fixes like 
this one.

Did I mention that FFS's explicit intent on the above machines is to 
make the OS crash?

Alex
