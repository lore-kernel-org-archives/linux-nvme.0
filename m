From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Fri, 16 Sep 2016 16:54:31 +0100
Subject: Should drivers like nvme let userspace control their latency
 via dev_pm_qos?
In-Reply-To: <CALCETrUsgA2H=TuwZMuwW2XpXZ7KPrEYu6xckmTbhU8oZwr6Nw@mail.gmail.com>
References: <CALCETrUsgA2H=TuwZMuwW2XpXZ7KPrEYu6xckmTbhU8oZwr6Nw@mail.gmail.com>
Message-ID: <20160916165431.1f2e6df5@lxorguk.ukuu.org.uk>

On Fri, 16 Sep 2016 08:26:03 -0700
Andy Lutomirski <luto@kernel.org> wrote:

> I'm adding power management to the nvme driver, and I'm exposing
> exactly one knob via sysfs: the maximum permissible latency.  This
> isn't a power domain issue, and it has no dependencies -- it's
> literally just the maximum latency that the driver may impose on I/O
> for power saving purposes.

Why is this in the driver. Surely the latency is a property of the
request queue and the requests being made. Now it may well be that its
implement as min(list-of-queues) but a device sysfs node seems a strange
place to stick it.

Alan
