From: axboe@fb.com (Jens Axboe)
Date: Thu, 22 Sep 2016 14:43:43 -0600
Subject: [PATCH v4 0/3] nvme power saving
In-Reply-To: <CALCETrV6GAZFG+cjdQrJpP7wVphfeRd=+UeTQcs5-iQYxNk6XA@mail.gmail.com>
References: <cover.1474049701.git.luto@kernel.org>
 <13b0fe95-01b8-89d7-df76-efc1aa14b27a@fb.com>
 <CALCETrV6GAZFG+cjdQrJpP7wVphfeRd=+UeTQcs5-iQYxNk6XA@mail.gmail.com>
Message-ID: <0a2ffd51-6e0f-7db3-8135-84317d8f77bc@fb.com>

On 09/22/2016 02:11 PM, Andy Lutomirski wrote:
> On Thu, Sep 22, 2016@7:23 AM, Jens Axboe <axboe@fb.com> wrote:
>>
>> On 09/16/2016 12:16 PM, Andy Lutomirski wrote:
>>>
>>> Hi all-
>>>
>>> Here's v4 of the APST patch set.  The biggest bikesheddable thing (I
>>> think) is the scaling factor.  I currently have it hardcoded so that
>>> we wait 50x the total latency before entering a power saving state.
>>> On my Samsung 950, this means we enter state 3 (70mW, 0.5ms entry
>>> latency, 5ms exit latency) after 275ms and state 4 (5mW, 2ms entry
>>> latency, 22ms exit latency) after 1200ms.  I have the default max
>>> latency set to 25ms.
>>>
>>> FWIW, in practice, the latency this introduces seems to be well
>>> under 22ms, but my benchmark is a bit silly and I might have
>>> measured it wrong.  I certainly haven't observed a slowdown just
>>> using my laptop.
>>>
>>> This time around, I changed the names of parameters after Jay
>>> Frayensee got confused by the first try.  Now they are:
>>>
>>>  - ps_max_latency_us in sysfs: actually controls it.
>>>  - nvme_core.default_ps_max_latency_us: sets the default.
>>>
>>> Yeah, they're mouthfuls, but they should be clearer now.
>>
>>
>> The only thing I don't like about this is the fact that's it's a driver private thing. Similar to ALPM on SATA, it's yet another knob that needs to be set. It we put it somewhere generic, then at least we could potentially use it in a generic fashion.
>
> Agreed.  I'm hoping to hear back from Rafael soon about the dev_pm_qos
> thing.
>
>>
>> Additionally, it should not be on by default.
>
> I think I disagree with this.  Since we don't have anything like
> laptop-mode AFAIK, I think we do want it on by default.  For the
> server workloads that want to consume more idle power for faster
> response when idle, I think the servers should be willing to make this
> change, just like they need to disable overly deep C states, etc.
> (Admittedly, unifying the configuration would be nice.)

I can see two reasons why we don't want it the default:

1) Changes like this has a tendency to cause issues on various types of
hardware. How many NVMe devices have you tested this on? ALPM on SATA
had a lot of initial problems, where slowed down some SSDs unberably.

2) Rolling out a new kernel and seeing a weird slowdown on some
workloads usually costs a LOT of time to investigate and finally get to
the bottom of. It's not that server setups don't want to make this
change, it's usually that they don't know about it until it's caused
some issue in production (eg slowdown, or otherwise).

Either one of those is enough, in my book, to default it to off. I ran
it on my laptop and saw no power saving wins, unfortunately, for what
it's worth.

-- 
Jens Axboe
