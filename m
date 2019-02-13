From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 13 Feb 2019 07:36:01 -0700
Subject: [PATCH V3 0/5] genirq/affinity: add .calc_sets for improving IRQ
 allocation & spread
In-Reply-To: <20190213105041.13537-1-ming.lei@redhat.com>
References: <20190213105041.13537-1-ming.lei@redhat.com>
Message-ID: <a026c441-d433-2391-796d-3d67d233ab04@kernel.dk>

On 2/13/19 3:50 AM, Ming Lei wrote:
> Hi,
> 
> Currently pre-caculated set vectors are provided by driver for
> allocating & spread vectors. This way only works when drivers passes
> same 'max_vecs' and 'min_vecs' to pci_alloc_irq_vectors_affinity(),
> also requires driver to retry the allocating & spread.
> 
> As Bjorn and Keith mentioned, the current usage & interface for irq sets
> is a bit awkward because the retrying should have been avoided by providing
> one resonable 'min_vecs'. However, if 'min_vecs' isn't same with
> 'max_vecs', number of the allocated vectors is unknown before calling
> pci_alloc_irq_vectors_affinity(), then each set's vectors can't be
> pre-caculated.
> 
> Add a new callback of .calc_sets into 'struct irq_affinity' so that
> driver can caculate set vectors after IRQ vector is allocated and
> before spread IRQ vectors.

Much improved, thanks for doing this work. You can add

Reviewed-by: Jens Axboe <axboe at kernel.dk>

if you want.

-- 
Jens Axboe
