From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Sat, 27 May 2017 09:14:09 -0700
Subject: [PATCH 1/2] nvme: Wait at least 6000ms before entering the
 deepest idle state
In-Reply-To: <CALCETrXc3da8q-7ZYrh3v+fk1CbeTXqOdoPTfDbb4h=G+R+Tdg@mail.gmail.com>
References: <cover.1495663545.git.luto@kernel.org>
 <6760ae9459ba19657f8009a9231b97a71114a1e5.1495663545.git.luto@kernel.org>
 <20170526085225.GA28728@lst.de>
 <CALCETrXc3da8q-7ZYrh3v+fk1CbeTXqOdoPTfDbb4h=G+R+Tdg@mail.gmail.com>
Message-ID: <CA+55aFw67v202_ynBZoQE6BywP-esgB7Go0m9sZyYdChQ1X1Vg@mail.gmail.com>

On Sat, May 27, 2017@9:08 AM, Andy Lutomirski <luto@kernel.org> wrote:
> On Fri, May 26, 2017@1:52 AM, Christoph Hellwig <hch@lst.de> wrote:
>>
>> Just following a somewhat odd and arbitray policy from another driver
>> that doesn't fix anything by itself certainly isn't stable material.
>
> I'd be fine with skipping this patch entirely at least until we find
> some evidence that it solves a problem instead.

It's certainly worth waiting for confirmation that it actually changes
anything, but I did want to pipe up to say that "following a somewhat
odd and arbitrary policy from another driver" is not wrong per se.

In fact, on the power management we pretty much had to do that, simply
because that "odd and arbitrary policy" (Windows behavior) was the
only thing that had ever been tested by anybody. Same goes for a lot
of PCI subsystem behavior etc.

So it's not wrong per se to just emulate others' behaviors. But yes,
we should have some reason for doing so, not just doing so blindly.

           Linus
