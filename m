From: hch@lst.de (Christoph Hellwig)
Date: Tue, 27 Mar 2018 16:17:18 +0200
Subject: [PATCH 1/3] blk-mq: Allow PCI vector offset for mapping queues
In-Reply-To: <20180323221923.24545-1-keith.busch@intel.com>
References: <20180323221923.24545-1-keith.busch@intel.com>
Message-ID: <20180327141718.GA4724@lst.de>

On Fri, Mar 23, 2018@04:19:21PM -0600, Keith Busch wrote:
> The PCI interrupt vectors intended to be associated with a queue may
> not start at 0. This patch adds an offset parameter so blk-mq may find
> the intended affinity mask. The default value is 0 so existing drivers
> that don't care about this parameter don't need to change.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  block/blk-mq-pci.c         | 12 ++++++++++--
>  include/linux/blk-mq-pci.h |  2 ++
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c
> index 76944e3271bf..1040a7705c13 100644
> --- a/block/blk-mq-pci.c
> +++ b/block/blk-mq-pci.c
> @@ -21,6 +21,7 @@
>   * blk_mq_pci_map_queues - provide a default queue mapping for PCI device
>   * @set:	tagset to provide the mapping for
>   * @pdev:	PCI device associated with @set.
> + * @offset:	PCI irq starting vector offset
>   *
>   * This function assumes the PCI device @pdev has at least as many available
>   * interrupt vectors as @set has queues.  It will then query the vector
> @@ -28,13 +29,14 @@
>   * that maps a queue to the CPUs that have irq affinity for the corresponding
>   * vector.
>   */
> -int blk_mq_pci_map_queues(struct blk_mq_tag_set *set, struct pci_dev *pdev)
> +int __blk_mq_pci_map_queues(struct blk_mq_tag_set *set, struct pci_dev *pdev,
> +			    int offset)

Can you just change the blk_mq_pci_map_queues prototype instead?
