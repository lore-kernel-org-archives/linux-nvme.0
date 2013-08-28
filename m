From: xuehua@gmail.com (Xuehua Chen)
Date: Wed, 28 Aug 2013 11:49:41 -0700
Subject: A question regarding to MSIX interrupts for NVME
In-Reply-To: <20130828171453.GU4707@linux.intel.com>
References: <CAOu78O0uf0XarS8=RwfwzZ1zy93gxKNk5uK64+4nzWzBvze4_g@mail.gmail.com>
 <alpine.LRH.2.03.1308271512000.1857@AMR>
 <CAOu78O0eW5E2kE+_D87obRz3c-qM=DABdy84S4JtY6ETTYScHQ@mail.gmail.com>
 <alpine.LRH.2.03.1308271616480.1857@AMR>
 <CAOu78O3RxF3XDN5Wm0-AAwKLeESVzVxZdrXMnm6CnaCGrFTmLg@mail.gmail.com>
 <CAOu78O0dPM-7b8RVFPb2X1pddtb4s_kVUNHL_faOdx1PRQ0gkw@mail.gmail.com>
 <20130828171453.GU4707@linux.intel.com>
Message-ID: <CAOu78O3HSgb8EgMSxfN+z-x0w_xvB57tofYdDL5a5uPd+xubSA@mail.gmail.com>

> The spec also says: "It is recommended that interrupts for commands that
> complete in error are not coalesced."  So your design needs a way to
> defeat the coalescing and send the interrupt if an error completion is
> sent to a completion queue.  You can use the same mechanism to defeat
> the coalescing if any completion is sent to the admin completion queue.

This clarified some of my thoughts. What I said about it is strange
for hw to support interrupt
coalescing for IOCQ and ACQ sharing is not correct. And we can enable
interrupt coalescing
even when ACQ and IOCQ are shared. Thanks a lot for this!

The info seems to say that error handling better be handled asap. Then
it is more likely that the
same may apply to admin cq. The question I have is what are the
differences in response time
comparing allocating a separate vector for ACQ and sharing the
interrupt vector with IOCQ1.
When there are intensive IOs on IOQ1, if allocating a separate vector
that can be triggered on
a different cpu, the response time could be faster. Right now I don't
see disabling coalescing for
admin cq coalescing has much effect since it could be processed after
many IOCQ entries are
processed. In the mean time, other than an extra interrupt vector, do
you see any other disadvantages
if we allocate a separate vector for ACQ?

Thanks a lot!
