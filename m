From: keith.busch@intel.com (Keith Busch)
Date: Tue, 9 Dec 2014 16:15:04 +0000 (UTC)
Subject: [PATCH] misc: Increase available dyanmic minors
In-Reply-To: <3419037.dh84oOupWY@wuerfel>
References: <1418079710-30968-1-git-send-email-keith.busch@intel.com>
 <3419037.dh84oOupWY@wuerfel>
Message-ID: <alpine.LNX.2.00.1412091507080.3973@localhost.lm.intel.com>

On Tue, 9 Dec 2014, Arnd Bergmann wrote:
> On Monday 08 December 2014 16:01:50 Keith Busch wrote:
>> This increases the number of available miscellaneous character device
>> dynamic minors from 63 to the max minor, 1M.
>>
>> Dynamic minor previously started at 63 and went down to zero. That's not
>> enough in some situations, and also eventually creates a collision with
>> 'psaux' misc device. This patch starts minors at the last defined misc
>> minor (255) and works up to the max possible.
>>
>> Signed-off-by: Keith Busch <keith.busch at intel.com>
>
> I guess this will break support for ancient user space tools, and
> possibly also old file systems that do not support more than 8-bit
> minor numbers. I would assume that it's ok, but you definitely have
> to mention in the changelog that things might break and how you
> have concluded that this is safe enough.

Sure, I can call this out in the change log. I hadn't considered file
systems on a character device. Tooling as well.

If a character device is so tightly coupled to such legacy tools, maybe
they should register a static minor, and this patch makes 63 additional
ones available. Does that sound reasonable?

> If you cannot come up with a good reasoning, it might be better
> to combine both and use up the traditional dynamic minor numbers
> before using the >255 range.

A problem with the existing method is that anyone can use a number in the
range it's dynamically allocating from. Once you encounter a collision,
all following dynamic misc_device registration will fail. Most of the
defined minors in that range are marked unused, but PSMOUSE_MINOR is
still used.

If we continue using the traditional dynamic allocator, the component
registering as dynamic races against the one registering with its static,
so that doesn't sound right.
