From: luto@kernel.org (Andy Lutomirski)
Date: Sun, 19 Aug 2018 21:27:17 -0700
Subject: memleak on hot unplug
In-Reply-To: <2186ac17-6079-50be-d6c0-ff42abc555f0@grimberg.me>
References: <7516FE0D-1C04-4110-98C4-77810BC63A9A@javigon.com>
 <2186ac17-6079-50be-d6c0-ff42abc555f0@grimberg.me>
Message-ID: <CALCETrW79fhoHsY757+3114DXRdU7fTmp-ibCYY4P16Ow65w1Q@mail.gmail.com>

On Fri, Aug 17, 2018@3:09 PM, Sagi Grimberg <sagi@grimberg.me> wrote:
>
> On 08/14/2018 01:34 AM, Javier Gonz?lez wrote:
>>
>> While reviewing Hannes' sysfs patches on top of Christoph's nvme-4.19, I
>> came across a leak when hot unplugging the controller. The leak seems to
>> be introduced by nvme_init_ctrl:dev_pm_qos_update_user_latency_tolerance()
>>
>> A quick check shows that neither dev_pm_qos_expose_latency_tolerance()
>> nor dev_pm_qos_hide_latency_tolerance() are being called in
>> nvme_init_identify().
>>
>> I don't know this part enough to come up with a fix, but I hop it is
>> enough info for you.
>
>
> CCing Andy.

I read this email a couple times, and it's not at all clear to me
what's leaking or what the circumstances are.  Javier, are you saying
that an untimely hotplug is causing an early exit from
nvme_init_identify() and that something is leaking when that happens?
Do you know what is leaking?

The driver code is supposed to free the pm_qos structures by itself.
Is that not happening?
