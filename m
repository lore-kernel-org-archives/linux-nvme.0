From: Berck.Nash@wdc.com (Berck Nash)
Date: Thu, 15 Feb 2018 17:24:04 +0000
Subject: [PATCH v2] nvme-rdma: fix sysfs invoked reset_ctrl error flow
Message-ID: <CO2PR04MB2198A5365844DD35F9D5BAA682F40@CO2PR04MB2198.namprd04.prod.outlook.com>

I can confirm that this patch does improve things and now when an 
identify controller fails, there's 10 second reconnecting delay and 
reconnection is then successful.  But, several more reset attempts now 
produce a WARNING in ib_core followed by an oops in mlx5_core.  This is 
with a ConnectX 4.  dmesg attached.

This is with 4.15.1 with the 3 patches Max sent earlier plus this patch.

Let me know what I can do to help,
Berck Nash

On 1/17/2018 1:01 PM, Nitzan Carmi wrote:
 > When reset_controller that is invoked by sysfs fails,
 > it enters an error flow which practically removes the
 > nvme ctrl entirely (similar to delete_ctrl flow). It
 > causes the system to hang, since a sysfs attribute cannot
 > be unregistered by one of its own methods.
 >
 > This can be fixed by calling delete_ctrl as a work rather
 > than sequential code. In addition, it should give the ctrl
 > a chance to recover using reconnection mechanism (consistant
 > with FC reset_ctrl error flow). Also, while we're here, return
 > suitable errno in case the reset ended with non live ctrl.
 >
 > Signed-off-by: Nitzan Carmi <nitzanc at mellanox.com>
 > Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
 > ---
 >
 > Changes from v1:
 >   - Increment nr_reconnects when reset_ctrl has failed.
 >
 > ---
 >   drivers/nvme/host/core.c | 6 +++++-
 >   drivers/nvme/host/rdma.c | 7 ++-----
 >   2 files changed, 7 insertions(+), 6 deletions(-)
 >
 > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
 > index 839650e..58a6997 100644
 > --- a/drivers/nvme/host/core.c
 > +++ b/drivers/nvme/host/core.c
 > @@ -100,8 +100,12 @@ static int nvme_reset_ctrl_sync(struct nvme_ctrl 
*ctrl)
 >   	int ret;
 >
 >   	ret = nvme_reset_ctrl(ctrl);
 > -	if (!ret)
 > +	if (!ret) {
 >   		flush_work(&ctrl->reset_work);
 > +		if (ctrl->state != NVME_CTRL_LIVE)
 > +			ret = -ENETRESET;
 > +	}
 > +
 >   	return ret;
 >   }
 >
 > diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
 > index 2a0bba7..57d30e9 100644
 > --- a/drivers/nvme/host/rdma.c
 > +++ b/drivers/nvme/host/rdma.c
 > @@ -1787,11 +1787,8 @@ static void nvme_rdma_reset_ctrl_work(struct 
work_struct *work)
 >   	return;
 >
 >   out_fail:
 > -	dev_warn(ctrl->ctrl.device, "Removing after reset failure\n");
 > -	nvme_remove_namespaces(&ctrl->ctrl);
 > -	nvme_rdma_shutdown_ctrl(ctrl, true);
 > -	nvme_uninit_ctrl(&ctrl->ctrl);
 > -	nvme_put_ctrl(&ctrl->ctrl);
 > +	++ctrl->ctrl.nr_reconnects;
 > +	nvme_rdma_reconnect_or_remove(ctrl);
 >   }
 >
 >   static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 >
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: 4.15.1+_with_reset_patch.txt
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180215/68d9319c/attachment-0001.txt>
