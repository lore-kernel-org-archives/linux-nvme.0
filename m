From: Alex_Gagniuc@Dellteam.com (Alex_Gagniuc@Dellteam.com)
Date: Sun, 24 Feb 2019 23:27:09 +0000
Subject: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
References: <20190222010502.2434-1-jonathan.derrick@intel.com>
 <CAHk-=wjmjHyovjtzaq=HSegEpiO2SXWaYfJ6qsJrZhXg_YSx5g@mail.gmail.com>
 <2b7d8f45d11c47e69f56ad1bc3324dd1@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wg_e5M0b5aJJf8V_UYaqX12YYA9MEg=gHNp6ALE5fK23w@mail.gmail.com>
Message-ID: <cbe2ed1562a64609be6538f5816ec1b6@ausx13mps321.AMER.DELL.COM>

On 2/24/19 4:42 PM, Linus Torvalds wrote:
> On Sun, Feb 24, 2019@12:37 PM <Alex_Gagniuc@dellteam.com> wrote:
>>
>> Dell r740xd to name one. r640 is even worse -- they probably didn't give
>> me one because I'd have too much stuff to complain about.
>>
>> On the above machines, firmware-first (FFS) tries to guess when there's
>> a SURPRISE!!! removal of a PCIe card and supress any errors reported to
>> the OS. When the OS keeps firing IO over the dead link, FFS doesn't know
>> if it can safely supress the error. It reports is via NMI, and
>> drivers/acpi/apei/ghes.c panics whenever that happens.
> 
> Can we just fix that ghes driver?
> 
> It's not useful to panic just for random reasons. I realize that some
> of the RAS people have the mindset that "hey, I don't know what's
> wrong, so I'd better kill the machine than continue", but that's
> bogus.

That's the first thing I tried, but Borislav didn't like it. And he's 
right in the strictest sense of the ACPI spec: a fatal GHES error must 
result in a machine reboot [1].

> What happens if we just fix that part?

On rx740xd, on a NVMe hotplug bay, the upstream port stops sending 
hotplug interrupts. We could fix that with a quirk by clearing a 
proprietary bit in the switch. However, FFS won't re-arm itself to 
receive any further errors, so we'd never get notified in case there is 
a genuine error.

>> As I see it, there's a more fundamental problem. As long as we accept
>> platforms where firmware does some things first (FFS), we have much less
>> control over what happens. The best we can do is wishy-washy fixes like
>> this one.
> 
> Oh, I agree that platforms with random firmware things are horrid. But
> we've been able to handle them just fine before, without making every
> single possible hotplug pci driver have nasty problems and
> workarounds.
> 
> I suspect we'd be much better off having the ghes driver just not panic.

Keith Busch of Intel at some point suggested remapping all MMIO 
resources of a dead PCIe device to a read-only page that returns all 
F's. Neither of us were too sure how to do that, or how to handle the 
problem of in-flight DMA, which wouldn't hit the page tables.

> What is the actual ghes error? Is it the "unknown, just panic" case,
> or something else?

More like "fatal error, just panic". It looks like this (from a serial 
console):

[   57.680494] {1}[Hardware Error]: Hardware error from APEI Generic 
Hardware Error Source: 1
[   57.680495] {1}[Hardware Error]: event severity: fatal
[   57.680496] {1}[Hardware Error]:  Error 0, type: fatal
[   57.680496] {1}[Hardware Error]:   section_type: PCIe error
[   57.680497] {1}[Hardware Error]:   port_type: 6, downstream switch port
[   57.680498] {1}[Hardware Error]:   version: 3.0
[   57.680498] {1}[Hardware Error]:   command: 0x0407, status: 0x0010
[   57.680499] {1}[Hardware Error]:   device_id: 0000:3c:07.0
[   57.680499] {1}[Hardware Error]:   slot: 1
[   57.680500] {1}[Hardware Error]:   secondary_bus: 0x40
[   57.680500] {1}[Hardware Error]:   vendor_id: 0x10b5, device_id: 0x9733
[   57.680501] {1}[Hardware Error]:   class_code: 000406
[   57.680502] {1}[Hardware Error]:   bridge: secondary_status: 0x0000, 
control: 0x0003
[   57.680503] Kernel panic - not syncing: Fatal hardware error!
[   57.680572] Kernel Offset: 0x2a000000 from 0xffffffff81000000 
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)


Alex



[1] ACPI 6.3 - 18.1 Hardware Errors and Error Sources

"A fatal hardware error is an uncorrected or uncontained error condition 
that is determined to be unrecoverable by the hardware. When a fatal 
uncorrected error occurs, the system is restarted to prevent propagation 
of the error."
