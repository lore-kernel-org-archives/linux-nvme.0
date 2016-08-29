From: luto@amacapital.net (Andy Lutomirski)
Date: Mon, 29 Aug 2016 16:16:58 -0700
Subject: [PATCH 3/3] nvme: Enable autonomous power state transitions
In-Reply-To: <1472483266.2816.14.camel@linux.intel.com>
References: <cover.1472462539.git.luto@kernel.org>
 <88cc7972617eec58a81877d933604e0f0e342e43.1472462539.git.luto@kernel.org>
 <1472483266.2816.14.camel@linux.intel.com>
Message-ID: <CALCETrXu8oOnc9R=_Bt8f6c=eGAJ0ZwbUL5xCUsu5zWR_ZzSKA@mail.gmail.com>

On Aug 29, 2016 8:07 AM, "J Freyensee"
<james_p_freyensee@linux.intel.com> wrote:
>
> On Mon, 2016-08-29@02:25 -0700, Andy Lutomirski wrote:
> > NVME devices can advertise multiple power states.  These states can
> > be either "operational" (the device is fully functional but possibly
> > slow) or "non-operational" (the device is asleep until woken up).
> > Some devices can automatically enter a non-operational state when
> > idle for a specified amount of time and then automatically wake back
> > up when needed.
> >
> > The hardware configuration is a table.  For each state, an entry in
> > the table indicates the next deeper non-operational state, if any,
> > to autonomously transition to and the idle time required before
> > transitioning.
> >
> > This patch teaches the driver to program APST so that each
> > successive non-operational state will be entered after an idle time
> > equal to 100% of the total latency (entry plus exit) associated with
> > that state.  A sysfs attribute 'apst_max_latency_ns' gives the
> > maximum acceptable latency in ns; non-operational states with total
> > latency greater than this value will not be used.  As a special
> > case, apst_max_latency_ns=0 will disable APST entirely.
> >
> > On hardware without APST support, apst_max_latency_ns will not be
> > exposed in sysfs.
> >
> > In theory, the device can expose "default" APST table, but this
> > doesn't seem to function correctly on my device (Samsung 950), nor
> > does it seem particularly useful.  There is also an optional
> > mechanism by which a configuration can be "saved" so it will be
> > automatically loaded on reset.  This can be configured from
> > userspace, but it doesn't seem useful to support in the driver.
> >
> > On my laptop, enabling APST seems to save nearly 1W.
> >
> > The hardware tables can be decoded in userspace with nvme-cli.
> > 'nvme id-ctrl /dev/nvmeN' will show the power state table and
> > 'nvme get-feature -f 0x0c -H /dev/nvme0' will show the current APST
> > configuration.
> >
> > Signed-off-by: Andy Lutomirski <luto at kernel.org>
> > ---
> >  drivers/nvme/host/core.c | 167
> > +++++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/nvme/host/nvme.h |   6 ++
> >  include/linux/nvme.h     |   6 ++
> >  3 files changed, 179 insertions(+)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 3f7561ab54dc..042137ad2437 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -1223,6 +1223,98 @@ static void nvme_set_queue_limits(struct
> > nvme_ctrl *ctrl,
> >       blk_queue_write_cache(q, vwc, vwc);
> >  }
> >
> > +static void nvme_configure_apst(struct nvme_ctrl *ctrl)
> > +{
> > +     /*
> > +      * APST (Autonomous Power State Transition) lets us program
> > a
> > +      * table of power state transitions that the controller will
> > +      * perform automatically.  We configure it with a simple
> > +      * heuristic: we are willing to spend at most 2% of the time
> > +      * transitioning between power states.  Therefore, when
> > running
> > +      * in any given state, we will enter the next lower-power
> > +      * non-operational state after waiting 100 * (enlat + exlat)
> > +      * microseconds, as long as that state's total latency is
> > under
> > +      * the requested maximum latency.
> > +      *
> > +      * We will not autonomously enter any non-operational state
> > for
> > +      * which the total latency exceeds
> > apst_max_latency_ns.  Users
> > +      * can set apst_max_latency_ns to zero to turn off APST.
> > +      */
> > +
> > +     unsigned apste;
> > +     struct nvme_feat_auto_pst *table;
> > +     int ret;
> > +
> > +     if (!ctrl->apsta)
> > +             return; /* APST isn't supported. */
> > +
> > +     if (ctrl->npss > 31) {
> > +             dev_warn(ctrl->device, "NPSS is invalid; disabling
> > APST\n");
>
> Quick question.  A little bit below in a later if() block, apste is set
> to 0 to turn off APST, which is to be used later in a
> nvme_set_features() call to actually turn it off.  You wouldn't want to
> also set apste to zero too and call a nvme_set_features() to "disable
> APST"?
>
> I guess I'm a little confused on the error statement, "disabling APST",
> when it doesn't seem like anything is being done to actually disable
> APST, it's just more of an invalid state retrieved from the HW.

I guess that should be "not using APST" instead.

>
>
> > +             return;
> > +     }
> > +
> > +     table = kzalloc(sizeof(*table), GFP_KERNEL);
> > +     if (!table)
> > +             return;
> > +
> > +     if (ctrl->apst_max_latency_ns == 0) {
> > +             /* Turn off APST. */
> > +             apste = 0;
> > +     } else {
> > +             __le64 target = cpu_to_le64(0);
> > +             int state;
> > +
> > +             /*
> > +              * Walk through all states from lowest- to highest-
> > power.
> > +              * According to the spec, lower-numbered states use
> > more
> > +              * power.  NPSS, despite the name, is the index of
> > the
> > +              * lowest-power state, not the number of states.
> > +              */
> > +             for (state = (int)ctrl->npss; state >= 0; state--) {
> > +                     u64 total_latency_us, transition_ms;
> > +
> > +                     if (target)
> > +                             table->entries[state] = target;
> > +
> > +                     /*
> > +                      * Is this state a useful non-operational
> > state for
> > +                      * higher-power states to autonomously
> > transition to?
> > +                      */
> > +                     if (!(ctrl->psd[state].flags & 2))
> > +                             continue;  /* It's an operational
> > state. */
> > +
> > +                     total_latency_us =
> > +                             (u64)cpu_to_le32(ctrl-
> > >psd[state].entry_lat) +
> > +                             + cpu_to_le32(ctrl-
> > >psd[state].exit_lat);
> > +                     if (total_latency_us * 1000 > ctrl-
> > >apst_max_latency_ns)
> > +                             continue;
> > +
> > +                     /*
> > +                      * This state is good.  Use it as the APST
> > idle
> > +                      * target for higher power states.
> > +                      */
> > +                     transition_ms = total_latency_us + 19;
> > +                     do_div(transition_ms, 20);
> > +                     if (transition_ms >= (1 << 24))
> > +                             transition_ms = (1 << 24);
>
> Is it possible to use a macro for this bit shift as its used more than
> once?

Sure, will do.

>
> > +
> > +                     target = cpu_to_le64((state << 3) |
> > +                                          (transition_ms << 8));
> > +             }
> >
>
> snip...
> .
> .
> .
>
> > +     /*
> > +      * By default, allow up to 25ms of APST-induced
> > latency.  This will
> > +      * have no effect on non-APST supporting controllers (i.e.
> > any
> > +      * controller with APSTA == 0).
> > +      */
> > +     ctrl->apst_max_latency_ns = 25000000;
>
> Is it possible to make that a #define please?

I'll make it a module parameter as Keith suggested.

>
> Nice stuff!
>
>
> >
