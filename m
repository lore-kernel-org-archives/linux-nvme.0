From: kbusch@kernel.org (Keith Busch)
Date: Mon, 13 May 2019 07:52:35 -0600
Subject: [PATCH v3 6/7] nvme-pci: trigger device coredump on command
 timeout
In-Reply-To: <1557676457-4195-7-git-send-email-akinobu.mita@gmail.com>
References: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
 <1557676457-4195-7-git-send-email-akinobu.mita@gmail.com>
Message-ID: <20190513135235.GD15318@localhost.localdomain>

On Sun, May 12, 2019@08:54:16AM -0700, Akinobu Mita wrote:
> @@ -2536,6 +2539,9 @@ static void nvme_reset_work(struct work_struct *work)
>  	if (result)
>  		goto out;
>  
> +	nvme_coredump_logs(dev);

If you change nvme_coredump_logs to return an int, check it here for < 0
and abandon the reset if true.

> +	nvme_coredump_complete(dev);
> +
>  	if (dev->ctrl.oacs & NVME_CTRL_OACS_SEC_SUPP) {
>  		if (!dev->ctrl.opal_dev)
>  			dev->ctrl.opal_dev =
