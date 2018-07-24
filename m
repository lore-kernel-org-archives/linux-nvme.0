From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 23 Jul 2018 23:54:14 -0700
Subject: [PATCH v2 2/2] PCI: NVMe device specific reset quirk
In-Reply-To: <20180724001310.7671.41243.stgit@gimli.home>
References: <20180724000944.7671.64284.stgit@gimli.home>
 <20180724001310.7671.41243.stgit@gimli.home>
Message-ID: <20180724065414.GA27298@infradead.org>

> As all NVMe devices make use of this standard interface and the NVMe
> specification also requires PCIe FLR support, we can apply this quirk
> to all devices with matching class code.

But not all NVMe devices require this quirk.  So please only quirk
devices that actually require it.
