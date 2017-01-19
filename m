From: luto@amacapital.net (Andy Lutomirski)
Date: Wed, 18 Jan 2017 19:07:55 -0800
Subject: [PATCH 2/3] nvme: Add a quirk mechanism that uses identify_ctrl
In-Reply-To: <20170118155647.GE8989@localhost.localdomain>
References: <cover.1484703713.git.luto@kernel.org>
 <66c502d8607570266163224149b1e7f613c65a45.1484703713.git.luto@kernel.org>
 <20170118155647.GE8989@localhost.localdomain>
Message-ID: <CALCETrV0ErBqbib9maJZZ0ta-ZnyVUZ=sdu1qi1=Kk2ygEE-OA@mail.gmail.com>

On Wed, Jan 18, 2017@7:56 AM, Keith Busch <keith.busch@intel.com> wrote:
> On Tue, Jan 17, 2017@05:54:19PM -0800, Andy Lutomirski wrote:
>> @@ -1351,6 +1394,15 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>>               return -EIO;
>>       }
>>
>> +     if (!ctrl->identified) {
>
> Part of the quirk is matching firmware revision. That potentially changes
> after a reset, but you only check the quirks the first time we initialise
> the controller. It's a little awkward to unmask the quirk out when it
> previously set for this, though, so maybe it's just as well to have the
> user reboot after a firmware upgrade fixes a quirk.
>
> Otherwise, looks good to me.

True.  I'll add a comment here for v2.

--Andy
