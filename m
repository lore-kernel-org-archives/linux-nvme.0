From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 18 Jan 2017 08:54:43 -0800
Subject: [PATCH 01/17] lpfc: Use new pci_alloc_irq_vectors() interface
In-Reply-To: <587ec2ec.lHOM16QZ9nmppg4/%jsmart2021@gmail.com>
References: <587ec2ec.lHOM16QZ9nmppg4/%jsmart2021@gmail.com>
Message-ID: <20170118165443.GA14012@infradead.org>

On Tue, Jan 17, 2017@05:20:44PM -0800, James Smart wrote:
> 
> Move to new pci_alloc_irq_vectors() interface for intx/msi/msix
> 
> Note: io channel paradigm remains, for now.

Not exactly a well written changelog.  I'd like to know why this is
better than my version here:

http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/lpfc-msix

It also seems to be missing the post_vectors setting for the
Flash Optimized Fabric interrupt, which may lead to an incorrect
vector assignment for all the queues.
