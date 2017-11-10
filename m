From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 10 Nov 2017 05:19:37 -0800
Subject: When will Linux support new RAID controllers
In-Reply-To: <CAGRSmLs-Hr+FFfa4_29kidEeL2d7b+cEP6u1OkOUoYW6Cm15BA@mail.gmail.com>
References: <CAGRSmLs-Hr+FFfa4_29kidEeL2d7b+cEP6u1OkOUoYW6Cm15BA@mail.gmail.com>
Message-ID: <20171110131937.GA26181@infradead.org>

On Thu, Nov 09, 2017@10:24:54AM -0800, David F. wrote:
> It seems that Linux will not see any HD on Intel's 100 Series or newer
> chipsets (Z170, etc.) when in RAID mode.  (typically these systems
> have M2 NVMe devices ). This is problematic when wanting to use Linux
> on the system without having to disable RAID and when on their with
> Windows.   Maybe not a linux-raid issue, but is Linux RAID issue
> within the kernel device support.

Dan (on Cc) posted some patches to support the awkwared so called
"RAID" mode (it really should be Intel landgrab mode) in the client
chipsets more than a year ago.

It needed a bit of a rework to be present as a fake PCIe root port
instead of the platform driver magic, so I wonder what happened to
it - Dan any chance to get back to it?
