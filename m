From: luto@kernel.org (Andy Lutomirski)
Date: Thu, 15 Jun 2017 10:22:59 -0700
Subject: [PATCH] nvme: fix string_matches() helper
In-Reply-To: <20170614063823.GA9125@lst.de>
References: <20170613130709.7150-1-hch@lst.de>
 <CALCETrXuDtiU-9cRkAcP_=524MpVjOmrgL5vb732iaiYwGH2BA@mail.gmail.com>
 <20170614063823.GA9125@lst.de>
Message-ID: <CALCETrWAUVZqoDOLUvL2nhZPd5gqwZecGSn+TYdDWvEMM6+RQg@mail.gmail.com>

On Tue, Jun 13, 2017@11:38 PM, Christoph Hellwig <hch@lst.de> wrote:
> On Tue, Jun 13, 2017@08:42:59AM -0700, Andy Lutomirski wrote:
>> On Tue, Jun 13, 2017@6:07 AM, Christoph Hellwig <hch@lst.de> wrote:
>> > NVMe "ASCII" strings are not nul-terminated and can use up every single
>> > byte in the field.  Thus use strnlen to determine the match length instead
>> > of possibly overrunning the field.
>> >
>> > Signed-off-by: Christoph Hellwig <hch at lst.de>
>> > ---
>> >  drivers/nvme/host/core.c | 4 +---
>> >  1 file changed, 1 insertion(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> > index 434b18863895..2658a3a3cbb5 100644
>> > --- a/drivers/nvme/host/core.c
>> > +++ b/drivers/nvme/host/core.c
>> > @@ -1581,9 +1581,7 @@ static bool string_matches(const char *idstr, const char *match, size_t len)
>> >         if (!match)
>> >                 return true;
>> >
>> > -       matchlen = strlen(match);
>> > -       WARN_ON_ONCE(matchlen > len);
>> > -
>> > +       matchlen = strnlen(match, len);
>>
>> "match" refers to the string in the quirk table, which should be a
>> plain C string.  Are you hitting this in practice?
>
> No, but I've just written some other code that deals with NVMe
> strings, and took extra care of bounds protection.
>
> But yes, given the strlen is on the match we should be ok as long
> as the WARN_ON_ONCE also does an early return.  Does that sound ok
> to you?

Sounds good to me.
