From: axboe@fb.com (Jens Axboe)
Date: Fri, 26 Aug 2016 09:06:31 -0600
Subject: [PATCH] nvme: Fix nvme_get/set_features() with a NULL result
 pointer
In-Reply-To: <CALCETrV+ndPPGhoO5zwQWC5knvrRF8NKtk2hx0CgCqg60=vGmQ@mail.gmail.com>
References: <f0eca21161c9ec5f81e9591741463ec3883cb931.1472035881.git.luto@kernel.org>
 <20160825073810.GA18622@lst.de>
 <CALCETrWsJCwO6D9=LsYOV5ghbXMc_MdOYgXm1qzarJ1-cizuXw@mail.gmail.com>
 <c199d91a-0f6d-6ef7-f8f8-9b8b28430564@fb.com>
 <CALCETrV+ndPPGhoO5zwQWC5knvrRF8NKtk2hx0CgCqg60=vGmQ@mail.gmail.com>
Message-ID: <8f272cfe-6cc9-0699-6613-49dc09152c65@fb.com>

On 08/26/2016 08:31 AM, Andy Lutomirski wrote:
> On Aug 25, 2016 4:20 PM, "Jens Axboe" <axboe@fb.com> wrote:
>>
>> On 08/25/2016 01:54 AM, Andy Lutomirski wrote:
>>>
>>> On Thu, Aug 25, 2016@12:38 AM, Christoph Hellwig <hch@lst.de> wrote:
>>>>
>>>> Ooops, yes.
>>>>
>>>> Are you looking into new nvme_set_features users?  Another thing
>>>> we need to tackle is either replacing dma_addr argument with a
>>>> a real kernel pointer (or just kill it until users show up)
>>>
>>>
>>> I am, and I have a patch to do the former (and to add a length
>>> argument).  But that's not -stable material.
>>>
>>> While I have your attention: the new use is to enable APST (power
>>> saving).  In theory, it seems like I should integrate with dev_pm_qos
>>> so that the standard interface for setting a latency limit will work,
>>> but, on brief inspection, there are literally no drivers in the entire
>>> tree that do this.  Am I missing something?  My current draft patch
>>> just adds a sysfs attribute.  (It saves a *lot* of power on my laptop,
>>> so supporting APST is worth doing.)
>>
>>
>> Care to send out what you have? I'd be interested in seeing how much I
>> can save on my laptop, haven't played with APST yet.
>
> https://git.kernel.org/cgit/linux/kernel/git/luto/linux.git/log/?h=nvme/power
>
> There are some todos:
>
>  - Default to a nonzero latency (e.g. 7ms?  My SSD needs 5.5ms for max
> power saving.)  To test it, write something like 7000000 to
> apst_max_latency_ns.
>
>  - Add a real changelog.
>
>  - Optionally add a sysfs binfile or other interface to allow
> uploading an entire custom table.
>
>  - Consider *deleting* the SCSI translation layer's power saving code.
> It looks almost entirely bogus to me.  It has an off-by-one in its
> NPSS handling, it hardcodes power state indices which is total BS, it
> ignores the distinction between operational and non-operational states
> (which I think matters for non-APST usage).  It also seems likely to
> be that it's never been used, since it's one of the formerly
> crashy-looking set_features users.
>
> You can inspect what it's doing with something like:
>
> # nvme get-feature -f 0x0c -H -s 0 /dev/nvme0
>
> if you have nvme-cli installed.

Thanks, I'll give it a whirl. One issue in a previous patch - you have
nvme_set_features() take a const buffer, which makes sense. But then you
pass it to __nvme_submit_sync_cmd(), which of course takes both
read/write commands, and hence the buffer isn't const.

-- 
Jens Axboe
