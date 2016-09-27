From: nisha.miller420@gmail.com (Nisha Miller)
Date: Tue, 27 Sep 2016 11:39:53 -0700
Subject: Create IO queue variation between kernels
Message-ID: <CAG3=cOmN5jGK6kqv_kCiyZL8ypy_uTaA3poooP6cdBLE8AQbJg@mail.gmail.com>

Hi,

We plugged our NVMe controller into a server running Kernel 3.19.8 and
we were able to create multiple IO queues.

On the same server, if we boot Kernel 2.6.32 we can create only 1 IO
queue. On 2.6.32, pci_enable_msi_block() always returns number of MSIs
supported as 1. Since there is no change in the hardware, I'm
wondering where the problem lies and how we can fix this.

Any clues, ideas, tips greatly appreciated!

TIA
Nisha Miller
