From: luto@amacapital.net (Andy Lutomirski)
Date: Mon, 29 Aug 2016 16:16:33 -0700
Subject: [PATCH 3/3] nvme: Enable autonomous power state transitions
In-Reply-To: <20160829164540.GE19986@localhost.localdomain>
References: <cover.1472462539.git.luto@kernel.org>
 <88cc7972617eec58a81877d933604e0f0e342e43.1472462539.git.luto@kernel.org>
 <20160829164540.GE19986@localhost.localdomain>
Message-ID: <CALCETrWDRV_TZRpsya=kmG+zDGwRqBpSGh6NGqCgDw3SdMfT9w@mail.gmail.com>

On Aug 29, 2016 9:35 AM, "Keith Busch" <keith.busch@intel.com> wrote:
>
> On Mon, Aug 29, 2016@02:25:46AM -0700, Andy Lutomirski wrote:
> > +     /*
> > +      * By default, allow up to 25ms of APST-induced latency.  This will
> > +      * have no effect on non-APST supporting controllers (i.e. any
> > +      * controller with APSTA == 0).
> > +      */
> > +     ctrl->apst_max_latency_ns = 25000000;
>
> Any objection to making this a module parameter? 25ms default sounds
> reasonable, but I would still like the option to not ever initialize
> APST on a capable device.

Will do.
