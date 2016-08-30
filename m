From: luto@amacapital.net (Andy Lutomirski)
Date: Tue, 30 Aug 2016 13:21:20 -0700
Subject: [PATCH 3/3] nvme: Enable autonomous power state transitions
In-Reply-To: <CALCETrXu8oOnc9R=_Bt8f6c=eGAJ0ZwbUL5xCUsu5zWR_ZzSKA@mail.gmail.com>
References: <cover.1472462539.git.luto@kernel.org>
 <88cc7972617eec58a81877d933604e0f0e342e43.1472462539.git.luto@kernel.org>
 <1472483266.2816.14.camel@linux.intel.com>
 <CALCETrXu8oOnc9R=_Bt8f6c=eGAJ0ZwbUL5xCUsu5zWR_ZzSKA@mail.gmail.com>
Message-ID: <CALCETrUFRhNTamd-u_K+KTowN9S8WJKgreUQ4mfxmfx5v8zSPQ@mail.gmail.com>

On Mon, Aug 29, 2016@4:16 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Aug 29, 2016 8:07 AM, "J Freyensee"
> <james_p_freyensee@linux.intel.com> wrote:
>>
>> On Mon, 2016-08-29@02:25 -0700, Andy Lutomirski wrote:
>> > NVME devices can advertise multiple power states.  These states can
>> > be either "operational" (the device is fully functional but possibly
>> > slow) or "non-operational" (the device is asleep until woken up).
>> > Some devices can automatically enter a non-operational state when
>> > idle for a specified amount of time and then automatically wake back
>> > up when needed.
>> >

>>
>> > +     /*
>> > +      * By default, allow up to 25ms of APST-induced
>> > latency.  This will
>> > +      * have no effect on non-APST supporting controllers (i.e.
>> > any
>> > +      * controller with APSTA == 0).
>> > +      */
>> > +     ctrl->apst_max_latency_ns = 25000000;
>>
>> Is it possible to make that a #define please?
>
> I'll make it a module parameter as Keith suggested.

One question, though: should we call this and the sysfs parameter
apst_max_latency or should it be more generically
power_save_max_latency?  The idea is that we might want to support
non-automonous transitions some day or even runtime D3.  Or maybe
those should be separately configured if used.

--Andy
