From: zwp10758@gmail.com (Weiping Zhang)
Date: Wed, 11 Jul 2018 21:38:34 +0800
Subject: [PATCH v2 1/2] nvme-pci: release iomap and prp_pools in
 nvme_pci_free_ctrl
In-Reply-To: <20180710144510.GB11548@localhost.localdomain>
References: <cover.1530548893.git.zhangweiping@didichuxing.com>
 <c9dc94bd6b434273ed69c47b06b4f55fb495254c.1530548893.git.zhangweiping@didichuxing.com>
 <20180710144510.GB11548@localhost.localdomain>
Message-ID: <CAA70yB6+DKHz0wzXoRyBCv5+TxkKZzDSQajhCf6qT45zLaLCow@mail.gmail.com>

Keith Busch <keith.busch at linux.intel.com> ?2018?7?10??? ??10:46???
>
> I'm getting the following warning with this patch:
>
Hi Keith,

How to reproduce this problem, I cann't reproduce it (apply these two
patch on 4.18.0-rc4) as following steps:
1. rmmod nvme
2. git am these 2 patchs
3. make modules SUBDIRS=drivers/nvme
4. insmod drivers/nvme/host/nvme.ko
5. fdisk /dev/nvme0n1 and create a partition
6. mkfs.ext4 /dev/nvme0n1p1
7. mount /dev/nvme0n1p1 /mnt
8. echo aaaaaa > /mnt/b.log
9. umount /mnt

> > --
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
