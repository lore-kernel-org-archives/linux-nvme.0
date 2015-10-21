From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Wed, 21 Oct 2015 14:23:46 -0700
Subject: [PATCH 06/18] nvme: split a new struct nvme_ctrl out of struct
 nvme_dev
In-Reply-To: <1444975128-8768-7-git-send-email-hch@lst.de>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
 <1444975128-8768-7-git-send-email-hch@lst.de>
Message-ID: <1445462626.3307.64.camel@linux.intel.com>

On Fri, 2015-10-16@07:58 +0200, Christoph Hellwig wrote:
> The new struct nvme_ctrl will be used by the common NVMe code that 
> sits
> on top of struct request_queue and the new nvme_ctrl_ops abstraction.
> It only contains the bare minimum required, which consists of values
> sampled during controller probe, the admin queue pointer and a second
> struct device pointer at the moment, but more will follow later. 
>  Only
> values that are not used in the I/O fast path should be moved to
> struct nvme_ctrl so that drivers can optimize their cache line usage
> easily.  That's also the reason why we have two device pointers as
> the struct device is used for DMA mapping purposes.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Acked-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/nvme/host/core.c |  10 +--
>  drivers/nvme/host/nvme.h |  61 ++++++---------
>  drivers/nvme/host/pci.c  | 190 +++++++++++++++++++++++++++++++------
> ----------
>  drivers/nvme/host/scsi.c |  85 ++++++++++-----------
>  4 files changed, 190 insertions(+), 156 deletions(-)
> 

<snipped>


> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 370aa5b..3e409fa 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -25,46 +25,16 @@ extern unsigned char nvme_io_timeout;
>  extern unsigned char admin_timeout;
>  #define ADMIN_TIMEOUT	(admin_timeout * HZ)
>  
> -/*
> - * Represents an NVM Express device.  Each nvme_dev is a PCI 
> function.
> - */
> -struct nvme_dev {
> -	struct list_head node;
> -	struct nvme_queue **queues;
> +struct nvme_ctrl {

Whether it is a PCIe NVMe device with multiple controllers or something
beyond PCIe, I think an instance of struct nvme_ctrl is going to need
to know its cntlid.  How does this struct know its cntlid?  I'm not
initially seeing it.  I think it would make more sense to have struct
nvme_ctrl have a member that stores its cntlid value.  It would
basically be the "name" of the specific nvme_ctrl instance allocated.


> +	const struct nvme_ctrl_ops *ops;
>  	struct request_queue *admin_q;
> -	struct blk_mq_tag_set tagset;
> -	struct blk_mq_tag_set admin_tagset;
> -	u32 __iomem *dbs;
>  	struct device *dev;
> -	struct dma_pool *prp_page_pool;
> -	struct dma_pool *prp_small_pool;
>  	int instance;
> -	unsigned queue_count;
> -	unsigned online_queues;
> -	unsigned max_qid;
> -	int q_depth;
> -	u32 db_stride;
> -	u32 ctrl_config;
> -	struct msix_entry *entry;
> -	void __iomem *bar;
> -	struct list_head namespaces;
> -	struct kref kref;
> -	struct device *device;
> -	struct work_struct reset_work;
> -	struct work_struct probe_work;
> -	struct work_struct scan_work;
> +
>  	char name[12];
>  	char serial[20];
>  	char model[40];
>  	char firmware_rev[8];
> -	bool subsystem;

Also, this is something probably a bit more far visioned, but I think
struct nvme_ctrl would need a mechanism to know what NVMe subsystem it
sits in.  Even if 'subsystem' stayed in the struct, I'm not sure how a
bool would work for this.

> -	u32 max_hw_sectors;
> -	u32 stripe_size;
> -	u32 page_size;
> -	void __iomem *cmb;
> -	dma_addr_t cmb_dma_addr;
> -	u64 cmb_size;
> -	u32 cmbsz;
>  	u16 oncs;
>  	u16 abort_limit;
>  	u8 event_limit;
> @@ -78,7 +48,7 @@ struct nvme_dev {
>  struct nvme_ns {
>  	struct list_head list;
>  
> -	struct nvme_dev *dev;
> +	struct nvme_ctrl *ctrl;

This seems a bit backwards to me.  It's the controller (cntlid) that is
going to tell the host how many namespaces are associated with it via
the NVMe Identify commands.  Thus, I would have thought that a list of
struct nvme_ns instances would be in a struct nvme_ctrl definition, not
vice-versa.  Unless '*ctrl' is going to be used as a back pointer?  But
then in 'struct nvme_ctrl' I didn't see initially see anything that
associates itself to the namespaces attached to it.

>  	struct request_queue *queue;
>  	struct gendisk *disk;
>  	struct kref kref;
> @@ -92,6 +62,19 @@ struct nvme_ns {
>  	u32 mode_select_block_len;
>  };
>  
