From: keith.busch@intel.com (Keith Busch)
Date: Mon, 15 May 2017 10:44:39 -0400
Subject: [RFC] NVMe Configuraiton using sysctl
In-Reply-To: <f4e5a2bd-9e41-8025-31a9-9bcadd2468c3@grimberg.me>
References: <CAMSpPPcxWYtZMbAc4TWam3iC1cLbxBPM=EhNPKA6qweiGnJvVg@mail.gmail.com>
 <CAMSpPPf640XfjW38=NXHmkDG0SeduavOEkKiEJuGmobq183jNg@mail.gmail.com>
 <f4e5a2bd-9e41-8025-31a9-9bcadd2468c3@grimberg.me>
Message-ID: <20170515144439.GA28520@localhost.localdomain>

On Mon, May 15, 2017@12:15:28PM +0300, Sagi Grimberg wrote:
> 
> > > Hi,
> 
> Hi Oza,
> 
> > > we are configuring interrupt coalesce for NVMe, but right now, it uses
> > > module param.
> > > so the same interrupt coalesce settings get applied for all the NVMEs
> > > connected to different RCs.
> > > 
> > > ideally it should be with sysctl.
> 
> If at all, I would place this in nvme-cli (via ioctl) instead of
> sysctl.

That's also how I currently recommend testing this feature out. A problem
with that, though, is the feature isn't persistent across controller
resets, so the setting could be reverted without the user knowing.


> > > for e.g.
> > > sysctl should provide interface to change
> > > Per-CPU IO queue pairs, interrupt coalesce settings etc..
> 
> My personal feeling is that percpu granularity is a lot to take in for
> the user, and also can yield some unexpected performance
> characteristics. But I might be wrong here..

We currently use the IRQ affinity spread to get good default pairings.
It's possible to decouple that, but let's hear what about the default
setting isn't optimal before exposing additional knobs. More user tunables
just means one of us will get to frequently re-explain how to use it!


> > > please suggest if we could have/implement sysctl module for NVMe ?
> 
> I have asked this before, but interrupt coalescing has very little
> merit without being able to be adaptive. net drivers maintain online
> stats and schedule interrupt coalescing modifications.
> 
> Should work in theory, but having said that, interrupt coalescing as a
> whole is essentially unusable in nvme since the coalescing time limit
> is in units of 100us increments...

Yeah, as it is defined, the low depth work-load latency does suffer
quite a bit. If the user only cares about IOPs, though, we find that
coalescing is necessary for some workloads to hit the peak capabilities.
