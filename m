From: keith.busch@linux.intel.com (Keith Busch)
Date: Tue, 14 Aug 2018 17:49:40 -0600
Subject: [PATCH] Bugfix for handling of shadow doorbell buffer.
In-Reply-To: <CA+55aFw-Fed2QJCYBosGby71AsXAVKGq8mG-HYR13rEnD9V2Lg@mail.gmail.com>
References: <20180814221735.62804-1-wnukowski@google.com>
 <20180814225716.GA3224@localhost.localdomain>
 <CA+55aFw-Fed2QJCYBosGby71AsXAVKGq8mG-HYR13rEnD9V2Lg@mail.gmail.com>
Message-ID: <20180814234940.GB3224@localhost.localdomain>

On Tue, Aug 14, 2018@04:16:41PM -0700, Linus Torvalds wrote:
> On Tue, Aug 14, 2018@3:56 PM Keith Busch <keith.busch@linux.intel.com> wrote:
> >
> > You just want to ensure the '*dbbuf_db = value' isn't reordered, right?
> > The order dependency might be more obvious if done as:
> >
> >         WRITE_ONCE(*dbbuf_db, value);
> >
> >         if (!nvme_dbbuf_need_event(READ_ONCE(*dbbuf_ei), value, old_value))
> >                 return false;
> >
> > And 'volatile' is again redundant.
> 
> Yes, using READ_ONCE/WRITE_ONCE obviates the need for volatile, but it
> does *not* impose a memory ordering.
> 
> It imposes an ordering on the compiler, but not on the CPU, so you
> still want the "mb()" there

I mistakenly recalled memory-barriers.txt mentioned order was enforced
on the CPU, but that's true only for overlapping memory, which this is
not. Thanks for the correction.
