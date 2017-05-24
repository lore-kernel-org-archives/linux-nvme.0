From: luto@kernel.org (Andy Lutomirski)
Date: Tue, 23 May 2017 22:31:31 -0700
Subject: NVMe APST high latency power states being skipped
In-Reply-To: <CAAd53p45jpFYf9UNooobGWexGA+DuRJo2NF8FP-7JGU8u3PtpA@mail.gmail.com>
References: <CAAd53p5pxgO-n0K4khAsYAcWw64tNJwtPwbMHaPksVQMLeXJmA@mail.gmail.com>
 <20170523071705.GD16776@infradead.org>
 <CAAd53p6uX1pKGAaNhYfT0VSRYD8A2e2Ykacak-pqW4GOXFJPug@mail.gmail.com>
 <CALCETrU2Ys=2nsMeHSXRaktNkmuHN7S-_D-pF23RFniqcAhjnQ@mail.gmail.com>
 <84ea5d8fbf0446c58c7b6c85d3868d94@ausx13mpc120.AMER.DELL.COM>
 <CALCETrWNU8uquoDiNDeYaoOUyMOAVyWQ73GfrEeWntTcm4ioAw@mail.gmail.com>
 <fb5caa2fa5e6452fadfa00bce59bedd7@ausx13mpc120.AMER.DELL.COM>
 <CALCETrVx7BQjKt7tCXmG+jOD=JXxDKOdvVr1EuoZyN4_TjSdCA@mail.gmail.com>
 <5bfa6cf7e8994bc593f95e8641f648f5@ausx13mpc120.AMER.DELL.COM>
 <CAAd53p45jpFYf9UNooobGWexGA+DuRJo2NF8FP-7JGU8u3PtpA@mail.gmail.com>
Message-ID: <CALCETrX+87zvN7sw-1qQHjQ_Bz9mSrjrHJLA9NBzaKSddntUug@mail.gmail.com>

On Tue, May 23, 2017 at 9:53 PM, Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
> On Wed, May 24, 2017@6:09 AM,  <Mario.Limonciello@dell.com> wrote:
> [snipped]
>>
>> I know Kai Heng has looked at a /lot/ of disks. I've got stats from a few
>> of them, but there are many more that I haven't seen.
>
> Not really, others I've seen have rather low latency. We have the same
> high latency ones.
>
>> Perhaps Chris or Kai Heng might be able to provide a better parameter
>> to base off from other experience.
>
> A quick summary: we need at least 61000 to make all of them be able to
> enters PS3,
> 1100000 for PS4.
>
> I'll do some performance testing on the 1100000 latency one.
>
> Is there anyway to observe the power state transition in NVMe?

I don't think so, sadly.  It's probably possible to use non-autonomous
transitions to force low power and then do some IO.  I can try to
fiddle with this and see how hard it would be to whip up a simple
benchmark.

>
> [snipped]
>
>> I think separate from the effort of getting the default right this makes sense.
>> To me the most important default should be getting the disk into at least
>> the first non-operational state even if latency is bad.
>>
>> Then provide the ability to block that non-operational state or go into
>> other non-operational states that would be otherwise blocked due to latency
>> by user code.
>
> We can add this to TLP by greping the PS3 latencies out of `nvme
> id-ctrl` and do some math, but it will be ugly.
>
>>
>>>
>>> >
>>> > Kai Heng can comment more on the testing they've done and the performance
>>> > impact, but I understand that by tweaking those knobs they've been able to
>>> > get all these disks into at least PS3 and saved a lot of power.
>>> >
>>> > We could go work with the TLP project  or power top guys and have them
>>> > go and tweak the various sysfs knobs to make more of these disks work,
>>> > but I would rather the kernel had good defaults across this collection of disks.
>>>
>>> Agreed.
>
> Other than TLP/powertop, we should make this easy to work with
> something like thermald.
> NVMe is quite hot. It can be quite useful to let thermald controls the
> max available power state directly via sysfs knob. Fanless devices
> will benefit a lot from this.

Hmm.  That's doable but isn't strictly part of APST.  We could add a
sysfs knob "operating_power_state" and a sysfs file that lists the
available operating states.  APST is about transitions to
*non-operating* states.

Unfortunately, the info in the provided tables are almost entirely
worthless when it comes to describing the performance impact of using
reduced-power operating states.  Also, I wouldn't personally be
shocked to see some interesting hardware bugs.
