From: mlin@kernel.org (Ming Lin)
Date: Wed,  9 Sep 2015 22:48:30 -0700
Subject: [RFC PATCH 0/2] virtio nvme
Message-ID: <1441864112-12765-1-git-send-email-mlin@kernel.org>

Hi all,

These 2 patches added virtio-nvme to kernel and qemu,
basically modified from virtio-blk and nvme code.

As title said, request for your comments.

Play it in Qemu with:
-drive file=disk.img,format=raw,if=none,id=D22 \
-device virtio-nvme-pci,drive=D22,serial=1234,num_queues=4

The goal is to have a full NVMe stack from VM guest(virtio-nvme)
to host(vhost_nvme) to LIO NVMe-over-fabrics target.

Now there are lots of duplicated code with linux/nvme-core.c and qemu/nvme.c.
The ideal result is to have a multi level NVMe stack(similar as SCSI).
So we can re-use the nvme code, for example

                        .-------------------------.
                        | NVMe device register    |
  Upper level           | NVMe protocol process   |
                        |                         |
                        '-------------------------'



              .-----------.    .-----------.    .------------------.
 Lower level  |   PCIe    |    | VIRTIO    |    |NVMe over Fabrics |
              |           |    |           |    |initiator         |
              '-----------'    '-----------'    '------------------'

todo:
 - tune performance. Should be as good as virtio-blk/virtio-scsi
 - support discard/flush/integrity
 - need Redhat's help for the VIRTIO_ID_NVME pci id
 - multi level NVMe stack

Code also available at:
http://www.minggr.net/cgit/cgit.cgi/linux/commit/?h=virtio-nvme/v1
http://www.minggr.net/cgit/cgit.cgi/qemu/log/?h=virtio-nvme/v1

Thanks,
Ming
