From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 2 Sep 2015 07:05:17 -0700
Subject: setting nvme irq per cpu affinity in device driver
In-Reply-To: <003c01d0e569$dd9a7b40$98cf71c0$@samsung.com>
References: <003c01d0e569$dd9a7b40$98cf71c0$@samsung.com>
Message-ID: <20150902140517.GA9787@infradead.org>

We'll need a proper API in the interrupt subsystem to set the affinity
instead of poking directly into the internals.  The irq subsystem
maintainer already indicated he's fine with adding suh an API
in principle.  Please go ahead and propose something similar to your
implementation, just as an exported API in kernel/irq instead of inside
the NVMe driver.
