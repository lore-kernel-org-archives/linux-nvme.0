From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Fri, 11 Dec 2015 17:42:27 +0200
Subject: [PATCHv3] printf: Add format for 8-byte EUI-64 type
In-Reply-To: <20151210150609.GA23337@localhost.localdomain>
References: <1449702413-25598-1-git-send-email-keith.busch@intel.com>
 <1449703300.25389.95.camel@perches.com>
 <20151210150609.GA23337@localhost.localdomain>
Message-ID: <CAHp75VejtpH=Dwb=LgdSgL9bs5SXB-dqrEWdGDSg8mRLDgm-Hw@mail.gmail.com>

+Rasmus.

On Thu, Dec 10, 2015@5:06 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Wed, Dec 09, 2015@03:21:40PM -0800, Joe Perches wrote:
>> On Wed, 2015-12-09@16:06 -0700, Keith Busch wrote:
>> > MAC addresses may be formed using rules based on EUI-64, which is 2 bytes
>> > longer than a typical 6-byte MAC. This patch adds a long specifier to
>> > the %pM format to support the extended unique identifier.
>> >
>> > Since there are multiple valid possible permutations of format specifiers,
>> > the decoding is done in a loop, and the default ':' separator is
>> > initialized at declaration time. A side effect of this allows 'F' and
>> > 'R' both be specified, so these are appended to the documentation.
>>
>> Just thought of this:
>>
>> An alternative is using a format of "%8phC"
>>
>> Is there a use case for a bluetooth or FDDI EUI-64?
>
> *facepalm*
>
> I didn't know that format, but it satisfies my needs. I am not aware of
> bluetooth or fddi using eui64, so I've no problem withdrawing the patch.
> I'll just fix up the one that depended on it.

Of course you might try to add reversed support for %*ph.

Also you may consider print_hex_dump() [hex_dump_to_buffer()], though
it looks like overkill in particular here.

-- 
With Best Regards,
Andy Shevchenko
