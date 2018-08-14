From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 14 Aug 2018 16:16:41 -0700
Subject: [PATCH] Bugfix for handling of shadow doorbell buffer.
In-Reply-To: <20180814225716.GA3224@localhost.localdomain>
References: <20180814221735.62804-1-wnukowski@google.com>
 <20180814225716.GA3224@localhost.localdomain>
Message-ID: <CA+55aFw-Fed2QJCYBosGby71AsXAVKGq8mG-HYR13rEnD9V2Lg@mail.gmail.com>

Guys, you're both wrong.

On Tue, Aug 14, 2018@03:17:35PM -0700, Michal Wnukowski wrote:
>
> With memory barrier in place, the volatile keyword around *dbbuf_ei is
> redundant.

No. The memory barrier enforces _ordering_, but it doesn't enforce
that the accesses are only done once. So when you do

>              *dbbuf_db = value;

to write to dbbuf_db, and

>    *dbbuf_ei

to read from dbbuf_ei, without the volatile the write (or the read)
could be done multiple times, which can cause serious confusion.

So the "mb()" enforces ordering, and the volatile means that the
accesses will each be done as one single access.

Two different issues entirely.

However, there's a more serious problem with your patch:

> +             /*
> +              * Ensure that the doorbell is updated before reading
> +              * the EventIdx from memory
> +              */
> +             mb();

Good comment. Except what about the other side?

When you use memory ordering rules, as opposed to locking, there's
always *two* sides to any access order. There's this "write dbbuf_db"
vs "read dbbuf_ei" ordering.

But there's the other side: what about the side that writes dbbuf_ei,
and reads dbbuf_db?

I'm assuming that's the actual controller hardware, but it needs a
comment about *that* access being ordered too, because if it isn't,
then ordering this side is pointless.

On Tue, Aug 14, 2018@3:56 PM Keith Busch <keith.busch@linux.intel.com> wrote:
>
> You just want to ensure the '*dbbuf_db = value' isn't reordered, right?
> The order dependency might be more obvious if done as:
>
>         WRITE_ONCE(*dbbuf_db, value);
>
>         if (!nvme_dbbuf_need_event(READ_ONCE(*dbbuf_ei), value, old_value))
>                 return false;
>
> And 'volatile' is again redundant.

Yes, using READ_ONCE/WRITE_ONCE obviates the need for volatile, but it
does *not* impose a memory ordering.

It imposes an ordering on the compiler, but not on the CPU, so you
still want the "mb()" there (or the accesses need to be to uncached
memory or something, but then you should be using "readl()/writel()",
so that's not the case here).

                 Linus
