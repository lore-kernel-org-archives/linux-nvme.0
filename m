From: keith.busch@intel.com (Keith Busch)
Date: Thu, 1 Dec 2016 13:09:43 -0500
Subject: [PATCH] nvme/pci: Log PCI_STATUS when the controller dies
In-Reply-To: <CALCETrUt+JtDE1W97xjK+8U=oQFSV-4o4hqRFV_f9tsXUp=qRQ@mail.gmail.com>
References: <0e60b11aa18049f2643b62400c3fcbd959791c51.1480468668.git.luto@kernel.org>
 <c1a8c6d2-2dfc-b9af-5134-b3aca2402957@fb.com>
 <CALCETrUt+JtDE1W97xjK+8U=oQFSV-4o4hqRFV_f9tsXUp=qRQ@mail.gmail.com>
Message-ID: <20161201180943.GG21081@localhost.localdomain>

On Wed, Nov 30, 2016@10:28:03AM -0800, Andy Lutomirski wrote:
> In theory, although not (AFAIK) on x86, config space reads can fail
> outright.  Normally a failure looks like returning 0xffff, so I
> figured I'd make it consistent.  I could alternatively check the
> return value and print a different message if pci_read_config_word
> fails.

I agree it'd be nice to know if we actually got all 1's from hardware,
or the pci config read itself returned an error without setting the
status. x86 should be returning all 1's on a failure, but don't want to
always count on that.
