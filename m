From: alan.mikhak@sifive.com (Alan Mikhak)
Date: Tue, 25 Jun 2019 10:37:40 -0700
Subject: [PATCH] nvme-pci: Avoid leak if pci_p2pmem_virt_to_bus() returns
 null
In-Reply-To: <39cc44bb-28b8-0daf-b059-b78791c77eb1@intel.com>
References: <1561420642-21186-1-git-send-email-alan.mikhak@sifive.com>
 <39cc44bb-28b8-0daf-b059-b78791c77eb1@intel.com>
Message-ID: <CABEDWGy1X_HfmnMF05VKzMW7pNMaY+EMRFkTFPmc7Y0evoWZqQ@mail.gmail.com>

On Tue, Jun 25, 2019 at 10:10 AM Heitke, Kenneth
<kenneth.heitke@intel.com> wrote:
>
>
>
> On 6/24/2019 5:57 PM, Alan Mikhak wrote:
> > Modify nvme_alloc_sq_cmds() to call pci_free_p2pmem()
> > to free the memory it allocated using pci_alloc_p2pmem()
> > in case pci_p2pmem_virt_to_bus() returns null.
> >
> > Make sure not to call pci_free_p2pmem() if pci_alloc_p2pmem()
> > returned null which can happen if CONFIG_PCI_P2PDMA is not
> > configured.
> >
> > Signed-off-by: Alan Mikhak <alan.mikhak at sifive.com>
> > ---
> >   drivers/nvme/host/pci.c | 14 +++++++++-----
> >   1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 524d6bd6d095..5dfa067f6506 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -1456,11 +1456,15 @@ static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
> >
> >       if (qid && dev->cmb_use_sqes && (dev->cmbsz & NVME_CMBSZ_SQS)) {
> >               nvmeq->sq_cmds = pci_alloc_p2pmem(pdev, SQ_SIZE(depth));
> > -             nvmeq->sq_dma_addr = pci_p2pmem_virt_to_bus(pdev,
> > -                                             nvmeq->sq_cmds);
> > -             if (nvmeq->sq_dma_addr) {
> > -                     set_bit(NVMEQ_SQ_CMB, &nvmeq->flags);
> > -                     return 0;
> > +             if (nvmeq->sq_cmds) {
> > +                     nvmeq->sq_dma_addr = pci_p2pmem_virt_to_bus(pdev,
> > +                                                     nvmeq->sq_cmds);
> > +                     if (nvmeq->sq_dma_addr) {
> > +                             set_bit(NVMEQ_SQ_CMB, &nvmeq->flags);
> > +                             return 0;
> > +                     }
> > +
> > +                     pci_free_p2pmem(pdev, nvmeq->sq_cmds, SQ_SIZE(depth));
>
> Should the pointer be set to NULL here, just in case?

Thanks Kenneth. The pointer gets immediately reassigned by the return
value of the
code that follows. There is no intervening reference to it between the calls to
pci_free_p2pmem() and dma_alloc_coherent(). It should be safe without
setting it to NULL.

        nvmeq->sq_cmds = dma_alloc_coherent(dev->dev, nvmeq->cq_size,
                                &nvmeq->sq_dma_addr, GFP_KERNEL);

>
> >               }
> >       }
> >
> >
