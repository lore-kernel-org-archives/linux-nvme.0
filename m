From: sbates@raithlin.com (Stephen  Bates)
Date: Fri, 7 Apr 2017 11:19:30 +0000
Subject: [RFC 6/8] nvmet: Be careful about using iomem accesses when
 dealing with p2pmem
In-Reply-To: <4df229d8-8124-664a-9bc4-6401bc034be1@grimberg.me>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1490911959-5146-7-git-send-email-logang@deltatee.com>
 <080b68b4-eba3-861c-4f29-5d829425b5e7@grimberg.me>
 <20170404154629.GA13552@obsidianresearch.com>
 <4df229d8-8124-664a-9bc4-6401bc034be1@grimberg.me>
Message-ID: <3E85B4D4-9EBC-4299-8209-2D8740947764@raithlin.com>

On 2017-04-06, 6:33 AM, "Sagi Grimberg" <sagi@grimberg.me> wrote:

> Say it's connected via 2 legs, the bar is accessed from leg A and the
> data from the disk comes via leg B. In this case, the data is heading
> towards the p2p device via leg B (might be congested), the completion
> goes directly to the RC, and then the host issues a read from the
> bar via leg A. I don't understand what can guarantee ordering here.

> Stephen told me that this still guarantees ordering, but I honestly
> can't understand how, perhaps someone can explain to me in a simple
> way that I can understand.

Sagi

As long as legA, legB and the RC are all connected to the same switch then ordering will be preserved (I think many other topologies also work). Here is how it would work for the problem case you are concerned about (which is a read from the NVMe drive).

1. Disk device DMAs out the data to the p2pmem device via a string of PCIe MemWr TLPs.
2. Disk device writes to the completion queue (in system memory) via a MemWr TLP.
3. The last of the MemWrs from step 1 might have got stalled in the PCIe switch due to congestion but if so they are stalled in the egress path of the switch for the p2pmem port.
4. The RC determines the IO is complete when the TLP associated with step 2 updates the memory associated with the CQ. It issues some operation to read the p2pmem.
5. Regardless of whether the MemRd TLP comes from the RC or another device connected to the switch it is queued in the egress queue for the p2pmem FIO behind the last DMA TLP (from step 1). PCIe ordering ensures that this MemRd cannot overtake the MemWr (Reads can never pass writes). Therefore the MemRd can never get to the p2pmem device until after the last DMA MemWr has.

I hope this helps!

Stephen
