From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 7 Jun 2016 10:52:17 +0200
Subject: [PATCH 4/8] nvme: add fabrics sysfs attributes
In-Reply-To: <1465248119-17875-5-git-send-email-hch@lst.de>
References: <1465248119-17875-1-git-send-email-hch@lst.de>
 <1465248119-17875-5-git-send-email-hch@lst.de>
Message-ID: <20160607085217.mp7ppvdmvzwwi36b@c203.arch.suse.de>

On Mon, Jun 06, 2016@11:21:55PM +0200, Christoph Hellwig wrote:
> - delete_controller: This attribute allows to delete a controller.
>   A driver is not obligated to support it (pci doesn't) so it is
>   created only if the driver supports it. The new fabrics drivers
>   will support it (essentialy a disconnect operation).
> 
>   Usage:
>   echo > /sys/class/nvme/nvme0/delete_controller
> 
> - subsysnqn: This attribute shows the subsystem nqn of the configured
>   device. If a driver does not implement the get_subsysnqn method, the
>   file will not appear in sysfs.
> 
> - transport: This attribute shows the transport name. Added a "name"
>   field to struct nvme_ctrl_ops.
> 
>   For loop,
>   cat /sys/class/nvme/nvme0/transport
>   loop
> 
>   For RDMA,
>   cat /sys/class/nvme/nvme0/transport
>   rdma
> 
>   For PCIe,
>   cat /sys/class/nvme/nvme0/transport
>   pcie
> 
> - address: This attributes shows the controller address. The fabrics
>   drivers that will implement get_address can show the address of the
>   connected controller.
> 
>   example:
>   cat /sys/class/nvme/nvme0/address
>   traddr=192.168.2.2,trsvcid=1023

Can you please add this to Documentation/ABI/ as well?

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
