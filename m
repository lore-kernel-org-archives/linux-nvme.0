From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Sep 2017 21:26:45 +0200
Subject: [PATCH] string.h: un-fortify memcpy_and_pad
In-Reply-To: <20170905182326.15681-1-mwilck@suse.com>
References: <CAK8P3a0u5w1C+L6t9h5+4fu0gt79u68B+txhF6adAT3MVfwW3Q@mail.gmail.com>
 <20170905182326.15681-1-mwilck@suse.com>
Message-ID: <CAK8P3a1WnD6G+VU4vg3pQ-TJjLmr+o0c0fZTRHg=FQqpiQ=fzA@mail.gmail.com>

On Tue, Sep 5, 2017@8:23 PM, Martin Wilck <mwilck@suse.com> wrote:
> The way I'd implemented the new helper memcpy_and_pad  with
> __FORTIFY_INLINE caused compiler warnings for certain kernel
> configurations.
>
> This helper is only used in a single place at this time, and thus
> doesn't benefit much from fortification. So simplify the code
> by dropping fortification support for now.
>
> Fixes: 3c5fa8cd18f8 "string.h: add memcpy_and_pad()"
> Signed-off-by: Martin Wilck <mwilck at suse.com>

Looks good to me,

Acked-by: Arnd Bergmann <arnd at arndb.de>

I've added this to my randconfig testing tree, if you don't hear anything
from me by tomorrow, you can assume that it caused no other failures.

      Arnd
