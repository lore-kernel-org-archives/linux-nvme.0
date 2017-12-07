From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 6 Dec 2017 16:00:29 -0800
Subject: When will Linux support new RAID controllers
In-Reply-To: <CAGRSmLto7dG19zgUkdZjuhacWXo=ju6WdS0YVjC5xOOsGjV9kg@mail.gmail.com>
References: <CAGRSmLs-Hr+FFfa4_29kidEeL2d7b+cEP6u1OkOUoYW6Cm15BA@mail.gmail.com>
 <20171110131937.GA26181@infradead.org>
 <CAKKYfmEqw48mjBsKoy=qeny6B1X8PKytSN4UwpvSupo87746kg@mail.gmail.com>
 <CAGRSmLsvAR6wth7tPd5J2kAydy64uQ+h45Yu-SUeOAHkfOHXHA@mail.gmail.com>
 <CAGRSmLto7dG19zgUkdZjuhacWXo=ju6WdS0YVjC5xOOsGjV9kg@mail.gmail.com>
Message-ID: <20171207000029.GA2725@infradead.org>

I guess poor Dan got a gag order from the people responsible for this
mess at Intel or something, as he's usually quick to reply and very
helpful.

On Mon, Dec 04, 2017@06:01:10PM -0800, David F. wrote:
> Hi,
> 
> Any word if the patch is available?
> 
> Is this going mainline anytime soon?
> 
> 
> On Fri, Nov 10, 2017@11:06 AM, David F. <df7729@gmail.com> wrote:
> > A patch would be great.  There has been several cases where no option
> > to use AHCI mode available, or where a box seller would offer Linux as
> > an alternate boot option against Windows in RAID mode (on the mobo)
> > but could no longer provide Linux with their systems (without
> > additional costs for add-in raid controller).
> >
> > On Fri, Nov 10, 2017@5:31 AM, Dennis Mungai <dmngaie@gmail.com> wrote:
> >> That feature would be especially important on systems where the
> >> BIOS/UEFI environment offers no option to toggle back the AHCI mode.
> >> This "RAID" Intel features is also known as "Intel Premium RST mode"
> >> on all current Clevo systems, and on such a platform (the Clevo
> >> P751DM2-G, marketed by the likes of Schenker and Origin PC) is based
> >> on this platform.
> >>
> >> -Dennis.
> >>
> >> On 10 November 2017@16:19, Christoph Hellwig <hch@infradead.org> wrote:
> >>> On Thu, Nov 09, 2017@10:24:54AM -0800, David F. wrote:
> >>>> It seems that Linux will not see any HD on Intel's 100 Series or newer
> >>>> chipsets (Z170, etc.) when in RAID mode.  (typically these systems
> >>>> have M2 NVMe devices ). This is problematic when wanting to use Linux
> >>>> on the system without having to disable RAID and when on their with
> >>>> Windows.   Maybe not a linux-raid issue, but is Linux RAID issue
> >>>> within the kernel device support.
> >>>
> >>> Dan (on Cc) posted some patches to support the awkwared so called
> >>> "RAID" mode (it really should be Intel landgrab mode) in the client
> >>> chipsets more than a year ago.
> >>>
> >>> It needed a bit of a rework to be present as a fake PCIe root port
> >>> instead of the platform driver magic, so I wonder what happened to
> >>> it - Dan any chance to get back to it?
> >>>
> >>> _______________________________________________
> >>> Linux-nvme mailing list
> >>> Linux-nvme at lists.infradead.org
> >>> http://lists.infradead.org/mailman/listinfo/linux-nvme
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
---end quoted text---
