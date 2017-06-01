From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 1 Jun 2017 04:32:06 -0700
Subject: NVMe APST high latency power states being skipped
In-Reply-To: <CAAd53p4qdk2ngC7-BNB++ZLKK39-MiUp22PT6wcsRzxCHzmniw@mail.gmail.com>
References: <84ea5d8fbf0446c58c7b6c85d3868d94@ausx13mpc120.AMER.DELL.COM>
 <CALCETrWNU8uquoDiNDeYaoOUyMOAVyWQ73GfrEeWntTcm4ioAw@mail.gmail.com>
 <fb5caa2fa5e6452fadfa00bce59bedd7@ausx13mpc120.AMER.DELL.COM>
 <CALCETrVx7BQjKt7tCXmG+jOD=JXxDKOdvVr1EuoZyN4_TjSdCA@mail.gmail.com>
 <5bfa6cf7e8994bc593f95e8641f648f5@ausx13mpc120.AMER.DELL.COM>
 <CAAd53p45jpFYf9UNooobGWexGA+DuRJo2NF8FP-7JGU8u3PtpA@mail.gmail.com>
 <CALCETrX+87zvN7sw-1qQHjQ_Bz9mSrjrHJLA9NBzaKSddntUug@mail.gmail.com>
 <CAAd53p7o4VRcb1=EE5Vx7rMAfxdpKGceAeVfaCuDrvUaV6x65g@mail.gmail.com>
 <20170526092556.GA645@infradead.org>
 <CAAd53p4qdk2ngC7-BNB++ZLKK39-MiUp22PT6wcsRzxCHzmniw@mail.gmail.com>
Message-ID: <20170601113206.GA29895@infradead.org>

On Thu, Jun 01, 2017@04:19:26PM +0800, Kai-Heng Feng wrote:
> >> I did some benchmark on the high latency SanDisk A400:
> >> Kernel compilation, no PS3/PS4:
> >> real    23m36.466s
> >> user    115m49.944s
> >> sys     10m58.352s
> >>
> >> Kernel compilation, allow PS3/PS4:
> >> real    24m40.308s
> >> user    116m12.600s
> >> sys     11m47.484s
> >
> > That's quite a bit of a slow down.  Can we play a bit with the
> > entry latency (maybe just for PS4) so that we still get into the
> > modes, but not as quickly?
> 
> I changed the "Idle Time Prior to Transition" from 55000ms to 110000ms,
> The time to compile kernel source is roughly the same.
> 
> My guess is that since the filesystem is constantly doing I/O while
> compiling kernel, nvme never (or rarely) hits PS4.

That doesn't explain why we need more than a minute more for the
compile.  How reproducible are these numbers, btw?
