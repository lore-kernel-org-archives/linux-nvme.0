From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 2 Jun 2017 00:13:37 -0700
Subject: NVMe APST high latency power states being skipped
In-Reply-To: <CAAd53p73xq3grrMCHt8ZfbF=RN+5URhTpY5uhc=u7FNgPfcdbA@mail.gmail.com>
References: <fb5caa2fa5e6452fadfa00bce59bedd7@ausx13mpc120.AMER.DELL.COM>
 <CALCETrVx7BQjKt7tCXmG+jOD=JXxDKOdvVr1EuoZyN4_TjSdCA@mail.gmail.com>
 <5bfa6cf7e8994bc593f95e8641f648f5@ausx13mpc120.AMER.DELL.COM>
 <CAAd53p45jpFYf9UNooobGWexGA+DuRJo2NF8FP-7JGU8u3PtpA@mail.gmail.com>
 <CALCETrX+87zvN7sw-1qQHjQ_Bz9mSrjrHJLA9NBzaKSddntUug@mail.gmail.com>
 <CAAd53p7o4VRcb1=EE5Vx7rMAfxdpKGceAeVfaCuDrvUaV6x65g@mail.gmail.com>
 <20170526092556.GA645@infradead.org>
 <CAAd53p4qdk2ngC7-BNB++ZLKK39-MiUp22PT6wcsRzxCHzmniw@mail.gmail.com>
 <20170601113206.GA29895@infradead.org>
 <CAAd53p73xq3grrMCHt8ZfbF=RN+5URhTpY5uhc=u7FNgPfcdbA@mail.gmail.com>
Message-ID: <20170602071337.GA11447@infradead.org>

On Fri, Jun 02, 2017@03:08:49PM +0800, Kai-Heng Feng wrote:
> After some more test, actually I am getting similar values despite
> APST on or off. This is a super hot machine so throttled CPU might be
> a more impactful factor here.
> 
> Can't directly get power state from NVMe make the latency between
> power state transition hard to measure.
> 
> At least after a long idle, I typed `ls` and everything showed
> instantly, I can't feel the latency at all. Probably the "real"
> latency is not as bad as NVMe claimed.
> 
> Maybe add an extra knob which can directly control deepest allow power
> state? Userspace tools can control deepest power state through this
> knob.

I'd prefer that things work out of the box.  I'd be tempted to just
bump up the latency requirement to cover the device, but if Andy
doesn't like that in general we could add a quirk for this device
to at least allow it to use deep power states.
