From: keith.busch@intel.com (Keith Busch)
Date: Wed, 01 May 2013 21:50:39 -0000
Subject: Added MSI supoort (includes MSI Multiple) to Linux NVME Driver
In-Reply-To: <CAKt=HwKsHENz+vnZrWxN19_7HpgnUeQ4+8YmZreVXRp63_kn3w@mail.gmail.com>
References: <CAKt=HwKsHENz+vnZrWxN19_7HpgnUeQ4+8YmZreVXRp63_kn3w@mail.gmail.com>
Message-ID: <alpine.LRH.2.03.1304100639250.25729@localhost.localdom>

I think your mail text editor or email client appears to be messing with
the text of your patch somewhat. Just wanted to let you know since this
won't apply cleanly without the maintainer fixing the wrapped lines.

I use 'git format-patch' to generate the patches and 'git send-email'
to post patches to the mailing list.

On Wed, 1 May 2013, Ramachandra Rao Gajula wrote:
> ---
>    Added MSI supoort (includes MSI Multiple) to Linux NVME Driver
>    Changes made to consider Keith's review comments
> ---
>    Signed-off-by: Ramachandra Rao Gajula <rama at fastorsystems.com>
> ---
> drivers/block/nvme-core.c |   32 ++++++++++++++++++++++++++++----
> 1 files changed, 28 insertions(+), 4 deletions(-)
> ---
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index bcb81c8..0f6225b 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -1431,7 +1431,7 @@ static int set_queue_count(struct nvme_dev *dev,
> int count)
>
> static int nvme_setup_io_queues(struct nvme_dev *dev)
> {
> -       int result, cpu, i, nr_io_queues, db_bar_size, q_depth;
> +       int result, cpu, i, nr_io_queues, db_bar_size, q_depth, q_cnt;
>
>        nr_io_queues = num_online_cpus();
>        result = set_queue_count(dev, nr_io_queues);
> @@ -1440,6 +1440,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>        if (result < nr_io_queues)
>                nr_io_queues = result;
>
> +       q_cnt = nr_io_queues;
>        /* Deregister the admin queue's interrupt */
>        free_irq(dev->entry[0].vector, dev->queues[0]);
>
> @@ -1463,10 +1464,27 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>                        nr_io_queues = result;
>                        continue;
>                } else {
> -                       nr_io_queues = 1;
> +                       nr_io_queues = q_cnt;
>                        break;
>                }
>        }
> +       /* if MSI-X failed, then try for MSI for nr_io_queues vectors */
> +        if (!dev->pci_dev->msix_enabled) {
> +                for (;;) {
> +                        result = pci_enable_msi_block(dev->pci_dev,
> nr_io_queues);
> +                        if (result == 0) {
> +                                for (i = 0; i < nr_io_queues; i++)
> +                                        dev->entry[i].vector = i +
> dev->pci_dev->irq;
> +                                break;
> +                        } else if (result > 0) {
> +                                nr_io_queues = result;
> +                                continue;
> +                        } else {
> +                                nr_io_queues = 1;
> +                                break;
> +                        }
> +                }
> +        }
>
>        result = queue_request_irq(dev, dev->queues[0], "nvme admin");
>        /* XXX: handle failure here */
> @@ -1651,7 +1669,10 @@ static void nvme_free_dev(struct kref *kref)
> {
>        struct nvme_dev *dev = container_of(kref, struct nvme_dev, kref);
>        nvme_dev_remove(dev);
> -       pci_disable_msix(dev->pci_dev);
> +       if (dev->pci_dev->msi_enabled)
> +               pci_disable_msi(dev->pci_dev);
> +       else
> +               pci_disable_msix(dev->pci_dev);
>        iounmap(dev->bar);
>        nvme_release_instance(dev);
>        nvme_release_prp_pools(dev);
> @@ -1778,7 +1799,10 @@ static int nvme_probe(struct pci_dev *pdev,
> const struct pci_device_id *id)
>  unmap:
>        iounmap(dev->bar);
>  disable_msix:
> -       pci_disable_msix(pdev);
> +       if (dev->pci_dev->msi_enabled)
> +               pci_disable_msi(pdev);
> +       else
> +               pci_disable_msix(pdev);
>        nvme_release_instance(dev);
>        nvme_release_prp_pools(dev);
>  disable:
>
> ---
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://merlin.infradead.org/mailman/listinfo/linux-nvme
>
