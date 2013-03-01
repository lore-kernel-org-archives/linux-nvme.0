From: Chayan.Biswas@sandisk.com (Chayan Biswas)
Date: Fri, 1 Mar 2013 22:05:25 +0000
Subject: [PATCH 1/2] Add support for 32 bit DMA for 32 bit machines
In-Reply-To: <20130301151219.GF4530@linux.intel.com>
References: <E821E2F372F08945977BD15EAE588D61097C57E9@SACMBXIP02.sdcorp.global.sandisk.com>
 <20130301151219.GF4530@linux.intel.com>
Message-ID: <E821E2F372F08945977BD15EAE588D61097C5FF6@SACMBXIP02.sdcorp.global.sandisk.com>

> What problem are you solving here?  If the system is 32-bit, setting the
> DMA mask to 64-bit should be harmless.  The DMA mask tells the system
> what the device is capable of -- this doesn't change if the system
> happens to be 32-bit.

[CB] The current code does not check for the return value from dma_set_mask() which can fail. Checking for the return value and falling back to 32 bit DMA is consistent with most of the device drivers currently in the kernel using this function and setting 64 bit DMA. Am I missing something here?

Maybe checking for the sizeof(dma_addr_t)  is superfluous and we can remove.

Without this patch we have hit system hang on a 32 bit OS earlier. Adding this patch resolved the issue.





> > Signed-off-by: Chayan Biswas <Chayan.Biswas at sandisk.com>
> > ---
> >  drivers/block/nvme.c |   19 +++++++++++++++++--
> >  1 files changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
> > index 993c014..4b706b5 100644
> > --- a/drivers/block/nvme.c
> > +++ b/drivers/block/nvme.c
> > @@ -42,6 +42,7 @@
> >
> >  #include <asm-generic/io-64-nonatomic-lo-hi.h>
> >
> > +#define IS_DMA64               (sizeof(dma_addr_t) == 8)
> >  #define NVME_Q_DEPTH 1024
> >  #define SQ_SIZE(depth)         (depth * sizeof(struct nvme_command))
> >  #define CQ_SIZE(depth)         (depth * sizeof(struct nvme_completion))
> > @@ -1662,8 +1663,21 @@ static int __devinit nvme_probe(struct pci_dev
> *pdev,
> >         INIT_LIST_HEAD(&dev->namespaces);
> >         dev->pci_dev = pdev;
> >         pci_set_drvdata(pdev, dev);
> > -       dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
> > -       dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
> > +       if (IS_DMA64) {
> > +               if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(64)) != 0) {
> > +                       if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(32)) != 0)
> > +                               goto fail_set_dma_mask;
> > +
> > +                       dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
> > +               } else {
> > +                       dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
> > +               }
> > +       } else {
> > +               if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(32)) != 0)
> > +                       goto fail_set_dma_mask;
> > +
> > +               dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
> > +       }
> >         result = nvme_set_instance(dev);
> >         if (result)
> >                 goto disable;
> > @@ -1705,6 +1719,7 @@ static int __devinit nvme_probe(struct pci_dev
> *pdev,
> >         iounmap(dev->bar);
> >   disable_msix:
> >         pci_disable_msix(pdev);
> > + fail_set_dma_mask:
> >         nvme_release_instance(dev);
> >         nvme_release_prp_pools(dev);
> >   disable:
> > --
> > 1.7.1
> >
> >
> > ________________________________
> >
> > PLEASE NOTE: The information contained in this electronic mail message is
> intended only for the use of the designated recipient(s) named above. If the
> reader of this message is not the intended recipient, you are hereby notified
> that you have received this message in error and that any review,
> dissemination, distribution, or copying of this message is strictly prohibited. If
> you have received this communication in error, please notify the sender by
> telephone or e-mail (as shown above) immediately and destroy any and all
> copies of this message in your possession (whether hard copies or
> electronically stored copies).
> >
> >
> > _______________________________________________
> > Linux-nvme mailing list
> > Linux-nvme at lists.infradead.org
> > http://merlin.infradead.org/mailman/listinfo/linux-nvme

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
