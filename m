From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 14 Jun 2018 08:42:03 -0600
Subject: Requirement to get BAR pci_bus_address in user space
In-Reply-To: <CABe79T5ZRBToOgCY0Myo47mkeOQ5FWrxgF-Bbdx-Pa3fmYPDGw@mail.gmail.com>
References: <CABe79T41Cr0mjH_k2drzccHvObFwRcW3n+WKCj0JvFUBy0wz-A@mail.gmail.com>
 <20180614102001.GA20836@lst.de>
 <CABe79T6k387EnDrpydTbQYQ+sZoWXKUee23EDzDJqnkroOmodA@mail.gmail.com>
 <92a9eeced36f863458ca2fd029f17a20@codeaurora.org>
 <CABe79T5ZRBToOgCY0Myo47mkeOQ5FWrxgF-Bbdx-Pa3fmYPDGw@mail.gmail.com>
Message-ID: <20180614144203.GA8129@localhost.localdomain>

On Thu, Jun 14, 2018@04:18:15PM +0530, Srinath Mannam wrote:
> The issue is, For CMB cards SQs are allocated inside device BAR memory
> which is different from normal cards.
> In Normal cards SQ memory allocated at host side.
> In both the cases physical address of CQ memory is programmed in NVMe
> controller register.
> This method works for normal cards because CQ memory is at host side.
> But in CMB cards pci bus address equivalent to CQ memory needs to program.

How do you know if the address that you can see is even the real bus
address? You could be running against a direct assigned device in a
guest where you don't get to see the actual bus address.
