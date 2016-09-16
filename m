From: luto@amacapital.net (Andy Lutomirski)
Date: Fri, 16 Sep 2016 09:20:10 -0700
Subject: Should drivers like nvme let userspace control their latency via
 dev_pm_qos?
In-Reply-To: <20160916165431.1f2e6df5@lxorguk.ukuu.org.uk>
References: <CALCETrUsgA2H=TuwZMuwW2XpXZ7KPrEYu6xckmTbhU8oZwr6Nw@mail.gmail.com>
 <20160916165431.1f2e6df5@lxorguk.ukuu.org.uk>
Message-ID: <CALCETrWipKV-hmTYUL4itQ6Z0rtXuJMQ49VHv9BHc_3EM63jKA@mail.gmail.com>

On Fri, Sep 16, 2016 at 8:54 AM, One Thousand Gnomes
<gnomes@lxorguk.ukuu.org.uk> wrote:
> On Fri, 16 Sep 2016 08:26:03 -0700
> Andy Lutomirski <luto@kernel.org> wrote:
>
>> I'm adding power management to the nvme driver, and I'm exposing
>> exactly one knob via sysfs: the maximum permissible latency.  This
>> isn't a power domain issue, and it has no dependencies -- it's
>> literally just the maximum latency that the driver may impose on I/O
>> for power saving purposes.
>
> Why is this in the driver. Surely the latency is a property of the
> request queue and the requests being made. Now it may well be that its
> implement as min(list-of-queues) but a device sysfs node seems a strange
> place to stick it.
>

I'm not sure what you mean.  The whole device can be programmed to
take a nap when fully idle.  The driver can limit how deep that nap is
and thus how long the next request can be delayed while the device
wakes back up.

Unlike the very small number of in-tree users of this type of
mechanism that I can find, there are no busses or hard tolerances
involved.  The only effect is a power consumption vs I/O performance
tradeoff.

--Andy
