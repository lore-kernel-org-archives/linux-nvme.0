From: javier@javigon.com (=?utf-8?Q?Javier_Gonz=C3=A1lez?=)
Date: Mon, 20 Aug 2018 13:38:50 +0200
Subject: memleak on hot unplug
In-Reply-To: <CALCETrW79fhoHsY757+3114DXRdU7fTmp-ibCYY4P16Ow65w1Q@mail.gmail.com>
References: <7516FE0D-1C04-4110-98C4-77810BC63A9A@javigon.com>
 <2186ac17-6079-50be-d6c0-ff42abc555f0@grimberg.me>
 <CALCETrW79fhoHsY757+3114DXRdU7fTmp-ibCYY4P16Ow65w1Q@mail.gmail.com>
Message-ID: <4D2D2280-6E3F-487D-9A75-EF8BFD592941@javigon.com>

> On 20 Aug 2018,@06.27, Andy Lutomirski <luto@kernel.org> wrote:
> 
> On Fri, Aug 17, 2018@3:09 PM, Sagi Grimberg <sagi@grimberg.me> wrote:
>> On 08/14/2018 01:34 AM, Javier Gonz?lez wrote:
>>> While reviewing Hannes' sysfs patches on top of Christoph's nvme-4.19, I
>>> came across a leak when hot unplugging the controller. The leak seems to
>>> be introduced by nvme_init_ctrl:dev_pm_qos_update_user_latency_tolerance()
>>> 
>>> A quick check shows that neither dev_pm_qos_expose_latency_tolerance()
>>> nor dev_pm_qos_hide_latency_tolerance() are being called in
>>> nvme_init_identify().
>>> 
>>> I don't know this part enough to come up with a fix, but I hop it is
>>> enough info for you.
>> 
>> 
>> CCing Andy.
> 
> I read this email a couple times, and it's not at all clear to me
> what's leaking or what the circumstances are.  Javier, are you saying
> that an untimely hotplug is causing an early exit from
> nvme_init_identify() and that something is leaking when that happens?
> Do you know what is leaking?
> 
> The driver code is supposed to free the pm_qos structures by itself.
> Is that not happening?

I dag a bit more into the issue, and it seems that none of the pointers
in struct dev_pm_qos() are being freed when
dev_pm_qos_constraints_destroy() is called. In particular,
latency_tolerance_req is the source of the reported leak.

A dirty test shows that freeing latency_tolerance_req in this path
solves the leak. But again, I don't have enough knowledge on pm/qos to
send a properly tested patch. What I can say is that by the time we
reach nvme_free_ctrl(), dev->power.qos has already been freed, so we
cannot use the helpers like __dev_pm_qos_drop_user_request() at this
point in time.

Hope this helps.

Javier
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180820/1094f089/attachment.sig>
