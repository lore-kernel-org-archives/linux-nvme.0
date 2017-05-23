From: Mario.Limonciello@dell.com (Mario.Limonciello@dell.com)
Date: Tue, 23 May 2017 22:09:44 +0000
Subject: NVMe APST high latency power states being skipped
In-Reply-To: <CALCETrVx7BQjKt7tCXmG+jOD=JXxDKOdvVr1EuoZyN4_TjSdCA@mail.gmail.com>
References: <CAAd53p5pxgO-n0K4khAsYAcWw64tNJwtPwbMHaPksVQMLeXJmA@mail.gmail.com>
 <20170523071705.GD16776@infradead.org>
 <CAAd53p6uX1pKGAaNhYfT0VSRYD8A2e2Ykacak-pqW4GOXFJPug@mail.gmail.com>
 <CALCETrU2Ys=2nsMeHSXRaktNkmuHN7S-_D-pF23RFniqcAhjnQ@mail.gmail.com>
 <84ea5d8fbf0446c58c7b6c85d3868d94@ausx13mpc120.AMER.DELL.COM>
 <CALCETrWNU8uquoDiNDeYaoOUyMOAVyWQ73GfrEeWntTcm4ioAw@mail.gmail.com>
 <fb5caa2fa5e6452fadfa00bce59bedd7@ausx13mpc120.AMER.DELL.COM>
 <CALCETrVx7BQjKt7tCXmG+jOD=JXxDKOdvVr1EuoZyN4_TjSdCA@mail.gmail.com>
Message-ID: <5bfa6cf7e8994bc593f95e8641f648f5@ausx13mpc120.AMER.DELL.COM>



> -----Original Message-----
> From: Andy Lutomirski [mailto:luto at kernel.org]
> Sent: Tuesday, May 23, 2017 4:12 PM
> To: Limonciello, Mario <Mario_Limonciello at Dell.com>
> Cc: Andrew Lutomirski <luto at kernel.org>; Kai-Heng Feng
> <kai.heng.feng at canonical.com>; Christoph Hellwig <hch at infradead.org>; linux-
> nvme <linux-nvme at lists.infradead.org>
> Subject: Re: NVMe APST high latency power states being skipped
> 
> On Tue, May 23, 2017@1:19 PM,  <Mario.Limonciello@dell.com> wrote:
> >> > There are some configurations that have multiple NVMe disks.
> >> > For example the Precision 7520 can have up to 3.
> >> >
> >> > NVME Identify Controller:
> >> ...
> >> > mn      : A400 NVMe SanDisk 512GB
> >> ...
> >> > ps    0 : mp:8.25W operational enlat:0 exlat:0 rrt:0 rrl:0
> >> >           rwt:0 rwl:0 idle_power:- active_power:5.30W
> >> > ps    1 : mp:8.25W operational enlat:0 exlat:0 rrt:1 rrl:1
> >> >           rwt:1 rwl:1 idle_power:- active_power:3.30W
> >> > ps    2 : mp:8.25W operational enlat:0 exlat:0 rrt:2 rrl:2
> >> >           rwt:2 rwl:2 idle_power:- active_power:3.30W
> >> > ps    3 : mp:0.0500W non-operational enlat:51000 exlat:10000 rrt:0 rrl:0
> >> >           rwt:0 rwl:0 idle_power:- active_power:-
> >> > ps    4 : mp:0.0055W non-operational enlat:1000000 exlat:100000 rrt:0 rrl:0
> >> >           rwt:0 rwl:0 idle_power:- active_power:-
> >> >
> >>
> >> 44.5mW saved and totally crazy latency.
> >>
> >> >
> >> > NVME Identify Controller:
> >> ...
> >> > mn      : THNSF5512GPUK NVMe SED TOSHIBA 512GB
> >> ...
> >> > ps    0 : mp:6.00W operational enlat:0 exlat:0 rrt:0 rrl:0
> >> >           rwt:0 rwl:0 idle_power:- active_power:-
> >> > ps    1 : mp:2.40W operational enlat:0 exlat:0 rrt:1 rrl:1
> >> >           rwt:1 rwl:1 idle_power:- active_power:-
> >> > ps    2 : mp:1.90W operational enlat:0 exlat:0 rrt:2 rrl:2
> >> >           rwt:2 rwl:2 idle_power:- active_power:-
> >> > ps    3 : mp:0.0120W non-operational enlat:5000 exlat:25000 rrt:3 rrl:3
> >> >           rwt:3 rwl:3 idle_power:- active_power:-
> >> > ps    4 : mp:0.0060W non-operational enlat:100000 exlat:70000 rrt:4 rrl:4
> >> >           rwt:4 rwl:4 idle_power:- active_power:-
> >>
> >> 6 mW saved and still fairly crazy latency.  70ms means you drop a couple frames.
> >>
> >> >
> >> >
> >> > NVME Identify Controller:
> >> ...
> >> > mn      : CX2-GB1024-Q11 NVMe LITEON 1024GB
> >> ...> ps    0 : mp:8.00W operational enlat:0 exlat:0 rrt:0 rrl:0
> >> >           rwt:0 rwl:0 idle_power:- active_power:-
> >> > ps    1 : mp:4.00W operational enlat:5 exlat:5 rrt:1 rrl:1
> >> >           rwt:1 rwl:1 idle_power:- active_power:-
> >> > ps    2 : mp:2.10W operational enlat:5 exlat:5 rrt:2 rrl:2
> >> >           rwt:2 rwl:2 idle_power:- active_power:-
> >> > ps    3 : mp:0.1000W non-operational enlat:5000 exlat:5000 rrt:3 rrl:3
> >> >           rwt:3 rwl:3 idle_power:- active_power:-
> >> > ps    4 : mp:0.0100W non-operational enlat:50000 exlat:100000 rrt:4 rrl:4
> >> >           rwt:4 rwl:4 idle_power:- active_power:-
> >>
> >> 90mW saved and still 100ms latency.  Also, I didn't know that Lite-on
> >> made disks.
> >
> > Well so the important one here I think is jumping down to PS3.  That's a much
> bigger
> > drop in power across all of these disks.  The Liteon one will obviously go into PS3
> > in the current patch, but the other two are just going to be vampires.
> 
> Ah, I missed that when reading the numbers.
> 
> >
> >>
> >> I'm not convinced that there's any chassis type for which this type of
> >> default makes sense.
> >>
> > I guess I'm wondering where you came up with 25000 as the default:
> > +static unsigned long default_ps_max_latency_us = 25000;
> >
> > Was it based across results of testing a bunch of disks, or from
> > experimentation with a few higher end SSDs?
> 
> It was based on results across a bunch of disks, where "a bunch" == 2,
> one that I own and one that Niranjan has. :)  Also, 25ms is a nice
> round number.  I could be persuaded to increase it.  (Although the
> SanDisk one should hit PS3 as well, no?)
>
I think you missed a 0 when looking at the numbers.

51000 + 10000 > 25000
 
> I could also be persuaded to change the relevant parameter from (enlat
> + exlat) to something else.  The spec says, in language that's about
> as clear as mud, that starting to go non-operational and then doing
> any actual work can take (enlat + exlat) time.  But maybe real disks
> aren't quite that bad.  In any event, the common case should be just
> exlat.
> 

I know Kai Heng has looked at a /lot/ of disks. I've got stats from a few
of them, but there are many more that I haven't seen.

Perhaps Chris or Kai Heng might be able to provide a better parameter 
to base off from other experience.

> Also, jeez, that Toshiba disk must *suck* under the RSTe policy.  25ms
> exit latency incurred after 60ms of idle time?  No thanks!
> 
> >
> >> What would perhaps make sense is to have system-wide
> >> performance-vs-power controls and to integrate NVMe power saving into
> >> it, presumably through the pm_qos framework.  Or to export more
> >> information to userspace and have a user tool that sets all this up
> >> generically.
> >
> > So I think you're already doing this.  power/pm_qos_latency_tolerance_us
> > and the module parameter default_ps_max_latency_us can effectively
> > change it.
> 
> What I mean is: <device>/power could also expose some hints about
> exactly what the tradeoffs are (to the best of the kernel's knowledge)
> so that user code could make a more informed and more automatic
> decision.

I think separate from the effort of getting the default right this makes sense.
To me the most important default should be getting the disk into at least
the first non-operational state even if latency is bad.

Then provide the ability to block that non-operational state or go into
other non-operational states that would be otherwise blocked due to latency
by user code.

> 
> >
> > Kai Heng can comment more on the testing they've done and the performance
> > impact, but I understand that by tweaking those knobs they've been able to
> > get all these disks into at least PS3 and saved a lot of power.
> >
> > We could go work with the TLP project  or power top guys and have them
> > go and tweak the various sysfs knobs to make more of these disks work,
> > but I would rather the kernel had good defaults across this collection of disks.
> 
> Agreed.
