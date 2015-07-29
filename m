From: mlin@kernel.org (Ming Lin)
Date: Wed, 29 Jul 2015 16:55:18 -0700
Subject: [RFC] Multi level NVMe stack
Message-ID: <1438214118.24174.9.camel@ssi>

Hi,

I'm working on a virtio-nvme driver.
NVMe over Fabrics initiator will probably be available some time.

I wonder does it make sense to have a multi level NVMe stack(similar as
SCSI). So we can re-use the NVMe core code.

                        .-------------------------.
                        | /dev/nvme0n1 register   |
  Upper level           | NVMe protocol process   |
                        |                         |
                        '-------------------------'



              .-----------.    .-----------.    .------------------.
 Lower level  |   PCIe    |    | VIRTIO    |    |NVMe over Fabrics |
              |           |    |           |    |initiator         |
              '-----------'    '-----------'    '------------------'

Thanks,
Ming
