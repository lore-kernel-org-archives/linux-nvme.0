From: tom.leiming@gmail.com (Ming Lei)
Date: Sat, 10 Aug 2019 07:05:32 +0800
Subject: [PATCH 1/2] genirq/affinity: improve __irq_build_affinity_masks()
In-Reply-To: <20190809144204.GA28515@localhost.localdomain>
References: <20190809102310.27246-1-ming.lei@redhat.com>
 <20190809102310.27246-2-ming.lei@redhat.com>
 <20190809144204.GA28515@localhost.localdomain>
Message-ID: <CACVXFVMT=rkZC7LwK5quXgudS7fb7bQ_LunA1tEE-Z-9s1uvaA@mail.gmail.com>

On Fri, Aug 9, 2019@10:44 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Fri, Aug 09, 2019@06:23:09PM +0800, Ming Lei wrote:
> > One invariant of __irq_build_affinity_masks() is that all CPUs in the
> > specified masks( cpu_mask AND node_to_cpumask for each node) should be
> > covered during the spread. Even though all requested vectors have been
> > reached, we still need to spread vectors among left CPUs. The similar
> > policy has been taken in case of 'numvecs <= nodes'.
> >
> > So remove the following check inside the loop:
> >
> >       if (done >= numvecs)
> >               break;
> >
> > Meantime assign at least 1 vector for left nodes if 'numvecs' vectors
> > have been spread.
> >
> > Also, if the specified cpumask for one numa node is empty, simply not
> > spread vectors on this node.
> >
> > Cc: Christoph Hellwig <hch at lst.de>
> > Cc: Keith Busch <kbusch at kernel.org>
> > Cc: linux-nvme at lists.infradead.org,
> > Cc: Jon Derrick <jonathan.derrick at intel.com>
> > Signed-off-by: Ming Lei <ming.lei at redhat.com>
> > ---
> >  kernel/irq/affinity.c | 33 +++++++++++++++++++++------------
> >  1 file changed, 21 insertions(+), 12 deletions(-)
> >
> > diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> > index 6fef48033f96..bc3652a2c61b 100644
> > --- a/kernel/irq/affinity.c
> > +++ b/kernel/irq/affinity.c
> > @@ -129,21 +129,32 @@ static int __irq_build_affinity_masks(unsigned int startvec,
> >       for_each_node_mask(n, nodemsk) {
> >               unsigned int ncpus, v, vecs_to_assign, vecs_per_node;
> >
> > -             /* Spread the vectors per node */
> > -             vecs_per_node = (numvecs - (curvec - firstvec)) / nodes;
> > -
> >               /* Get the cpus on this node which are in the mask */
> >               cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
> > -
> > -             /* Calculate the number of cpus per vector */
> >               ncpus = cpumask_weight(nmsk);
> > +             if (!ncpus)
> > +                     continue;
>
> This shouldn't be possible, right? The nodemsk we're looping  wouldn't
> have had that node set if no CPUs intersect the node_to_cpu_mask for
> that node, so the resulting cpumask should always have a non-zero weight.

     cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);

It is often true, see the following cases:

1) all CPUs in one node are not present

OR

2) all CPUs in one node are present

>
> > @@ -153,16 +164,14 @@ static int __irq_build_affinity_masks(unsigned int startvec,
> >                       }
> >                       irq_spread_init_one(&masks[curvec].mask, nmsk,
> >                                               cpus_per_vec);
> > +                     if (++curvec >= last_affv)
> > +                             curvec = firstvec;
>
> I'm not so sure about wrapping the vector to share it across nodes. We

The wrapping is always there, not added by this patch.

Most time it won't happen since we spread vectors on remaining
(un-assigned)nodes.  And it only happens when there is remaining
nodes not spread. We have to make sure all nodes are spread.

And the similar policy is applied on the branch of 'numvecs <= nodes' too.

> have enough vectors in this path to ensure each compute node can have
> a unique one, and it's much cheaper to share these within nodes than
> across them.

The patch just moves the wrapping from loop outside into the loop, then
all 'extra_vecs' can be covered because it is always < 'vecs_to_assign'.

What matters is that the following check is removed:

   if (done >= numvecs)
                break;

then all nodes can be covered.

Thanks,
Ming Lei
