From: Mario.Limonciello@dell.com (Mario.Limonciello@dell.com)
Date: Wed, 15 May 2019 19:33:45 +0000
Subject: [PATCHv2 6/6] nvme-pci: Use host managed power state for suspend
In-Reply-To: <20190515163625.21776-6-keith.busch@intel.com>
References: <20190515163625.21776-1-keith.busch@intel.com>
 <20190515163625.21776-6-keith.busch@intel.com>
Message-ID: <f3d7281f020844828161b2387732cc42@AUSX13MPC105.AMER.DELL.COM>

> -----Original Message-----
> From: Keith Busch <keith.busch at intel.com>
> Sent: Wednesday, May 15, 2019 11:36 AM
> To: Christoph Hellwig; Sagi Grimberg; linux-nvme at lists.infradead.org
> Cc: Rafael Wysocki; Keith Busch; Limonciello, Mario; Kai Heng Feng
> Subject: [PATCHv2 6/6] nvme-pci: Use host managed power state for suspend
> 
> 
> [EXTERNAL EMAIL]
> 
> The nvme pci driver prepares its devices for power loss during suspend by
> shutting down the controllers. The power setting is deferred to pci driver's
> power management before the platform removes power. The suspend-to-idle
> mode, however, does not remove power.
> 
> NVMe devices that implement host managed power settings can achieve lower
> power and better transition latencies than using generic PCI power settings. Try
> to use this feature if the platform is not involved with the suspend. If successful,
> restore the previous power state on resume.
> 
> Cc: Mario Limonciello <Mario.Limonciello at dell.com>
> Cc: Kai Heng Feng <kai.heng.feng at canonical.com>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
> v1 -> v2:
> 
>   Split prep patches for the get features
> 
>   Ensure queued and dispatch IO completes before attempting to set the low
>   power state. This also required a sync to ensure that nothing timed
>   out or reset the controller while we attempted the intermittent queue freeze.
> 
>   Disable HMB if enabled. It is not clear this should be necessary except
>   through empirical reports.

Reviewing this, it looks like this series should have all the same important tenants
from the original functional patch, and looks promising to me.

I'll arrange some more testing on it.

> 
>  drivers/nvme/host/pci.c | 80
> +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c index
> 599065ed6a32..42d5c6369803 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -18,6 +18,7 @@
>  #include <linux/mutex.h>
>  #include <linux/once.h>
>  #include <linux/pci.h>
> +#include <linux/suspend.h>
>  #include <linux/t10-pi.h>
>  #include <linux/types.h>
>  #include <linux/io-64-nonatomic-lo-hi.h> @@ -116,6 +117,7 @@ struct
> nvme_dev {
>  	u32 cmbsz;
>  	u32 cmbloc;
>  	struct nvme_ctrl ctrl;
> +	u32 last_ps;
> 
>  	mempool_t *iod_mempool;
> 
> @@ -2829,11 +2831,87 @@ static void nvme_remove(struct pci_dev *pdev)  }
> 
>  #ifdef CONFIG_PM_SLEEP
> +static int nvme_deep_state(struct nvme_dev *dev) {
> +	struct pci_dev *pdev = to_pci_dev(dev->dev);
> +	struct nvme_ctrl *ctrl = &dev->ctrl;
> +	int ret = -EBUSY;;

Looks like a small typographical error with the double ;;

> +
> +	nvme_start_freeze(ctrl);
> +	nvme_wait_freeze(ctrl);
> +	nvme_sync_queues(ctrl);
> +
> +	if (ctrl->state != NVME_CTRL_LIVE &&
> +	    ctrl->state != NVME_CTRL_ADMIN_ONLY)
> +		goto unfreeze;
> +
> +	if (dev->host_mem_descs) {
> +		ret = nvme_set_host_mem(dev, 0);
> +		if (ret < 0)
> +			goto unfreeze;
> +	}
> +
> +	dev->last_ps = 0;
> +	ret = nvme_get_features(ctrl, NVME_FEAT_POWER_MGMT, 0, NULL, 0,
> +				&dev->last_ps);
> +	if (ret < 0)
> +		goto unfreeze;
> +
> +	ret = nvme_set_features(ctrl, NVME_FEAT_POWER_MGMT, dev-
> >ctrl.npss,
> +				NULL, 0, NULL);
> +	if (ret < 0)
> +		goto unfreeze;
> +
> +	if (ret) {
> +		/*
> +		 * Clearing npss forces a controller reset on resume. The
> +		 * correct value will be resdicovered then.
> +		 */
> +		ctrl->npss = 0;
> +		nvme_dev_disable(dev, true);
> +		ret = 0;
> +		goto unfreeze;
> +	}
> +
> +	/*
> +	 * A saved state prevents pci pm from generically controlling the
> +	 * device's power. We're using protocol specific settings so we don't
> +	 * want pci interfering.
> +	 */
> +	pci_save_state(pdev);
> +unfreeze:
> +	nvme_unfreeze(ctrl);
> +	return ret;
> +}
> +
> +static int nvme_make_operational(struct nvme_dev *dev) {
> +	struct nvme_ctrl *ctrl = &dev->ctrl;
> +	int ret;
> +
> +	ret = nvme_set_features(ctrl, NVME_FEAT_POWER_MGMT, dev-
> >last_ps,
> +				NULL, 0, NULL);
> +	if (ret)
> +		goto reset;
> +
> +	if (dev->host_mem_descs) {
> +		ret = nvme_setup_host_mem(dev);
> +		if (ret)
> +			goto reset;
> +	}
> +	return 0;
> +reset:
> +	nvme_reset_ctrl(ctrl);
> +	return 0;
> +}
> +
>  static int nvme_suspend(struct device *dev)  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct nvme_dev *ndev = pci_get_drvdata(pdev);
> 
> +	if (!pm_suspend_via_firmware() && ndev->ctrl.npss)
> +		return nvme_deep_state(ndev);
>  	nvme_dev_disable(ndev, true);
>  	return 0;
>  }
> @@ -2843,6 +2921,8 @@ static int nvme_resume(struct device *dev)
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct nvme_dev *ndev = pci_get_drvdata(pdev);
> 
> +	if (!pm_resume_via_firmware() && ndev->ctrl.npss)
> +		return nvme_make_operational(ndev);
>  	nvme_reset_ctrl(&ndev->ctrl);
>  	return 0;
>  }
> --
> 2.14.4
