From: luto@kernel.org (Andy Lutomirski)
Date: Fri, 16 Sep 2016 08:26:03 -0700
Subject: Should drivers like nvme let userspace control their latency via
 dev_pm_qos?
Message-ID: <CALCETrUsgA2H=TuwZMuwW2XpXZ7KPrEYu6xckmTbhU8oZwr6Nw@mail.gmail.com>

I'm adding power management to the nvme driver, and I'm exposing
exactly one knob via sysfs: the maximum permissible latency.  This
isn't a power domain issue, and it has no dependencies -- it's
literally just the maximum latency that the driver may impose on I/O
for power saving purposes.

ISTM userspace should be able to specify its own latency tolerance in
a uniform way, and dev_pm_qos seems like the natural interface for
this, except that I cannot find a single instance in the tree of *any*
driver using it via the notifier mechanism.  I can find two drivers
that do it using dev_pm_qos_expose_latency_tolerance(), and both are
LPSS drivers?

So: should I be exposing .set_latency_tolerance() or should I just use
a custom sysfs attribute?  Or both?
