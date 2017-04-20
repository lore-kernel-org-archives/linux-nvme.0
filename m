From: luto@kernel.org (Andy Lutomirski)
Date: Thu, 20 Apr 2017 09:01:29 -0700
Subject: [PATCH 0/5] nvme APST fixes/improvements for 4.11
In-Reply-To: <20170420051933.GA10985@lst.de>
References: <cover.1492656278.git.luto@kernel.org>
 <20170420030959.GC23085@kernel.dk>
 <CALCETrWY_Wc0n24hfwj53aH-gc4xeRCuU+=O78dui9Mm7k0jEw@mail.gmail.com>
 <CALCETrWCQh1dOkqn_g6QVXpLR8U7BjnfOtsSPZ+DCxK5hf_sHw@mail.gmail.com>
 <20170420051933.GA10985@lst.de>
Message-ID: <CALCETrXH5D1LPWZPtmyeHHB=PsOj7KWStWhMiQZ_5x31_NKpww@mail.gmail.com>

On Wed, Apr 19, 2017@10:19 PM, Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Apr 19, 2017@09:52:17PM -0700, Andy Lutomirski wrote:
>> > I can make it so that force_apst=0 means no APST and force_apst=1 mean
>> > yes APST and we could try again with a quirk list for 4.12.  There's a
>> > decent chance that a few more weeks with Ubuntu having APST on will
>> > shake out all the problems fairly quickly.
>>
>> Here's a more concrete and more sensible proposal:
>
> Can we just have force_apst=on to force it on, force_apst=off to turn
> it off, and leave it with that?  And yes, I mean the strings instead
> of the weird numbers.

That's essentially what the patch I emailed here does -- it's a
regular bool param, so force_apst=1, force_apst=Y, and force_apst=y
all mean the same thing.  I can just leave it like that.
