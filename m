From: ddstreet@ieee.org (Dan Streetman)
Date: Wed, 7 Dec 2016 17:46:34 -0500
Subject: [PATCH] nvme: use the correct msix vector for each queue
In-Reply-To: <20161207224941.GA25959@localhost.localdomain>
References: <20161207220348.8572-1-ddstreet@ieee.org>
 <20161207224414.GE22478@localhost.localdomain>
 <CALZtONAfYUXw2bgg=5XFEOZv39sKkRie_0wJRcbL+Lbihsok5Q@mail.gmail.com>
 <20161207224941.GA25959@localhost.localdomain>
Message-ID: <CALZtONAyqjK4RG0PAJJczzHkZrhzpvT2v9eUu3yXs949-Q51dg@mail.gmail.com>

On Wed, Dec 7, 2016@5:49 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Wed, Dec 07, 2016@05:36:00PM -0500, Dan Streetman wrote:
>> On Wed, Dec 7, 2016@5:44 PM, Keith Busch <keith.busch@intel.com> wrote:
>> > pci_alloc_irq_vectors doesn't know you intend to make the first
>> > vector special, so it's going to come up with a CPU affinity from
>> > blk_mq_pci_map_queues that clashes with what you've programmed in the
>> > IO completion queues.
>>
>> I don't follow.  You're saying you mean to share cq_vector 0 between
>> the admin queue and io queue 1?
>
> I'm just saying that blk-mq's hctx mapping will end up choosing a queue
> who's vector is mapped to a different CPU, and we don't want that.
>
> We are currently sharing the first IO queue's interrupt vector with
> the admin queue's on purpose. Are you saying there's something wrong
> with that?

that's intentional?  Ok then.  That's extremely non-obvious.

Is there a reason you want to share the interrupt between the queues?
