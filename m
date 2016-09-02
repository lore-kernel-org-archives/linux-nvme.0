From: luto@amacapital.net (Andy Lutomirski)
Date: Fri, 2 Sep 2016 11:50:59 -0700
Subject: [PATCH 3/3] nvme: Enable autonomous power state transitions
In-Reply-To: <1472839879.2754.77.camel@linux.intel.com>
References: <cover.1472462539.git.luto@kernel.org>
 <88cc7972617eec58a81877d933604e0f0e342e43.1472462539.git.luto@kernel.org>
 <1472483266.2816.14.camel@linux.intel.com>
 <CALCETrXu8oOnc9R=_Bt8f6c=eGAJ0ZwbUL5xCUsu5zWR_ZzSKA@mail.gmail.com>
 <CALCETrUFRhNTamd-u_K+KTowN9S8WJKgreUQ4mfxmfx5v8zSPQ@mail.gmail.com>
 <1472839879.2754.77.camel@linux.intel.com>
Message-ID: <CALCETrUM0rUOk52VUEeZge-t3Mrz7=d8WqpNOghyFpzYkdY38w@mail.gmail.com>

On Fri, Sep 2, 2016 at 11:11 AM, J Freyensee
<james_p_freyensee@linux.intel.com> wrote:
>
>> > >
>> > >
>> > > >
>> > > > +     /*
>> > > > +      * By default, allow up to 25ms of APST-induced
>> > > > latency.  This will
>> > > > +      * have no effect on non-APST supporting controllers
>> > > > (i.e.
>> > > > any
>> > > > +      * controller with APSTA == 0).
>> > > > +      */
>> > > > +     ctrl->apst_max_latency_ns = 25000000;
>> > >
>> > > Is it possible to make that a #define please?
>> >
>> > I'll make it a module parameter as Keith suggested.
>>
>> One question, though: should we call this and the sysfs parameter
>> apst_max_latency or should it be more generically
>> power_save_max_latency?  The idea is that we might want to support
>> non-automonous transitions some day or even runtime D3.  Or maybe
>> those should be separately configured if used.
>
> I read the spec and reviewed your latest patchset.  Personally for me I
> like having the field names from the NVMe spec in the names of the
> Linux implementation because it makes it easier to find and relate the
> two.  So apst_max_latency makes more sense to me, as this is a
> 'apst'(e/a) NVMe feature.
>

It's not really an APST feature, though -- it's just the maximum
(entry + exit) latency from the power state table.  So if we every
supported non-APST power state transitions, we could use the same type
of policy.

I'm not really arguing for changing it, though, and I personally have
no plans to implement a non-autonomous policy.

--Andy
