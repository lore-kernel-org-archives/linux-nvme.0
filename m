From: kbusch@kernel.org (Keith Busch)
Date: Tue, 7 May 2019 11:07:34 -0600
Subject: [PATCH v2 6/7] nvme-pci: add device coredump support
In-Reply-To: <1557248314-4238-7-git-send-email-akinobu.mita@gmail.com>
References: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
 <1557248314-4238-7-git-send-email-akinobu.mita@gmail.com>
Message-ID: <20190507170733.GA6783@localhost.localdomain>

On Wed, May 08, 2019@01:58:33AM +0900, Akinobu Mita wrote:
> +static void nvme_coredump(struct device *dev)
> +{
> +	struct nvme_dev *ndev = dev_get_drvdata(dev);
> +
> +	mutex_lock(&ndev->shutdown_lock);
> +
> +	nvme_coredump_prologue(ndev);
> +	nvme_coredump_epilogue(ndev);
> +
> +	mutex_unlock(&ndev->shutdown_lock);
> +}

This is a bit of a mine field. The shutdown_lock is held when reclaiming
requests that didn't see a response. If you're holding it here and your
telemetry log page times out, we're going to deadlock. And since the
controller is probably in a buggered state when you try to retrieve one,
I would guess an unrecoverable timeout is the most likely outcome.
