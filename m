From: muhlemmer@gmail.com (Tim Mohlmann)
Date: Tue, 29 Mar 2016 19:52:30 +0300
Subject: nvme device timeout
In-Reply-To: <20160329144241.GA2396@linux.intel.com>
References: <CAHOCc18wCgprYh1k0m0ow1FhU51J-1JN-X2Fj-8VKHDVi-Zo9Q@mail.gmail.com>
 <20160328172423.GA22481@localhost.localdomain>
 <36E8D38D6B771A4BBDB1C0D800158A51865EF73D@SSIEXCH-MB3.ssi.samsung.com>
 <20160328225411.GB27195@localhost.localdomain>
 <20160329070328.GA8910@infradead.org>
 <36E8D38D6B771A4BBDB1C0D800158A51865EFB85@SSIEXCH-MB3.ssi.samsung.com>
 <20160329110659.GA10015@infradead.org>
 <20160329144241.GA2396@linux.intel.com>
Message-ID: <56FAB2CE.6060405@gmail.com>



On 03/29/2016 05:42 PM, Matthew Wilcox wrote:

> 
> I doubt it's the controller.  Usually it's ACPI or how the PCI bridge
> got wired up.
> 

This can be an issue, yes. This is a new laptop, based on the intel
skylake platform. Since I got it a month ago I was walking trough kernel
version to get everything (display, network, sound etc) working.

At kernel version 4.4 nvme stopped to work in UEFI mode and in kernel
4.5 it stopped to work completely. You will probably not be suprised if
I told you that I have ACPI problems too, but they where of a less
priority on my list. Eg: battery information missing and poweroff not
working.

In my original mail I attached a dmesg output. There are also some ACPI
table errors in that. Maybe you want to look at it? I'm willing run a
bug report at kernel.org for ACPI, but I wouldn't know where to start.
It would be fuzzy to open a report saying: some things are not working
