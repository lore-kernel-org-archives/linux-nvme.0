From: mike@fireburn.co.uk (Mike Lothian)
Date: Sun, 7 Feb 2016 16:43:35 +0000
Subject: NVME Issues with Suspend
In-Reply-To: <CAHbf0-GDmbx3xO+Kmb8y8X-41TxnaetQ=k4FR-NonMZoL-U2UA@mail.gmail.com>
References: <CAHbf0-GSRV+SH4FvDj8_gfLFjEO+_KUBXZQ2VKjrFzszwcY-ww@mail.gmail.com>
 <CAHbf0-GDmbx3xO+Kmb8y8X-41TxnaetQ=k4FR-NonMZoL-U2UA@mail.gmail.com>
Message-ID: <CAHbf0-GWxOd2E+yPu9L_EXYHfJ_7C02=ybXYwkHnCw_6dPzj4A@mail.gmail.com>

Hi

I just thought I'd pop in an update

I've just managed to fix this by changing my PCIe options in my kernel config

The problem showed up with:

[*] PCI support

      ? ?
 ? ?
           [*]   Support mmconfig PCI config space access

                 ? ?
 ? ?
           [*]   PCI Express Port Bus support

                 ? ?
 ? ?
           [*]     PCI Express Hotplug driver

                 ? ?
 ? ?
           [*]     Root Port Advanced Error Reporting support

                 ? ?
 ? ?
           [*]       PCI Express ECRC settings control

                 ? ?
 ? ?
           < >       PCIe AER error injector support

                 ? ?
 ? ?
           -*-     PCI Express ASPM control

                 ? ?
 ? ?
           [ ]       Debug PCI Express ASPM

                 ? ?
 ? ?
                     Default ASPM policy (BIOS default)  --->

                 ? ?
 ? ?
           [*]   Message Signaled Interrupts (MSI and MSI-X)

                 ? ?
 ? ?
           [ ]   PCI Debugging

                 ? ?
 ? ?
           [*]   Enable PCI resource re-allocation detection

                 ? ?
 ? ?
           < >   PCI Stub driver

                 ? ?
 ? ?
           [*]   Interrupts on hypertransport devices

                 ? ?
 ? ?
           [ ] PCI IOV support

                 ? ?
 ? ?
           [*] PCI PRI support

                 ? ?
 ? ?
           -*- PCI PASID support

                 ? ?
 ? ?
               PCI host controller drivers  ----

                 ? ?
 ? ?
           < > PCCard (PCMCIA/CardBus) support  ----

                 ? ?
 ? ?
           [*] Support for PCI Hotplug  --->

                 ? ?
 ? ?
           < > RapidIO support

                 ? ?


This is what I have now:

[*] PCI support

      ? ?
 ? ?
           [*]   Support mmconfig PCI config space access

                 ? ?
 ? ?
           [*]   PCI Express Port Bus support

                 ? ?
 ? ?
           [ ]     Root Port Advanced Error Reporting support

                 ? ?
 ? ?
           -*-     PCI Express ASPM control

                 ? ?
 ? ?
           [ ]       Debug PCI Express ASPM

                 ? ?
 ? ?
                     Default ASPM policy (BIOS default)  --->

                 ? ?
 ? ?
           [*]   Message Signaled Interrupts (MSI and MSI-X)

                 ? ?
 ? ?
           [*]   PCI Debugging

                 ? ?
 ? ?
           [ ]   Enable PCI resource re-allocation detection

                 ? ?
 ? ?
           < >   PCI Stub driver

                 ? ?
 ? ?
           [*]   Interrupts on hypertransport devices

                 ? ?
 ? ?
           [ ] PCI IOV support

                 ? ?
 ? ?
           [ ] PCI PRI support

                 ? ?
 ? ?
           [ ] PCI PASID support

                 ? ?
 ? ?
               PCI host controller drivers  ----

                 ? ?
 ? ?
           < > PCCard (PCMCIA/CardBus) support  ----

                 ? ?
 ? ?
           [ ] Support for PCI Hotplug  ----

                 ? ?
 ? ?
           < > RapidIO support

So I guess the problem probably lies either in the PCIe subsystem or
something it interacts with in the "bios"

On 25 January 2016@01:30, Mike Lothian <mike@fireburn.co.uk> wrote:
> Hi
>
> I managed to capture the dmesg by copying the dmesg and sync binaries
> to a usb disk and executing and writing to there after the suspend
>
> I hope this helps in some way and I'll happily raise a proper bug if
> you tell me which product / component I should use for nvme
>
> I also tried disabling IOMMU but that had no affect
>
> Cheers
>
> Mike
>
> On 23 January 2016@17:02, Mike Lothian <mike@fireburn.co.uk> wrote:
>> Hi
>>
>> I currently have a 3 partition NVME setup, however when I suspend and
>> resume my laptop the drive isn't re-initialised correctly, the console
>> is filled with access errors and I can't run any commands as they
>> can't be found. After hard rebooting my machine sometimes it can't
>> find the GPD partition and I have to use testdisk to restore the
>> partition table
>>
>> I have an Alienware 15 laptop with a 1TB NVME harddisk running kernel
>> 4.5-rc0. As I don't suspend my laptop often I'm not sure if this is a
>> regression brought in from the merge window or an existing issue
>>
>> I can bisect if needed
>>
>> 3e:00.0 Non-Volatile memory controller [0108]: Samsung Electronics Co
>> Ltd Device [144d:a802] (rev 01)
>>        Subsystem: Samsung Electronics Co Ltd Device a801
>>        Kernel driver in use: nvme
>>
>> [    1.050096]  nvme0n1: p1 p2 p3
>>
>> I was going to submit a bug on bugzilla.kernel.org but I wasn't sure
>> which Product / Component it should be filed under
>>
>> I haven't figured out a good way of collecting logs when the system
>> stops responding so please let me know if you know how I can collect
>> logs - I don't think SSH sessions survive suspend / resume cycles
>>
>> Thanks
>>
>> Mike
