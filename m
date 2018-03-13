From: hch@lst.de (Christoph Hellwig)
Date: Tue, 13 Mar 2018 09:16:28 +0100
Subject: [pci PATCH v5 3/4] ena: Migrate over to unmanaged SR-IOV support
In-Reply-To: <1520928772.28745.53.camel@infradead.org>
References: <20180312171813.3487.94803.stgit@localhost.localdomain>
 <20180312172309.3487.76690.stgit@localhost.localdomain>
 <1520928772.28745.53.camel@infradead.org>
Message-ID: <20180313081628.GA618@lst.de>

On Tue, Mar 13, 2018@08:12:52AM +0000, David Woodhouse wrote:
> I'd also *really* like to see a way to enable this for PFs which don't
> have (and don't need) a driver. We seem to have lost that along the
> way.

We've been forth and back on that.  I agree that not having any driver
just seems dangerous.  If your PF really does nothing we should just
have a trivial pf_stub driver that does nothing but wiring up
pci_sriov_configure_simple.  We can then add PCI IDs to it either
statically, or using the dynamic ids mechanism.
