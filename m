From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Sun, 19 Jul 2015 18:18:09 +0300
Subject: [PATCH 3/3] block: Refuse adding appending a gapped integrity
 page to a bio
In-Reply-To: <55A7D4B6.9020101@kernel.dk>
References: <1436966356-8979-1-git-send-email-sagig@mellanox.com>
 <1436966356-8979-4-git-send-email-sagig@mellanox.com>
 <55A67C17.4080706@kernel.dk> <20150716092646.GA17712@infradead.org>
 <55A7D4B6.9020101@kernel.dk>
Message-ID: <55ABBFB1.7070201@dev.mellanox.co.il>

On 7/16/2015 6:58 PM, Jens Axboe wrote:
> On 07/16/2015 03:26 AM, Christoph Hellwig wrote:
>> On Wed, Jul 15, 2015@09:28:23AM -0600, Jens Axboe wrote:
>>> This chunk of code largely ends up being duplicated in several places
>>> with
>>> your patches, might be a good idea to pull that into a helper
>>> function. Then
>>> you can add the comment in one place as well :-)
>>
>> Basically all the bio_vec-related code in block-integrity is copy &
>> paste of the I/O path.  In the long run we'll need to refactor it by
>> adding bio_vec iteration helpers that can pick different anchors from
>> the bio.  But for now I think I'd rather have this quick fix.
>
> I wasn't asking for a refactor of the bio_vec integrity code (though
> that would be nice...), just that we don't add 3 more instances of 'does
> this gap with previous'.
>


Hi Jens,

I'll centralize the checks. No problem.

Oddly enough I still see "gappy" IO when I'm running
in the non-mq path. I suspect it's coming from the
elevator code somehow...

I assume no one tried to run it on non-mq right?

Sagi.
