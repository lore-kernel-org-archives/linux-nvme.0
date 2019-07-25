From: rafael@kernel.org (Rafael J. Wysocki)
Date: Thu, 25 Jul 2019 19:03:49 +0200
Subject: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
In-Reply-To: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
References: <2332799.izEFUvJP67@kreacher>
 <E62786E4-5DA9-4542-899A-658D0E021190@canonical.com>
 <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
Message-ID: <CAJZ5v0iDQ4=kTUgW94tKGt7oJzA_3uVU_M6HAMbNCRXwp_do8A@mail.gmail.com>

On Thu, Jul 25, 2019@6:24 PM <Mario.Limonciello@dell.com> wrote:
>
> +Rajat
>
> > -----Original Message-----
> > From: Kai-Heng Feng <kai.heng.feng at canonical.com>
> > Sent: Thursday, July 25, 2019 9:03 AM
> > To: Rafael J. Wysocki
> > Cc: Keith Busch; Christoph Hellwig; Sagi Grimberg; linux-
> > nvme at lists.infradead.org; Limonciello, Mario; Linux PM; LKML
> > Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for
> > suspend" has problems
> >
> >
> > [EXTERNAL EMAIL]
> >
> > Hi Rafael,
> >
> >@17:51, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > > Hi Keith,
> > >
> > > Unfortunately,
> > >
> > > commit d916b1be94b6dc8d293abed2451f3062f6af7551
> > > Author: Keith Busch <keith.busch at intel.com>
> > > Date:   Thu May 23 09:27:35 2019 -0600
> > >
> > >     nvme-pci: use host managed power state for suspend
> > >
> > > doesn't universally improve things.  In fact, in some cases it makes
> > > things worse.
> > >
> > > For example, on the Dell XPS13 9380 I have here it prevents the processor
> > > package
> > > from reaching idle states deeper than PC2 in suspend-to-idle (which, of
> > > course, also
> > > prevents the SoC from reaching any kind of S0ix).
> > >
> > > That can be readily explained too.  Namely, with the commit above the
> > > NVMe device
> > > stays in D0 over suspend/resume, so the root port it is connected to also
> > > has to stay in
> > > D0 and that "blocks" package C-states deeper than PC2.
> > >
> > > In order for the root port to be able to go to D3, the device connected
> > > to it also needs
> > > to go into D3, so it looks like (at least on this particular machine, but
> > > maybe in
> > > general), both D3 and the NVMe-specific PM are needed.
>
> Well this is really unfortunate to hear.  I recall that with some disks we were
> seeing problems where NVME specific PM wasn't working when the disk was in D3.
>
> On your specific disk, it would be good to know if just removing the pci_save_state(pdev)
> call helps.

Yes, it does help.

> If so, :
> * that might be a better option to add as a parameter.
> * maybe we should double check all the disks one more time with that tweak.

At this point it seems so.

> > > I'm not sure what to do here, because evidently there are systems where
> > > that commit
> > > helps.  I was thinking about adding a module option allowing the user to
> > > override the
> > > default behavior which in turn should be compatible with 5.2 and earlier
> > > kernels.
> >
> > I just briefly tested s2i on XPS 9370, and the power meter shows a 0.8~0.9W
> > power consumption so at least I don?t see the issue on XPS 9370.
> >
>
> To me that confirms NVME is down, but it still seems higher than I would have
> expected.  We should be more typically in the order of ~0.3W I think.

It may go to PC10, but not reach S0ix.

Anyway, I run the s2idle tests under turbostat which then tells me
what has happened more precisely.
