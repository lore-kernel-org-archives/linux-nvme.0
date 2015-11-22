From: hch@lst.de (Christoph Hellwig)
Date: Sun, 22 Nov 2015 09:49:07 +0100
Subject: NVMe mega patchbomb for Linux 4.5-rc (resend)
In-Reply-To: <CAPb2fE8TDoMwWBgJmB6cBm5aywEj4DHLKfhReZauKq3WBp3EPg@mail.gmail.com>
References: <1448090427-18749-1-git-send-email-hch@lst.de>
 <CAPb2fE8TDoMwWBgJmB6cBm5aywEj4DHLKfhReZauKq3WBp3EPg@mail.gmail.com>
Message-ID: <20151122084907.GA11401@lst.de>

On Sun, Nov 22, 2015@08:14:38AM +0530, Madhu (Macaque Labs) wrote:
> With respect to the split of the driver into PCIe and PCIe agnostic parts,
> would you deem the split complete ? Or is there work still to be done.

I'd say about 95% done relative to my initial target.  There's some trivial
code moves that I have queued up after this series, and then we need to
look into a proper controller state machine.  But as always in Linux
we have moving targets, so things could change in the future.

> A good exercise would be to graft the upcoming SRIO driver and see
> how that coupling works.

SRIO as in Serial Rapid I/O?  How does that driver differ from the PCIe
one?  I'd expect it to still use MMIO access, the DMA API and a similar
queueing model as PCIe, in which case duplicating the whole PCIe driver
would seem wasteful.

Maybe you can post what you have currenly?  

> As part of our proposed lightstor standard (NVMe + extensions),

And the specs for your SRIO transport as well as your extension.  Did you
bring either of them up in the NVMe technical working group?
