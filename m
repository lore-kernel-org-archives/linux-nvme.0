From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 14 Jun 2019 15:05:57 -0500
Subject: [PATCH] PCI: Add Intel remapped NVMe device support
In-Reply-To: <CAOSXXT4Ba_6xRUyaQBxpq+zdG9_itXDhFJ5EFZPv3CQuJZKHzg@mail.gmail.com>
References: <20190610074456.2761-1-drake@endlessm.com>
 <CAOSXXT7OFzHeTxNqZ1sS6giRxhDcrUUnVjURWBiFUc5T_8p=MA@mail.gmail.com>
 <CAD8Lp45djPU_Ur8uCO2Y5Sbek_5N9QKkxLXdKNVcvkr6rFPLUQ@mail.gmail.com>
 <CAOSXXT7H6HxY-za66Tr9ybRQyHsTdwwAgk9O2F=xK42MT8HsuA@mail.gmail.com>
 <20190613085402.GC13442@lst.de>
 <CAD8Lp47Vu=w+Lj77_vL05JYV1WMog9WX3FHGE+TseFrhcLoTuA@mail.gmail.com>
 <CAOSXXT4Ba_6xRUyaQBxpq+zdG9_itXDhFJ5EFZPv3CQuJZKHzg@mail.gmail.com>
Message-ID: <20190614200557.GS13533@google.com>

On Fri, Jun 14, 2019@01:36:07PM -0600, Keith Busch wrote:

> Even if you wish to forgo the standard features and management
> capabilities, you're still having to deal with legacy IRQ, which has
> IOPs at a fraction of the hardware's true capabilities when using MSI.

> ... your best option is still to set to AHCI mode for Linux
> for this reason alone, and vendors should be providing this option in
> BIOS.

Ugh.  Are you saying the installation instructions for Linux will say
"change the BIOS setting to AHCI"?  That's an unpleasant user
experience, especially if the installation fails if the user hasn't
read the instructions.

Bjorn
