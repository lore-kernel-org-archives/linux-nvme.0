From: luto@kernel.org (Andy Lutomirski)
Date: Tue, 6 Jun 2017 08:57:23 -0700
Subject: NVMe APST high latency power states being skipped
In-Reply-To: <20170606095454.GA13569@infradead.org>
References: <CALCETrVx7BQjKt7tCXmG+jOD=JXxDKOdvVr1EuoZyN4_TjSdCA@mail.gmail.com>
 <5bfa6cf7e8994bc593f95e8641f648f5@ausx13mpc120.AMER.DELL.COM>
 <CAAd53p45jpFYf9UNooobGWexGA+DuRJo2NF8FP-7JGU8u3PtpA@mail.gmail.com>
 <CALCETrX+87zvN7sw-1qQHjQ_Bz9mSrjrHJLA9NBzaKSddntUug@mail.gmail.com>
 <CAAd53p7o4VRcb1=EE5Vx7rMAfxdpKGceAeVfaCuDrvUaV6x65g@mail.gmail.com>
 <20170526092556.GA645@infradead.org>
 <CAAd53p4qdk2ngC7-BNB++ZLKK39-MiUp22PT6wcsRzxCHzmniw@mail.gmail.com>
 <20170601113206.GA29895@infradead.org>
 <CAAd53p73xq3grrMCHt8ZfbF=RN+5URhTpY5uhc=u7FNgPfcdbA@mail.gmail.com>
 <20170602071337.GA11447@infradead.org> <20170606095454.GA13569@infradead.org>
Message-ID: <CALCETrVg_JZqjUJ43DmpukTyoifu4TWPGT+2cJy86J+1-UVFQA@mail.gmail.com>

On Tue, Jun 6, 2017@2:54 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, Jun 02, 2017@12:13:37AM -0700, Christoph Hellwig wrote:
>> > Maybe add an extra knob which can directly control deepest allow power
>> > state? Userspace tools can control deepest power state through this
>> > knob.
>>
>> I'd prefer that things work out of the box.  I'd be tempted to just
>> bump up the latency requirement to cover the device, but if Andy
>> doesn't like that in general we could add a quirk for this device
>> to at least allow it to use deep power states.
>
> Kai, can you send the patch to bump default_ps_max_latency_us to
> reasonably high value that all the devices you are testing are
> able to use PS3/4?

I'm starting to think we should ignore enlat and only consider exlat
when we interpret the requested max latency.  If I find some time,
I'll try to write a little benchmark to see how drives actually
behave.

Given that we've seen enlat as high as 1s, I don't think we want to
start setting the default latency over 1s.

--Andy
