From: luto@amacapital.net (Andy Lutomirski)
Date: Wed, 19 Apr 2017 21:52:17 -0700
Subject: [PATCH 0/5] nvme APST fixes/improvements for 4.11
In-Reply-To: <CALCETrWY_Wc0n24hfwj53aH-gc4xeRCuU+=O78dui9Mm7k0jEw@mail.gmail.com>
References: <cover.1492656278.git.luto@kernel.org>
 <20170420030959.GC23085@kernel.dk>
 <CALCETrWY_Wc0n24hfwj53aH-gc4xeRCuU+=O78dui9Mm7k0jEw@mail.gmail.com>
Message-ID: <CALCETrWCQh1dOkqn_g6QVXpLR8U7BjnfOtsSPZ+DCxK5hf_sHw@mail.gmail.com>

On Wed, Apr 19, 2017@8:55 PM, Andy Lutomirski <luto@kernel.org> wrote:
> On Wed, Apr 19, 2017@8:10 PM, Jens Axboe <axboe@kernel.dk> wrote:
>> On Wed, Apr 19 2017, Andy Lutomirski wrote:
>>> Sorry for waiting so long for this.  I was waiting for feedback from
>>> Samsung, but they haven't root-caused the issue yet, and I should
>>> have just done this from the beginning.
>>>
>>> This series makes APST more debuggable and updates the quirk list.
>>> The quirks I'm aware of are:
>>>
>>>  - Samsung 950 series SSDs in Dell XPS 15 9550 and Precision 5510
>>>    laptops (which are essentially the same laptop) can lose their
>>>    PCIe link if they're allowed to use the deepest APST state.
>>>    Samsung engineers have an affected system and are working on
>>>    it.  The same exact SSDs in other machines (even an XPS 13)
>>>    seem to work fine.
>>>
>>>  - One Toshiba device malfunctions if APST is used at all.
>>
>> You need to split this series in two, patches 1-3 can wait. For 4.11,
>> all we need to do is turn off APST on any device that potentially has
>> this problem.
>>
>>> One thing that improves my confidence that there aren't too many
>>> more problems with APST is that Ubuntu has backported APST to Zesty,
>>> so it's already gotten a bit of testing in a widely used (if very
>>> new) release.
>>
>> Honestly, I think the best path for 4.11 is to turn off APST by default,
>> make it opt-in instead. I don't share your optimism here, as I made
>> clear back from before we even merged this feature.
>>
>>
>
> I can make it so that force_apst=0 means no APST and force_apst=1 mean
> yes APST and we could try again with a quirk list for 4.12.  There's a
> decent chance that a few more weeks with Ubuntu having APST on will
> shake out all the problems fairly quickly.

Here's a more concrete and more sensible proposal:

For 4.11:

force_apst=0: Default.  APST off on all Samsung 950-like devices
regardless of what laptop and on the Toshiba device.
force_apst=1: Use APST except where known bad.  APST deepest state
disabled on Samsung 950-like devices on XPS 15 and Precision 5510.
APST off on the Toshiba device.
force_apst=2: APST fully on regardless of any quirks.

For 4.12-rc1: force_apst=0 works like force_apst=1, but we keep both
values for compatibility and in case we need to add another overly
broad quirk some day.

Would something like this make sense?
