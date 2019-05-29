From: keith.busch@gmail.com (Keith Busch)
Date: Wed, 29 May 2019 09:15:28 -0600
Subject: [RFC PATCH] nvme: allowing transition from NVME_CTRL_NEW to
 NVME_CTRL_DELETING
In-Reply-To: <305425a3-a815-7842-85ec-eb4275d39780@grimberg.me>
References: <20190527040159.3631-1-lizhongfs@gmail.com>
 <305425a3-a815-7842-85ec-eb4275d39780@grimberg.me>
Message-ID: <CAOSXXT5g=6cH6f_jWtvymrAfhseY7GDNx0-NceujKSZFomeXyQ@mail.gmail.com>

On Tue, May 28, 2019@2:01 PM Sagi Grimberg <sagi@grimberg.me> wrote:
> @@ -2759,7 +2760,7 @@ static int nvme_probe(struct pci_dev *pdev, const
> struct pci_device_id *id)
>          dev_info(dev->ctrl.device, "pci function %s\n",
> dev_name(&pdev->dev));
>
>          nvme_get_ctrl(&dev->ctrl);
> -       async_schedule(nvme_async_probe, dev);
> +       dev->async_probe = async_schedule(nvme_async_probe, dev);
>
>          return 0;
>
> @@ -2804,6 +2805,7 @@ static void nvme_remove(struct pci_dev *pdev)
>   {
>          struct nvme_dev *dev = pci_get_drvdata(pdev);
>
> +       async_synchronize_cookie(dev->async_probe);
>          nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
>          pci_set_drvdata(pdev, NULL);
> --

This would take extra long to recover from a hot-remove during the
initial probe reset. That path would normally unblock any lost IO
immediately, but would now be blocked on the async work. That may be
acceptable though, since it's just the initial reset that needs to
sync, and it will eventually unblock itself through the timeout
handler later.
