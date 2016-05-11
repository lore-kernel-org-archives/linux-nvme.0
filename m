From: hch@lst.de (Christoph Hellwig)
Date: Wed, 11 May 2016 10:52:22 +0200
Subject: [PATCH 1/2] PCI: Provide sensible irq vector alloc/free routines
In-Reply-To: <20160509224631.GB18501@localhost>
References: <1462457096-19795-1-git-send-email-hch@lst.de>
 <1462457096-19795-2-git-send-email-hch@lst.de>
 <20160509224631.GB18501@localhost>
Message-ID: <20160511085222.GA20357@lst.de>

On Mon, May 09, 2016@05:46:31PM -0500, Bjorn Helgaas wrote:
> Thanks, I applied this to pci/msi for v4.7.  I'd be happy to apply the
> nvme change, too, given the appropriate acks.

Given the merge conflict that Keith pointed out I suspect it'll be better
to defer it until the next merge window.
