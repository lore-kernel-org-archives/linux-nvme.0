From: hch@lst.de (hch@lst.de)
Date: Tue, 29 May 2018 19:44:42 +0200
Subject: Question on inline support
In-Reply-To: <5276f947-0ccf-5d0e-53bc-724f65c1c837@opengridcomputing.com>
References: <5276f947-0ccf-5d0e-53bc-724f65c1c837@opengridcomputing.com>
Message-ID: <20180529174442.GA1637@lst.de>

On Tue, May 29, 2018@12:33:56PM -0500, Steve Wise wrote:
> Hey guys,
> 
> While testing the nvme rdma target with inline_data_size=0 for my patch
> series [1], I found that the nvme host side rejected the queue
> connections with this error:
> 
> "nvme nvme0: Mandatory keyed sgls are not support"
> 
> Due to this code in nvme/host/rdma.c:
> 
> ?????? /* sanity check keyed sgls */
> ?????? if (!(ctrl->ctrl.sgls & (1 << 20))) {
> ?????????????? dev_err(ctrl->ctrl.device, "Mandatory keyed sgls are not
> support\n");
> ?????????????? ret = -EINVAL;
> ?????????????? goto out_remove_admin_queue;
> ?????? }

Keyed SGLs are bit 2, so the above should check for bit 2 as well.

We should still check for bit 20 if inline data is supported, though.
