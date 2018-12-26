From: hch@lst.de (Christoph Hellwig)
Date: Wed, 26 Dec 2018 19:20:27 +0100
Subject: [PATCH 2/2] nvme pci: try to allocate multiple irq vectors
 again in case of -EINVAL
In-Reply-To: <20181226103755.2101-3-ming.lei@redhat.com>
References: <20181226103755.2101-1-ming.lei@redhat.com>
 <20181226103755.2101-3-ming.lei@redhat.com>
Message-ID: <20181226182027.GA5866@lst.de>

On Wed, Dec 26, 2018@06:37:55PM +0800, Ming Lei wrote:
> It is observed on QEMU that pci_alloc_irq_vectors_affinity() may
> returns -EINVAL when the requested number is too big(such as 64).

Which is not how this API is supposed to work and documented to work.

We need to fix pci_alloc_irq_vectors_affinity to not return a spurious
error and just return the allocated number of vectors instead of
hacking around that in drivers.
