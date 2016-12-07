From: ddstreet@ieee.org (Dan Streetman)
Date: Wed, 7 Dec 2016 17:36:00 -0500
Subject: [PATCH] nvme: use the correct msix vector for each queue
In-Reply-To: <20161207224414.GE22478@localhost.localdomain>
References: <20161207220348.8572-1-ddstreet@ieee.org>
 <20161207224414.GE22478@localhost.localdomain>
Message-ID: <CALZtONAfYUXw2bgg=5XFEOZv39sKkRie_0wJRcbL+Lbihsok5Q@mail.gmail.com>

On Wed, Dec 7, 2016@5:44 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Wed, Dec 07, 2016@05:03:48PM -0500, Dan Streetman wrote:
>> Change each queue's cq_vector to match its qid, instead of qid - 1.
>>
>> The first queue is always the admin queue, and the remaining queues are
>> I/O queues.  The interrupt vectors they use are all in the same array,
>> however, the vector indexes for the admin and I/O queues are setup
>> differently; the admin queue's cq_vector is manually set to 0, while
>> each I/O queue's cq_vector is set to qid - 1.  Since the admin queue
>> is qid 0, and the I/O queues start at qid 1, using qid - 1 is wrong for the
>> I/O queues, as it makes the first I/O queue (qid 1) share the vector from
>> the admin queue (qid 0), and no queue uses the last interrupt vector.
>> Instead, each I/O queue should set their cq_vector to qid.
>
> pci_alloc_irq_vectors doesn't know you intend to make the first
> vector special, so it's going to come up with a CPU affinity from
> blk_mq_pci_map_queues that clashes with what you've programmed in the
> IO completion queues.

I don't follow.  You're saying you mean to share cq_vector 0 between
the admin queue and io queue 1?
