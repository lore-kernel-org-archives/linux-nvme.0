From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 13 Feb 2019 09:04:07 -0600
Subject: [PATCH V3 1/5] genirq/affinity: don't mark 'affd' as const
In-Reply-To: <20190213105041.13537-2-ming.lei@redhat.com>
References: <20190213105041.13537-1-ming.lei@redhat.com>
 <20190213105041.13537-2-ming.lei@redhat.com>
Message-ID: <20190213150407.GB96272@google.com>

On Wed, Feb 13, 2019@06:50:37PM +0800, Ming Lei wrote:
> Currently all parameters in 'affd' are read-only, so 'affd' is marked
> as const in both pci_alloc_irq_vectors_affinity() and irq_create_affinity_masks().

s/all parameters in 'affd'/the contents of '*affd'/

> We have to ask driver to re-caculate set vectors after the whole IRQ
> vectors are allocated later, and the result needs to be stored in 'affd'.
> Also both the two interfaces are core APIs, which should be trusted.

s/re-caculate/recalculate/
s/stored in 'affd'/stored in '*affd'/
s/both the two/both/

This is a little confusing because you're talking about both "IRQ
vectors" and these other "set vectors", which I think are different
things.  I assume the "set vectors" are cpumasks showing the affinity
of the IRQ vectors with some CPUs?

AFAICT, *this* patch doesn't add anything that writes to *affd.  I
think the removal of "const" should be in the same patch that makes
the removal necessary.

> So don't mark 'affd' as const both pci_alloc_irq_vectors_affinity() and
> irq_create_affinity_masks().
> 
> Signed-off-by: Ming Lei <ming.lei at redhat.com>
> ---
>  drivers/pci/msi.c         | 18 +++++++++---------
>  include/linux/interrupt.h |  2 +-
>  include/linux/pci.h       |  4 ++--
>  kernel/irq/affinity.c     |  2 +-
>  4 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 4c0b47867258..96978459e2a0 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -532,7 +532,7 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
>  }
>  
>  static struct msi_desc *
> -msi_setup_entry(struct pci_dev *dev, int nvec, const struct irq_affinity *affd)
> +msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity *affd)
>  {
>  	struct irq_affinity_desc *masks = NULL;
>  	struct msi_desc *entry;
> @@ -597,7 +597,7 @@ static int msi_verify_entries(struct pci_dev *dev)
>   * which could have been allocated.
>   */
>  static int msi_capability_init(struct pci_dev *dev, int nvec,
> -			       const struct irq_affinity *affd)
> +			       struct irq_affinity *affd)
>  {
>  	struct msi_desc *entry;
>  	int ret;
> @@ -669,7 +669,7 @@ static void __iomem *msix_map_region(struct pci_dev *dev, unsigned nr_entries)
>  
>  static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
>  			      struct msix_entry *entries, int nvec,
> -			      const struct irq_affinity *affd)
> +			      struct irq_affinity *affd)
>  {
>  	struct irq_affinity_desc *curmsk, *masks = NULL;
>  	struct msi_desc *entry;
> @@ -736,7 +736,7 @@ static void msix_program_entries(struct pci_dev *dev,
>   * requested MSI-X entries with allocated irqs or non-zero for otherwise.
>   **/
>  static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
> -				int nvec, const struct irq_affinity *affd)
> +				int nvec, struct irq_affinity *affd)
>  {
>  	int ret;
>  	u16 control;
> @@ -932,7 +932,7 @@ int pci_msix_vec_count(struct pci_dev *dev)
>  EXPORT_SYMBOL(pci_msix_vec_count);
>  
>  static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
> -			     int nvec, const struct irq_affinity *affd)
> +			     int nvec, struct irq_affinity *affd)
>  {
>  	int nr_entries;
>  	int i, j;
> @@ -1018,7 +1018,7 @@ int pci_msi_enabled(void)
>  EXPORT_SYMBOL(pci_msi_enabled);
>  
>  static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
> -				  const struct irq_affinity *affd)
> +				  struct irq_affinity *affd)
>  {
>  	int nvec;
>  	int rc;
> @@ -1086,7 +1086,7 @@ EXPORT_SYMBOL(pci_enable_msi);
>  
>  static int __pci_enable_msix_range(struct pci_dev *dev,
>  				   struct msix_entry *entries, int minvec,
> -				   int maxvec, const struct irq_affinity *affd)
> +				   int maxvec, struct irq_affinity *affd)
>  {
>  	int rc, nvec = maxvec;
>  
> @@ -1165,9 +1165,9 @@ EXPORT_SYMBOL(pci_enable_msix_range);
>   */
>  int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  				   unsigned int max_vecs, unsigned int flags,
> -				   const struct irq_affinity *affd)
> +				   struct irq_affinity *affd)
>  {
> -	static const struct irq_affinity msi_default_affd;
> +	struct irq_affinity msi_default_affd = {0};
>  	int msix_vecs = -ENOSPC;
>  	int msi_vecs = -ENOSPC;
>  
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 7c9434652f36..1ed1014c9684 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -332,7 +332,7 @@ extern int
>  irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
>  
>  struct irq_affinity_desc *
> -irq_create_affinity_masks(int nvec, const struct irq_affinity *affd);
> +irq_create_affinity_masks(int nvec, struct irq_affinity *affd);
>  
>  int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity *affd);
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 40b327b814aa..4eca42cf611b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1396,7 +1396,7 @@ static inline int pci_enable_msix_exact(struct pci_dev *dev,
>  }
>  int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  				   unsigned int max_vecs, unsigned int flags,
> -				   const struct irq_affinity *affd);
> +				   struct irq_affinity *affd);
>  
>  void pci_free_irq_vectors(struct pci_dev *dev);
>  int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
> @@ -1422,7 +1422,7 @@ static inline int pci_enable_msix_exact(struct pci_dev *dev,
>  static inline int
>  pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  			       unsigned int max_vecs, unsigned int flags,
> -			       const struct irq_affinity *aff_desc)
> +			       struct irq_affinity *aff_desc)
>  {
>  	if ((flags & PCI_IRQ_LEGACY) && min_vecs == 1 && dev->irq)
>  		return 1;
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index 118b66d64a53..9200d3b26f7d 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -239,7 +239,7 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
>   * Returns the irq_affinity_desc pointer or NULL if allocation failed.
>   */
>  struct irq_affinity_desc *
> -irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
> +irq_create_affinity_masks(int nvecs, struct irq_affinity *affd)
>  {
>  	int affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
>  	int curvec, usedvecs;
> -- 
> 2.9.5
> 
