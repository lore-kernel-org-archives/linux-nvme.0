From: hch@lst.de (Christoph Hellwig)
Date: Thu, 13 Jun 2019 10:54:02 +0200
Subject: [PATCH] PCI: Add Intel remapped NVMe device support
In-Reply-To: <CAOSXXT7H6HxY-za66Tr9ybRQyHsTdwwAgk9O2F=xK42MT8HsuA@mail.gmail.com>
References: <20190610074456.2761-1-drake@endlessm.com>
 <CAOSXXT7OFzHeTxNqZ1sS6giRxhDcrUUnVjURWBiFUc5T_8p=MA@mail.gmail.com>
 <CAD8Lp45djPU_Ur8uCO2Y5Sbek_5N9QKkxLXdKNVcvkr6rFPLUQ@mail.gmail.com>
 <CAOSXXT7H6HxY-za66Tr9ybRQyHsTdwwAgk9O2F=xK42MT8HsuA@mail.gmail.com>
Message-ID: <20190613085402.GC13442@lst.de>

On Wed, Jun 12, 2019@08:32:46AM -0600, Keith Busch wrote:
> On Mon, Jun 10, 2019@8:46 PM Daniel Drake <drake@endlessm.com> wrote:
> > What's the specific problem that you see here?
> 
> Performance. Have you had a chance to benchmark these storage devices
> comparing legacy vs MSI interrupts? I don't think anyone would chose
> the slower one on purpose. These platforms have an option to disable
> raid mode, so the kernel's current recommendation should be the user's
> best option.

And it isn't just performance.  I really don't understand how

 a) quirks on the PCI ID
 b) reset handling, including the PCI device removal as the last
    escalation step
 c) SR-IOV VFs and their management
 d) power management

and probably various other bits I didn't even think of are going to
work.

So until we get very clear and good documentation from Intel on that
I don't think any form of upstream support will fly.  And given that
Dan who submitted the original patch can't even talk about this thing
any more and apparently got a gag order doesn't really give me confidence
any of this will ever work.
