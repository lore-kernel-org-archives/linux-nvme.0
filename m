From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 7 Dec 2016 14:46:28 -0800
Subject: [PATCH] nvme: use the correct msix vector for each queue
In-Reply-To: <20161207224941.GA25959@localhost.localdomain>
References: <20161207220348.8572-1-ddstreet@ieee.org>
 <20161207224414.GE22478@localhost.localdomain>
 <CALZtONAfYUXw2bgg=5XFEOZv39sKkRie_0wJRcbL+Lbihsok5Q@mail.gmail.com>
 <20161207224941.GA25959@localhost.localdomain>
Message-ID: <20161207224627.GA16018@infradead.org>

On Wed, Dec 07, 2016@05:49:42PM -0500, Keith Busch wrote:
> I'm just saying that blk-mq's hctx mapping will end up choosing a queue
> who's vector is mapped to a different CPU, and we don't want that.

Right.  For 4.10 we could use the pci_alloc_irq_vectors_affinity helper
to set away a pre_vector IFF we want a separate vector for the admin
queue.

> We are currently sharing the first IO queue's interrupt vector with
> the admin queue's on purpose. Are you saying there's something wrong
> with that?

But given that the sharing was done intentionally and we had a long
discussion on it back then there should be no real reason to change
the assignment in NVMe.
