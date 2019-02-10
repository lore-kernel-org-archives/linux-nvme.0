From: ming.lei@redhat.com (Ming Lei)
Date: Sun, 10 Feb 2019 17:22:09 +0800
Subject: [PATCH 2/5] genirq/affinity: allow driver to setup managed IRQ's
 affinity
In-Reply-To: <20190207222130.GQ7268@google.com>
References: <20190125095347.17950-1-ming.lei@redhat.com>
 <20190125095347.17950-3-ming.lei@redhat.com>
 <20190207222130.GQ7268@google.com>
Message-ID: <20190210092207.GA4832@ming.t460p>

On Thu, Feb 07, 2019@04:21:30PM -0600, Bjorn Helgaas wrote:
> On Fri, Jan 25, 2019@05:53:44PM +0800, Ming Lei wrote:
> > This patch introduces callback of .setup_affinity into 'struct
> > irq_affinity', so that:
> > 
> > 1) allow drivers to customize the affinity for managed IRQ, for
> > example, now NVMe has special requirement for read queues & poll
> > queues
> > 
> > 2) 6da4b3ab9a6e9 ("genirq/affinity: Add support for allocating interrupt sets")
> > makes pci_alloc_irq_vectors_affinity() a bit difficult to use for
> > allocating interrupt sets: 'max_vecs' is required to same with 'min_vecs'.
> 
> s/is required to same with/is required to be equal to/
> 
> > With this patch, driver can implement their own .setup_affinity to
> > customize the affinity, then the above thing can be solved easily.
> 
> s/driver/drivers/
> 
> > Signed-off-by: Ming Lei <ming.lei at redhat.com>
> > ---
> >  include/linux/interrupt.h | 26 +++++++++++++++++---------
> >  kernel/irq/affinity.c     |  6 ++++++
> >  2 files changed, 23 insertions(+), 9 deletions(-)
> > 
> > diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> > index c672f34235e7..f6cea778cf50 100644
> > --- a/include/linux/interrupt.h
> > +++ b/include/linux/interrupt.h
> > @@ -242,30 +242,38 @@ struct irq_affinity_notify {
> >  };
> >  
> >  /**
> > + * struct irq_affinity_desc - Interrupt affinity descriptor
> > + * @mask:	cpumask to hold the affinity assignment
> > + */
> > +struct irq_affinity_desc {
> > +	struct cpumask	mask;
> > +	unsigned int	is_managed : 1;
> > +};
> 
> I was going to comment that "managed" already has a common usage
> related to the devm_*() functions, but I don't think that's what you
> mean here.  But then I noticed that you're only *moving* this code,
> so you couldn't change it anyway.
> 
> But I still wonder what "managed" means here.

'managed' irq's affinity is managed by kernel, and user space can't change
it any more via /proc/irq/...

> 
> > +
> > +/**
> >   * struct irq_affinity - Description for automatic irq affinity assignements
> >   * @pre_vectors:	Don't apply affinity to @pre_vectors at beginning of
> >   *			the MSI(-X) vector space
> >   * @post_vectors:	Don't apply affinity to @post_vectors at end of
> >   *			the MSI(-X) vector space
> > + * @setup_affinity:	Use driver's method to setup irq vectors affinity,
> > + * 			and driver has to handle pre_vectors & post_vectors
> > + * 			correctly, set 'is_managed' flag correct too
> 
> s/irq vectors/irq vector/
> s/correct/correctly/
> 
> In general I don't think "correctly" is very useful in changelogs
> and comments.  Usually it just means "how *I* think it should be
> done", but it doesn't tell anybody else exactly *how* it should be
> done.

That is one nice question.

So far there are at least two rules related with correctness:

1) 'is_managed' flag needs to be set

2) for all managed irq vectors in one interrupt set of one device,
all possible CPUs should be covered in the setup affinities, meantime
one CPU can't be allocated to two irq vectors. The interrupt set is
unique for NVMe actually now, such as, all READ queues' interrupts
belong to one set, and other queues belong to another set. For other
device, we can think there is only one set for one device.

> 
> What does it mean for a driver to handle pre_vectors & post_vectors
> "correctly"?  The driver's .setup_affinity() method receives an array
> of struct irq_affinity; maybe it means that method should set the
> cpumask for each element as it desires.  For @pre_vectors and
> @post_vectors, I suppose that means their cpumask would be
> irq_default_affinity?

So far the default affinity for pre_vectors & post_vectors is to use
irq_default_affinity, and this patch changes it to cpu_possible_mask,
and this change won't be one big deal from driver's view.

> 
> But I guess the .setup_affinity() method means the driver would have
> complete flexibility for each vector, and it could use

Yeah, together with simplification in both driver and genirq/affinity
code.

> irq_default_affinity for arbitrary vectors, not just the first few
> (@pre_vectors) and the last few (@post_vectors)?
> 
> What's the rule for how a driver sets "is_managed"?

Please see above, and I plan to enhance the rule in genirq/affinity code
if this approach may be accepted.

Thanks,
Ming
