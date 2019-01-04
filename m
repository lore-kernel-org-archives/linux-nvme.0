From: keith.busch@intel.com (Keith Busch)
Date: Fri, 4 Jan 2019 15:56:22 -0700
Subject: [PATCHv2 3/4] PCI/MSI: Handle vector reduce and retry
In-Reply-To: <20190104223531.GA223506@google.com>
References: <20190103225033.11249-1-keith.busch@intel.com>
 <20190103225033.11249-4-keith.busch@intel.com>
 <20190104223531.GA223506@google.com>
Message-ID: <20190104225621.GA12916@localhost.localdomain>

On Fri, Jan 04, 2019@04:35:31PM -0600, Bjorn Helgaas wrote:
> On Thu, Jan 03, 2019@03:50:32PM -0700, Keith Busch wrote:
> > +The 'struct irq_affinity *affd' allows a driver to specify additional
> > +characteristics for how a driver wants the vector management to occur. The
> > +'pre_vectors' and 'post_vectors' fields define how many vectors the driver
> > +wants to not participate in kernel managed affinities, and whether those
> > +special vectors are at the beginning or the end of the vector space.
> 
> How are the pre_vectors and post_vectors handled?  Do they get
> assigned to random CPUs?  Current CPU?  Are their assignments tunable
> from user space?

Point taken. Those do get assigned a default mask, but they are also
user tunable and kernel migratable when CPUs offline/online.
 
> > +It may also be the case that a driver wants multiple sets of fully
> > +affinitized vectors. For example, a single PCI function may provide
> > +different high performance services that want full CPU affinity for each
> > +service independent of other services. In this case, the driver may use
> > +the struct irq_affinity's 'nr_sets' field to specify how many groups of
> > +vectors need to be spread across all the CPUs, and fill in the 'sets'
> > +array to say how many vectors the driver wants in each set.
> 
> I think the issue here is IRQ vectors, and "services" and whether
> they're high performance are unnecessary concepts.

It's really intended for when your device has resources optimally accessed
in a per-cpu manner. I can better rephrase this description.

> What does irq_affinity.sets point to?  I guess it's a table of
> integers where the table size is the number of sets and each entry is
> the number of vectors in the set?
>
> So we'd have something like this:
> 
>   pre_vectors     # vectors [0..pre_vectors) (pre_vectors >= 0)
>   set 0           # vectors [pre_vectors..pre_vectors+set0) (set0 >= 1)
>   set 1           # vectors [pre_vectors+set0..pre_vectors+set0+set1) (set1 >= 1)
>   ...
>   post_vectors    # vectors [pre_vectors+set0..pre_vectors+set0+set1+setN+post_vectors)
> 
> where the vectors in set0 are spread across all CPUs, those in set1
> are independently spread across all CPUs, etc?
>
> I would guess there may be device-specific restrictions on the mapping
> of of these vectors to sets, so the PCI core probably can't assume the
> sets can be of arbitrary size, contiguous, etc.

I think it's fair to say the caller wants vectors allocated and each set
affinitized contiguously such that each set starts after the previous
one ends. That works great with how NVMe wants to use it, at least. If
there is really any other way a device driver wants it, I can't see how
that can be easily accomodated.
