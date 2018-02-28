From: hch@lst.de (Christoph Hellwig)
Date: Wed, 28 Feb 2018 17:47:26 +0100
Subject: [PATCH V2] nvme-pci: assign separate irq vectors for adminq
 and ioq0
In-Reply-To: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <20180228164726.GB16536@lst.de>

Note that we originally allocates irqs this way, and Keith changed
it a while ago for good reasons.  So I'd really like to see good
reasons for moving away from this, and some heuristics to figure
out which way to use.  E.g. if the device supports more irqs than
I/O queues your scheme might always be fine.
