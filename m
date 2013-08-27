From: xuehua@gmail.com (Xuehua Chen)
Date: Tue, 27 Aug 2013 13:56:05 -0700
Subject: A question regarding to MSIX interrupts for NVME
Message-ID: <CAOu78O0uf0XarS8=RwfwzZ1zy93gxKNk5uK64+4nzWzBvze4_g@mail.gmail.com>

Hi, All,

I have a question regarding to the MSIX interrupts used by the linux
nvme driver to consult you.

It seems to me that admin queue is sharing vector 0 with IOCQ 1 now.
Is there any good reason
that admin queue should not have its own vector? It seems to me this
could makes interrupt
coalescing of nvme a bit strange due to the following reason.

In NVMe 1.1 spec, 5.12.1.9 Interrupt Vector Configuration, it is mentioned that

?By default, coalescing settings are enabled for each interrupt
vector. Interrupt coalescing is not supported for
the Admin Completion Queue.?

If a user want to enable coalescing for IOCQ 1, this will enable the
coalescing for admin queue
well since the interrupt vector are shared and violate the spec. So
this somehow makes IOCQ 1
different from other IOCQs.

Also does the spec don?t s support interrupt for ACQ because it want
ACQ be processed as soon
as possible? In the current implementation, admin queue commands could
be delayed when there
are lots of entries in IOCQ1 being processed. Maybe a separate vector
for admin queue could be
better for such a situation?

The above are my concerns on the current implementation of linux nvme
driver regarding to the
MSIX interrupts. Really want to know your thoughts and opinions on this.

Thanks a lot!

Best regards,

Xuehua
