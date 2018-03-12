From: hch@lst.de (Christoph Hellwig)
Date: Mon, 12 Mar 2018 08:59:07 +0100
Subject: [pci PATCH v4 1/4] pci-iov: Add support for unmanaged SR-IOV
In-Reply-To: <20180311215909.16ed4bf1@t450s.home>
References: <20180308185507.5433.98830.stgit@localhost.localdomain>
 <20180308190047.5433.77952.stgit@localhost.localdomain>
 <20180311215909.16ed4bf1@t450s.home>
Message-ID: <20180312075907.GA5342@lst.de>

On Sun, Mar 11, 2018@09:59:09PM -0600, Alex Williamson wrote:
> I still struggle to understand why we need this "unmanaged"
> complication and how a user of the sysfs API is expected to have any
> idea whether a PF is managed or unmanaged and why they should care.
> Can't we just have a pci_simple_sriov_configure() helper and ignore
> this unmanaged business?  Thanks,

Just a pci_simple_sriov_configure is exactly what I envisioned originally.
