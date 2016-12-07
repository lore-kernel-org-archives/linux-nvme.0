From: ddstreet@ieee.org (Dan Streetman)
Date: Wed, 7 Dec 2016 17:49:19 -0500
Subject: [PATCH] nvme: use the correct msix vector for each queue
In-Reply-To: <20161207224627.GA16018@infradead.org>
References: <20161207220348.8572-1-ddstreet@ieee.org>
 <20161207224414.GE22478@localhost.localdomain>
 <CALZtONAfYUXw2bgg=5XFEOZv39sKkRie_0wJRcbL+Lbihsok5Q@mail.gmail.com>
 <20161207224941.GA25959@localhost.localdomain>
 <20161207224627.GA16018@infradead.org>
Message-ID: <CALZtONCTvpa4ctjN7QJaeKcXi2iEQ2EieqDkQac3wnmKoEyEcA@mail.gmail.com>

On Wed, Dec 7, 2016@5:46 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Wed, Dec 07, 2016@05:49:42PM -0500, Keith Busch wrote:
>> I'm just saying that blk-mq's hctx mapping will end up choosing a queue
>> who's vector is mapped to a different CPU, and we don't want that.
>
> Right.  For 4.10 we could use the pci_alloc_irq_vectors_affinity helper
> to set away a pre_vector IFF we want a separate vector for the admin
> queue.
>
>> We are currently sharing the first IO queue's interrupt vector with
>> the admin queue's on purpose. Are you saying there's something wrong
>> with that?
>
> But given that the sharing was done intentionally and we had a long
> discussion on it back then there should be no real reason to change
> the assignment in NVMe.

sorry, i missed the past discussion.  It still seems strange and
obscure that it's intentional, from reading the code at least.
