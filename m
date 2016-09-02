From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Fri, 02 Sep 2016 11:11:19 -0700
Subject: [PATCH 3/3] nvme: Enable autonomous power state transitions
In-Reply-To: <CALCETrUFRhNTamd-u_K+KTowN9S8WJKgreUQ4mfxmfx5v8zSPQ@mail.gmail.com>
References: <cover.1472462539.git.luto@kernel.org>
 <88cc7972617eec58a81877d933604e0f0e342e43.1472462539.git.luto@kernel.org>
 <1472483266.2816.14.camel@linux.intel.com>
 <CALCETrXu8oOnc9R=_Bt8f6c=eGAJ0ZwbUL5xCUsu5zWR_ZzSKA@mail.gmail.com>
 <CALCETrUFRhNTamd-u_K+KTowN9S8WJKgreUQ4mfxmfx5v8zSPQ@mail.gmail.com>
Message-ID: <1472839879.2754.77.camel@linux.intel.com>


> > > 
> > > 
> > > > 
> > > > +?????/*
> > > > +??????* By default, allow up to 25ms of APST-induced
> > > > latency.??This will
> > > > +??????* have no effect on non-APST supporting controllers
> > > > (i.e.
> > > > any
> > > > +??????* controller with APSTA == 0).
> > > > +??????*/
> > > > +?????ctrl->apst_max_latency_ns = 25000000;
> > > 
> > > Is it possible to make that a #define please?
> > 
> > I'll make it a module parameter as Keith suggested.
> 
> One question, though: should we call this and the sysfs parameter
> apst_max_latency or should it be more generically
> power_save_max_latency???The idea is that we might want to support
> non-automonous transitions some day or even runtime D3.??Or maybe
> those should be separately configured if used.

I read the spec and reviewed your latest patchset. ?Personally for me I
like having the field names from the NVMe spec in the names of the
Linux implementation because it makes it easier to find and relate the
two. ?So apst_max_latency makes more sense to me, as this is a
'apst'(e/a) NVMe feature.

> 
> --Andy
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
