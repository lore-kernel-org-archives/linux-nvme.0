From: kai.heng.feng@canonical.com (Kai-Heng Feng)
Date: Wed, 7 Jun 2017 14:19:27 +0800
Subject: NVMe APST high latency power states being skipped
In-Reply-To: <CALCETrVg_JZqjUJ43DmpukTyoifu4TWPGT+2cJy86J+1-UVFQA@mail.gmail.com>
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
 <CALCETrVg_JZqjUJ43DmpukTyoifu4TWPGT+2cJy86J+1-UVFQA@mail.gmail.com>
Message-ID: <CAAd53p4oM4ZjfBr9dC5SurpovzjeOe5JxqbuC7Jgqd5U5mX-Qg@mail.gmail.com>

On Tue, Jun 6, 2017@11:57 PM, Andy Lutomirski <luto@kernel.org> wrote:
> On Tue, Jun 6, 2017@2:54 AM, Christoph Hellwig <hch@infradead.org> wrote:
>> On Fri, Jun 02, 2017@12:13:37AM -0700, Christoph Hellwig wrote:
>>> > Maybe add an extra knob which can directly control deepest allow power
>>> > state? Userspace tools can control deepest power state through this
>>> > knob.
>>>
>>> I'd prefer that things work out of the box.  I'd be tempted to just
>>> bump up the latency requirement to cover the device, but if Andy
>>> doesn't like that in general we could add a quirk for this device
>>> to at least allow it to use deep power states.
>>
>> Kai, can you send the patch to bump default_ps_max_latency_us to
>> reasonably high value that all the devices you are testing are
>> able to use PS3/4?
>
> I'm starting to think we should ignore enlat and only consider exlat
> when we interpret the requested max latency.  If I find some time,
> I'll try to write a little benchmark to see how drives actually
> behave.

Suppose a NVMe with 5ms enlat and 5ms exlat, the Idle Time Prior to
Transition is 500ms.
I'd say that most of the time, the no I/O activities period will also
spans over the entlat's 5ms time window, hence the only impactful
latency here is limited to exlat.
The chance to occur 10ms latency (device transits back to op state
right after it enters non-op state) should be low.

So I think you are right, only considering exlat will be more close to
real world scenario.

>
> Given that we've seen enlat as high as 1s, I don't think we want to
> start setting the default latency over 1s.

The highest PS4 exlat on NVMes at my hand is 100ms. Newer NVMe should
have better latency.

I'll send a patch for this, thanks for the info.
