From: hch@lst.de (Christoph Hellwig)
Date: Tue, 25 Jun 2019 09:08:35 +0200
Subject: [PATCH] nvme-pci: Avoid leak if pci_p2pmem_virt_to_bus()
 returns null
In-Reply-To: <1561420642-21186-1-git-send-email-alan.mikhak@sifive.com>
References: <1561420642-21186-1-git-send-email-alan.mikhak@sifive.com>
Message-ID: <20190625070835.GC30123@lst.de>

On Mon, Jun 24, 2019@04:57:22PM -0700, Alan Mikhak wrote:
> Modify nvme_alloc_sq_cmds() to call pci_free_p2pmem()
> to free the memory it allocated using pci_alloc_p2pmem()
> in case pci_p2pmem_virt_to_bus() returns null.
> 
> Make sure not to call pci_free_p2pmem() if pci_alloc_p2pmem()
> returned null which can happen if CONFIG_PCI_P2PDMA is not
> configured.

Can you 

> 
> Signed-off-by: Alan Mikhak <alan.mikhak at sifive.com>
> ---
>  drivers/nvme/host/pci.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 524d6bd6d095..5dfa067f6506 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1456,11 +1456,15 @@ static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
>  
>  	if (qid && dev->cmb_use_sqes && (dev->cmbsz & NVME_CMBSZ_SQS)) {
>  		nvmeq->sq_cmds = pci_alloc_p2pmem(pdev, SQ_SIZE(depth));
> -		nvmeq->sq_dma_addr = pci_p2pmem_virt_to_bus(pdev,
> -						nvmeq->sq_cmds);
> -		if (nvmeq->sq_dma_addr) {
> -			set_bit(NVMEQ_SQ_CMB, &nvmeq->flags);
> -			return 0; 
> +		if (nvmeq->sq_cmds) {
> +			nvmeq->sq_dma_addr = pci_p2pmem_virt_to_bus(pdev,
> +							nvmeq->sq_cmds);
> +			if (nvmeq->sq_dma_addr) {
> +				set_bit(NVMEQ_SQ_CMB, &nvmeq->flags);
> +				return 0;
> +			}
> +
> +			pci_free_p2pmem(pdev, nvmeq->sq_cmds, SQ_SIZE(depth));

pci_p2pmem_virt_to_bus should only fail when
pci_p2pmem_virt_to_bus failed.  That being said I think doing the
error check on pci_alloc_p2pmem instead of relying on 
pci_p2pmem_virt_to_bus "passing through" the error seems odd, I'd
rather check the pci_alloc_p2pmem return value directly.
