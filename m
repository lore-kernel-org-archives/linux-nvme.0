From: dledford@redhat.com (Doug Ledford)
Date: Mon, 29 Jan 2018 17:28:19 -0500
Subject: Reconnect on RDMA device reset
In-Reply-To: <26056a83-2f81-6b56-7bbf-fcecfc4518d6@grimberg.me>
References: <CADZhsQqDFc1NWmsihOwki8_2Zj0HuYKC_N_x0jMnCtU9Rww1UA@mail.gmail.com>
 <f0a14240-1566-1bae-1b9f-21880bc3f3a0@grimberg.me>
 <CADZhsQqvK0LMd9sfxzz+x_5qVnoi4FP0FCFMsTPjpeXyqfXKew@mail.gmail.com>
 <77cef33e-a563-97fc-7ba6-69f220f1be84@grimberg.me>
 <1516904022.27592.187.camel@redhat.com>
 <26056a83-2f81-6b56-7bbf-fcecfc4518d6@grimberg.me>
Message-ID: <1517264899.27592.277.camel@redhat.com>

On Mon, 2018-01-29@22:36 +0200, Sagi Grimberg wrote:
> > 
> That is the case for nvme as well, but I was merely saying that device
> reset is not really a device removal. And this makes it hard for the ULP
> to understand what to do (or for me at least...)

OK, I get that the difference between the two is making it hard to
understand what to do.  But, the truth of the issue is that whether you
are doing a reset or a remove/add cycle, what *your* code needs to do
doesn't change.  For both cases, your code must A) drop everything on
the floor like a hot potato and B) restart from scratch.  The only thing
that's confusing you is that it's more or less assumed on a reset that
you would auto-restart, where as it isn't so clear that you would want
to do the same on a remove/add cycle.  I think the answer to your
question is: if the same device comes back that went away, then yes,
auto-restart would seem appropriate.  If you make that policy decision,
then the *only* difference between device reset and device hot-replug is
that you actually have to verify that the same device came back as went
away.

As an optional item, you could start a timer when the device disappears,
and if it takes more than, say, 10 minutes to reappear, you could cancel
the auto-restart on the basis that someone probably physically unplugged
and replugged the card and they might not want that.  But really, aside
from the fact that the hot plug flow needs you to check the same device
comes back, reset and hot plug have the exact same requirements/needs
and can be serviced by a single code path.

> > > > >   I'm not sure I understand why
> > > > > RDMA device resets manifest as DEVICE_REMOVAL events to ULPs (via
> > > > > rdma_cm or .remove_one via ib_client API). I think the correct interface
> > > > > would be suspend/resume semantics for RDMA device resets (similar to pm
> > > > > interface).
> > 
> > No, we can't do this.  Suspend/Resume is not the right model for an RDMA
> > device reset.  An RDMA device reset is a hard action that stops all
> > ongoing DMA regardless of its source.
> 
> Suspend also requires that.

But suspend has a locale semantic of "local to this machine" and usually
at least attempts to stop gracefully.  Because RDMA allows for things
such as a remote machine doing an RDMA READ when we suspend, we can't
even attempt the normal graceful shutdown and are left with only the
nuclear reset option.

In addition, if you reset a network card, the network card's registers
don't disappear, and your PCI MMIO region doesn't go away.  When you
reset an RDMA adapter, all of allocated memory regions for card
communications that have been handed out to kernel space, user space,
etc. *do* disappear.  That isn't really like the suspend semantic.  You
don't have the option of cleanly stopping things and quiescing the
system prior to suspend, because your basic communication channel is
gone already.  From this point of view, the hot remove semantic is very
fitting.  The entire card didn't get hot removed, but certainly all of
those allocated communication channels very well did.

> > Those sources include kernel
> > layer consumers, user space consumers acting without the kernel's direct
> > intervention, and ongoing DMA with remote RDMA peers (which will throw
> > the remote queue pairs into an error state almost immediately).  In the
> > future it very likely could include RDMA between things like GPU offload
> > processors too.  We can't restart that stuff even if we wanted to.  So
> > suspend/resume semantics for an RDMA device level reset is a non-
> > starter.
> 
> I see. I can understand the argument "we are stuck with what we have"
> for user-space, but does that mandate that we must live with that for
> kernel consumers as well? Even if the semantics is confusing? (Just
> asking, its only my opinion :))

See above.  It's not about user versus kernel space, it's that we really
did hot-remove a bunch of resources, even if not the card itself.

-- 
Doug Ledford <dledford at redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180129/29b6457c/attachment.sig>
