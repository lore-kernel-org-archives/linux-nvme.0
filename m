From: yogi43222@gmail.com (Yogi Wannabe)
Date: Fri, 8 Dec 2017 10:16:29 -0800
Subject: AER reporting on NVME board
Message-ID: <CAGSHeY02rf7ABWkP7=HnFUsyqbTOYztVemv-7nmwErEK2dXVNw@mail.gmail.com>

Hi,

I'm running Ubuntu 16.10 desktop with Kernel 4.8.0-22-generic. I'm
trying to enable PCI AER reporting.

/boot/config-`uname -r` shows

CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_PCIAER=y
CONFIG_PCIEPORTBUS=y

so clearly AER reporting has been enabled. Yet in dmesg I see this:

acpi PNP0A08: _OSC: platform does not support [AER]

I have tried this on several systems with different SuperMicro
motherboards and I see the same message. I don't see any BIOS settings
for AER configuration.

I know this is not a NVME driver issue, but I have not been able to
resolve this even after posting to other forums so I'm hoping some
here can point me in the right direction.

TIA
