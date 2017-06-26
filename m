From: hch@lst.de (Christoph Hellwig)
Date: Mon, 26 Jun 2017 12:20:55 +0200
Subject: block: spread MSI(-X) vectors to all possible CPUs
Message-ID: <20170626102058.10200-1-hch@lst.de>

Hi all,

this series contains the left-over block bits to spread the MSI-X
vectors over all CPU.  Thomas already rewrote and then merged the
irq bits into the tip irq/core branch, and this is the remainder.

As there are no dependencies on other block changes adding them
to the tip tree might be easiest if Jens could ACK them.
