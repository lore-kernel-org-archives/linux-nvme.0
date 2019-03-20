From: stefanha@gmail.com (Stefan Hajnoczi)
Date: Wed, 20 Mar 2019 11:46:21 +0000
Subject: [PATCH 7/9] nvme/core: add mdev interfaces
In-Reply-To: <20190319144116.400-8-mlevitsk@redhat.com>
References: <20190319144116.400-1-mlevitsk@redhat.com>
 <20190319144116.400-8-mlevitsk@redhat.com>
Message-ID: <20190320114621.GC5542@stefanha-x1.localdomain>

On Tue, Mar 19, 2019@04:41:14PM +0200, Maxim Levitsky wrote:
> +int nvme_core_register_mdev_driver(struct nvme_mdev_driver *driver_ops)
> +{
> +	struct nvme_ctrl *ctrl;
> +
> +	if (mdev_driver_interface)
> +		return -EEXIST;
> +
> +	mdev_driver_interface = driver_ops;

Can mdev_driver_interface be accessed from two CPUs at the same time?
mdev_driver_interface isn't protected by the mutex.  The state_changed
functions below also don't protect mdev_driver_interface.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190320/bc363d0c/attachment.sig>
