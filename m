From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Fri, 02 Sep 2016 15:23:05 -0700
Subject: [PATCH v2 3/3] nvme: Enable autonomous power state transitions
In-Reply-To: <CALCETrVoMEzmjfj--e09F8Ss8Dp9CFAmuuBhFoHOSNDoxHu6aQ@mail.gmail.com>
References: <cover.1472594203.git.luto@kernel.org>
 <6e6c3cd47858160bf8e34f2edb481c0ef5092d5b.1472594203.git.luto@kernel.org>
 <1472850905.2946.20.camel@linux.intel.com>
 <CALCETrVoMEzmjfj--e09F8Ss8Dp9CFAmuuBhFoHOSNDoxHu6aQ@mail.gmail.com>
Message-ID: <1472854985.2946.45.camel@linux.intel.com>

On Fri, 2016-09-02@14:43 -0700, Andy Lutomirski wrote:
> On Fri, Sep 2, 2016 at 2:15 PM, J Freyensee
> <james_p_freyensee@linux.intel.com> wrote:
> > 
> > On Tue, 2016-08-30@14:59 -0700, Andy Lutomirski wrote:
> > > 
> > > NVME devices can advertise multiple power states.??These states
> > > can
> > > be either "operational" (the device is fully functional but
> > > possibly
> > > slow) or "non-operational" (the device is asleep until woken up).
> > > Some devices can automatically enter a non-operational state when
> > > idle for a specified amount of time and then automatically wake
> > > back
> > > up when needed.
> > > 
> > > The hardware configuration is a table.??For each state, an entry
> > > in
> > > the table indicates the next deeper non-operational state, if
> > > any,
> > > to autonomously transition to and the idle time required before
> > > transitioning.
> > > 
> > > This patch teaches the driver to program APST so that each
> > > successive non-operational state will be entered after an idle
> > > time
> > > equal to 100% of the total latency (entry plus exit) associated
> > > with
> > > that state.??A sysfs attribute 'apst_max_latency_us' gives the
> > > maximum acceptable latency in ns; non-operational states with
> > > total
> > > latency greater than this value will not be used.??As a special
> > > case, apst_max_latency_us=0 will disable APST entirely.
> > 
> > May I ask a dumb question?
> > 
> > How does this work with multiple NVMe devices plugged into a
> > system???I
> > would have thought we'd want one apst_max_latency_us entry per NVMe
> > controller for individual control of each device???I have two
> > Fultondale-class devices plugged into a system I tried these
> > patches on
> > (the 4.8-rc4 kernel) and I'm not sure how the single
> > /sys/module/nvme_core/parameters/apst_max_latency_us would work per
> > my
> > 2 devices (and the value is using the default 25000).
> > 
> 
> Ah, I faked you out :(
> 
> The module parameter (nvme_core/parameters/apst_max_latency_us) just
> sets the default for newly probed devices.??The actual setting is in
> /sys/devices/whatever (symlinked from /sys/block/nvme0n1/devices, for
> example).??Perhaps I should name the former
> default_apst_max_latency_us.

It would certainly be more describable to understand what the entry is
for, but then the name is also getting longer.

Just "default_apst_latency_us"? Or maybe it's probably fine as-is.
