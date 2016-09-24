From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Sat, 24 Sep 2016 11:31:11 -0700
Subject: [PATCH v3] add u64 number parser
In-Reply-To: <57e69b53.MIvVzLk8rJW7sEVb%james.smart@broadcom.com>
References: <57e69b53.MIvVzLk8rJW7sEVb%james.smart@broadcom.com>
Message-ID: <CAADWXX9cJLw2y61rOe0Bd2usCUcPOPrjFcvPXfhKXyk9vDTRHQ@mail.gmail.com>

On Sat, Sep 24, 2016@8:27 AM, James Smart <james.smart@broadcom.com> wrote:
>
> add u64 number parser
>
> Prior patch revised to use kasprintf.
> Modified match_number to use kasprintf as well

Why would you do this? It's insane. kasprintf() is not the right thing
at all to use for anything like this. It appears that you want to use
strncpy() or something. Or you could just avoid the extra copy
entirely in 99% of all cases and just use simple_strtol() and check
that the end didn't overflow the substring, which it presumably never
does anyway.

Yes, the stupid code is already disgustingly bad. But let's not make
it *worse*, for chrissake!

               Linus
