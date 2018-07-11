From: zwp10758@gmail.com (Weiping Zhang)
Date: Wed, 11 Jul 2018 23:38:08 +0800
Subject: [PATCH v2 1/2] nvme-pci: release iomap and prp_pools in
 nvme_pci_free_ctrl
In-Reply-To: <20180711150311.GE11548@localhost.localdomain>
References: <cover.1530548893.git.zhangweiping@didichuxing.com>
 <c9dc94bd6b434273ed69c47b06b4f55fb495254c.1530548893.git.zhangweiping@didichuxing.com>
 <20180710144510.GB11548@localhost.localdomain>
 <CAA70yB6+DKHz0wzXoRyBCv5+TxkKZzDSQajhCf6qT45zLaLCow@mail.gmail.com>
 <20180711150311.GE11548@localhost.localdomain>
Message-ID: <CAA70yB7J3hSVrpKXDK0V8dYo31qFGzA8RVyRxvaG4eUT6ehTeg@mail.gmail.com>

Keith Busch <keith.busch at linux.intel.com> ?2018?7?11??? ??11:03???
>
> On Wed, Jul 11, 2018@09:38:34PM +0800, Weiping Zhang wrote:
> > Keith Busch <keith.busch at linux.intel.com> ?2018?7?10??? ??10:46???
> > >
> > > I'm getting the following warning with this patch:
> > >
> > Hi Keith,
> >
> > How to reproduce this problem, I cann't reproduce it (apply these two
> > patch on 4.18.0-rc4) as following steps:
> > 1. rmmod nvme
> > 2. git am these 2 patchs
> > 3. make modules SUBDIRS=drivers/nvme
> > 4. insmod drivers/nvme/host/nvme.ko
> > 5. fdisk /dev/nvme0n1 and create a partition
> > 6. mkfs.ext4 /dev/nvme0n1p1
> > 7. mount /dev/nvme0n1p1 /mnt
> > 8. echo aaaaaa > /mnt/b.log
>
> 8.1: Hot remove /dev/nvme0
Do you means  "rm -f /dev/nvme0" ?

>
> The reference counting is to ensure that resources needed to close a
> a holder (the mount point, in your example) aren't released during
> the 'remove'. We have to release the prp pools and the io memory before
> returning from the driver's 'remove' because the pci driver is going
> to release their dependencies.
>
> Anyway, I think the right thing to do is reorder the allocations to
> something more appropriate:
>
It seems no dependency between these two functions, I agree this approach.

> ---
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index ba943f211687..ddd441b1516a 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2556,11 +2556,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>
>         quirks |= check_vendor_combination_bug(pdev);
>
> -       result = nvme_init_ctrl(&dev->ctrl, &pdev->dev, &nvme_pci_ctrl_ops,
> -                       quirks);
> -       if (result)
> -               goto release_pools;
> -
>         /*
>          * Double check that our mempool alloc size will cover the biggest
>          * command we support.
> @@ -2578,6 +2573,11 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>                 goto release_pools;
>         }
>
> +       result = nvme_init_ctrl(&dev->ctrl, &pdev->dev, &nvme_pci_ctrl_ops,
> +                       quirks);
> +       if (result)
> +               goto release_mempool;
> +
>         dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
>
>         nvme_get_ctrl(&dev->ctrl);
> @@ -2585,6 +2585,8 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>
>         return 0;
>
> + release_mempool:
> +       mempool_destroy(dev->iod_mempool);
>   release_pools:
>         nvme_release_prp_pools(dev);
>   unmap:
> --
>
> > 9. umount /mnt
