From: luto@kernel.org (Andy Lutomirski)
Date: Thu, 20 Apr 2017 11:56:15 -0700
Subject: [PATCH v2 0/2] nvme APST quirk updates, take two
In-Reply-To: <dec142aa-ffd8-984e-adcc-f0e6bf0a4e0b@kernel.dk>
References: <cover.1492704577.git.luto@kernel.org>
 <9cd43193-af6b-2cb1-3951-5fa569bf1f31@kernel.dk>
 <b6da572f-2c50-81b4-64b0-73abdd124408@grimberg.me>
 <20170420162925.GB25259@localhost.localdomain>
 <90f94a38-7508-ba80-aa14-827e758dd418@kernel.dk>
 <2a988a17-eb37-58ca-edd7-a11d4bb61f5a@kernel.dk>
 <CALCETrUQ_npTbm7eEeoFJP3V9y-keq9bjS0hD+t=k-AXSDMteA@mail.gmail.com>
 <dec142aa-ffd8-984e-adcc-f0e6bf0a4e0b@kernel.dk>
Message-ID: <CALCETrX=vXDZEJRtVpDZ8LO5eqgNF5-3gigKH0WYjYE0Ex_Y1g@mail.gmail.com>

On Thu, Apr 20, 2017@10:08 AM, Jens Axboe <axboe@kernel.dk> wrote:
> On 04/20/2017 11:06 AM, Andy Lutomirski wrote:
>>
>>
>> On Apr 20, 2017 9:38 AM, "Jens Axboe" <axboe@kernel.dk <mailto:axboe@kernel.dk>> wrote:
>>
>>     On 04/20/2017 10:30 AM, Jens Axboe wrote:
>>     > On 04/20/2017 10:29 AM, Keith Busch wrote:
>>     >> On Thu, Apr 20, 2017@07:15:15PM +0300, Sagi Grimberg wrote:
>>     >>>
>>     >>>>> Hi Jens-
>>     >>>>>
>>     >>>>> These are just the quirk updates, split out.  The patches are
>>     >>>>> unchanged.
>>     >>>>>
>>     >>>>> I think that, even if we want to apply a broader quirk for 4.11, we
>>     >>>>> should still apply these so that we can cleanly revert the broader
>>     >>>>> quirk later.  IOW, let's get the known regressions fixed before we
>>     >>>>> get too excited about the unknown regressions.
>>     >>>>
>>     >>>> This looks good to me, and 4.11 appropriate. I'll expedite this
>>     >>>> through the block tree, if Keith/Sagi/Christoph agrees on this
>>     >>>> being the right approach for 4.11.
>>     >>>
>>     >>> I'm perfectly fine with this going to 4.11
>>     >>
>>     >> All good with me as well.
>>     >>
>>     >> Reviewed-by: Keith Busch <keith.busch at intel.com <mailto:keith.busch at intel.com>>
>>     >
>>     > Great, I have queued it up.
>>
>>     Spoke too soon. Andy, did you compile this?
>>
>>     drivers/nvme/host/core.c: In function ?nvme_init_identify?:
>>     drivers/nvme/host/core.c:1524:6: error: ?force_apst? undeclared (first use in this function)
>>       if (force_apst && (ctrl->quirks & NVME_QUIRK_NO_DEEPEST_PS)) {
>>           ^~~~~~~~~~
>>     drivers/nvme/host/core.c:1524:6: note: each undeclared identifier is reported only once for each function it appears in
>>
>>     No, you did not.
>>
>>
>> I compiled the end result but not the middle.  D'oh.  Better version coming in an hour or two.
>
> This is from the end-result. I think you compiled the previous series,
> but not the revised v2 one you sent out. Because none of those patches
> add force_apst.

I was differently dumb.  I did git rebase -i and rearranged
everything, but I did git rebase --continue before running make, so I
tested the buggy patch with the patch that added force_apst on top.

Anyway, this time I'm going to compile, boot, and play with the exact
patches I send before I send them.  (Sadly, removing the debug patch
from the series has made this type of testing harder.  Oh well.)

--Andy
