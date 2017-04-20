From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 20 Apr 2017 10:38:23 -0600
Subject: [PATCH v2 0/2] nvme APST quirk updates, take two
In-Reply-To: <90f94a38-7508-ba80-aa14-827e758dd418@kernel.dk>
References: <cover.1492704577.git.luto@kernel.org>
 <9cd43193-af6b-2cb1-3951-5fa569bf1f31@kernel.dk>
 <b6da572f-2c50-81b4-64b0-73abdd124408@grimberg.me>
 <20170420162925.GB25259@localhost.localdomain>
 <90f94a38-7508-ba80-aa14-827e758dd418@kernel.dk>
Message-ID: <2a988a17-eb37-58ca-edd7-a11d4bb61f5a@kernel.dk>

On 04/20/2017 10:30 AM, Jens Axboe wrote:
> On 04/20/2017 10:29 AM, Keith Busch wrote:
>> On Thu, Apr 20, 2017@07:15:15PM +0300, Sagi Grimberg wrote:
>>>
>>>>> Hi Jens-
>>>>>
>>>>> These are just the quirk updates, split out.  The patches are
>>>>> unchanged.
>>>>>
>>>>> I think that, even if we want to apply a broader quirk for 4.11, we
>>>>> should still apply these so that we can cleanly revert the broader
>>>>> quirk later.  IOW, let's get the known regressions fixed before we
>>>>> get too excited about the unknown regressions.
>>>>
>>>> This looks good to me, and 4.11 appropriate. I'll expedite this
>>>> through the block tree, if Keith/Sagi/Christoph agrees on this
>>>> being the right approach for 4.11.
>>>
>>> I'm perfectly fine with this going to 4.11
>>
>> All good with me as well.
>>
>> Reviewed-by: Keith Busch <keith.busch at intel.com>
> 
> Great, I have queued it up.

Spoke too soon. Andy, did you compile this?

drivers/nvme/host/core.c: In function ?nvme_init_identify?:
drivers/nvme/host/core.c:1524:6: error: ?force_apst? undeclared (first use in this function)
  if (force_apst && (ctrl->quirks & NVME_QUIRK_NO_DEEPEST_PS)) {
      ^~~~~~~~~~
drivers/nvme/host/core.c:1524:6: note: each undeclared identifier is reported only once for each function it appears in

No, you did not.

-- 
Jens Axboe
