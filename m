From: keith.busch@intel.com (Keith Busch)
Date: Tue, 30 Jan 2018 09:13:02 -0700
Subject: [PATCH] nvme-pci: use NOWAIT flag for nvme_set_host_mem
In-Reply-To: <c3116e1b-481a-1b3f-b29c-7de95929ecb8@oracle.com>
References: <1517195255-21832-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180129160145.GA25515@localhost.localdomain>
 <1b7d3700-945f-9272-b6aa-d2ebeaf0cb1e@grimberg.me>
 <20180129201716.GB25515@localhost.localdomain>
 <c3116e1b-481a-1b3f-b29c-7de95929ecb8@oracle.com>
Message-ID: <20180130161302.GA27205@localhost.localdomain>

On Tue, Jan 30, 2018@11:41:07AM +0800, jianchao.wang wrote:
> Another point that confuses me is that whether nvme_set_host_mem is necessary
> in nvme_dev_disable ?
> As the comment:
> ----
> 		/*
> 		 * If the controller is still alive tell it to stop using the
> 		 * host memory buffer.  In theory the shutdown / reset should
> 		 * make sure that it doesn't access the host memoery anymore,
> 		 * but I'd rather be safe than sorry..
> 		 */
> 		if (dev->host_mem_descs)
> 			nvme_set_host_mem(dev, 0);
> ----
> It is to avoid accessing to host memory from controller. But the host memory is just
> freed when nvme_remove. It looks like we just need to do this in nvme_remove.
> For example:
> -----
> @@ -2553,6 +2545,14 @@ static void nvme_remove(struct pci_dev *pdev)
>         flush_work(&dev->ctrl.reset_work);
>         nvme_stop_ctrl(&dev->ctrl);
>         nvme_remove_namespaces(&dev->ctrl);
> +       /*
> +        * If the controller is still alive tell it to stop using the
> +        * host memory buffer.  In theory the shutdown / reset should
> +        * make sure that it doesn't access the host memoery anymore,
> +        * but I'd rather be safe than sorry..
> +        */
> +       if (dev->host_mem_descs)
> +               nvme_set_host_mem(dev, 0);
>         nvme_dev_disable(dev, true);
>         nvme_free_host_mem(dev);
> ----
> 
> If anything missed, please point out.
> That's really appreciated.

I don't make any such controller, so I can't speak to the necessity of
having this here. I just think having it in the controller disabling
path is for safety. We want the controller to acknowledge that it has
completed any use of the HMB before we make it so it can't access it.
