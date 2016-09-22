From: axboe@fb.com (Jens Axboe)
Date: Thu, 22 Sep 2016 16:07:11 -0600
Subject: [PATCH v4 0/3] nvme power saving
In-Reply-To: <20160922221613.GC14301@keith>
References: <cover.1474049701.git.luto@kernel.org>
 <13b0fe95-01b8-89d7-df76-efc1aa14b27a@fb.com>
 <CALCETrV6GAZFG+cjdQrJpP7wVphfeRd=+UeTQcs5-iQYxNk6XA@mail.gmail.com>
 <0a2ffd51-6e0f-7db3-8135-84317d8f77bc@fb.com>
 <1474580016.15303.31.camel@linux.intel.com> <20160922221613.GC14301@keith>
Message-ID: <99658698-219c-02c2-2f79-ae673693cbcf@fb.com>

On 09/22/2016 04:16 PM, Keith Busch wrote:
> On Thu, Sep 22, 2016@02:33:36PM -0700, J Freyensee wrote:
>> ...and some SSDs don't even support this feature yet, so the number of
>> different NVMe devices available to test initially will most likely be
>> small (like the Fultondales I have, all I could check is to see if the
>> code broke anything if the device did not have this power-save
>> feature).
>>
>> I agree with Jens, makes a lot of sense to start with this feature
>> 'off'.
>>
>> To 'advertise' the feature, maybe make the feature a new selection in
>> Kconfig?  Example, initially make it "EXPERIMENTAL", and later when
>> more devices implement this feature it can be integrated more tightly
>> into the NVMe solution and default to on.
>
> Should we just leave the kernel out of this then? I bet we could script
> this feature in user space.

That actually might be the sanest approach. Then we can tie it into some
generic PM latency setup in the future, from the kernel, when it's
available.

That way we don't get left with some odd NVMe specific PM sysfs knob
that is exposed to userland.

-- 
Jens Axboe
