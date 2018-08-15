From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 14 Aug 2018 19:02:27 -0700
Subject: [PATCH] Bugfix for handling of shadow doorbell buffer.
In-Reply-To: <d57e77d8-88e2-b92a-9545-7118de4d8065@google.com>
References: <20180814221735.62804-1-wnukowski@google.com>
 <20180814225716.GA3224@localhost.localdomain>
 <CA+55aFw-Fed2QJCYBosGby71AsXAVKGq8mG-HYR13rEnD9V2Lg@mail.gmail.com>
 <d57e77d8-88e2-b92a-9545-7118de4d8065@google.com>
Message-ID: <CA+55aFxOc7_s-BbWJx-kyit-pH9m5fQJk6MSMJ57tFFvMtNh-w@mail.gmail.com>

On Tue, Aug 14, 2018@6:35 PM Michal Wnukowski <wnukowski@google.com> wrote:
>
> I got confused after comaring disassembly of this code with and
> without volatile keyword. Thanks for the correction.

Note that _usually_, the "volatile" has absolutely no impact. When
there is one read in the source code, it's almost always one access in
the generated code too.

That's particularly true if the read like this access do dbbuf_ei:

                if (!nvme_dbbuf_need_event(*dbbuf_ei, value, old_value))

is only used as an argument to a real function call.

But if that function is an inline function (which it is), and the
argument ends up getting used multiple times (which in this case it is
not), then it is possible in theory that gcc ends up saying "instead
of reading the value once, and keep it in a register, I'll just read
it again for the second time".

That happens rarely, but it _can_ happen without the volatile (or the
READ_ONCE()).

The advantage of READ_ONCE() over using "volatile" in a data structure
tends to be that you explicitly mark the memory accesses that you care
about. That's nice documentation for whoever reads the code (and it's
not unheard of that the _same_ data structure is sometimes volatile,
and sometimes not - for example, the data structure might be protected
by a lock - not volatile - but people might use an optimistic lockless
access to the value too - when it ends up being volatile. So then it's
really good to explicitly use READ_ONCE() for the volatile cases where
you show that you know that you're now doing something special that
really depends on memory ordering or other magic "access exactly once"
behavior.


> > I'm assuming that's the actual controller hardware, but it needs a
> > comment about *that* access being ordered too, because if it isn't,
> > then ordering this side is pointless.
>
> The other side in this case is not actual controller hardware, but
> virtual one (the regular hardware should rely on normal MMIO
> doorbells).

Ok, Maybe worth adding a one-line note about the ordering guarantees
by the virtual controller accesses.

                   Linus
