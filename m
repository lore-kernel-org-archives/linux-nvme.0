From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 30 Aug 2018 17:25:09 -0700
Subject: [PATCH v5 13/13] nvmet: Optionally use PCI P2P memory
In-Reply-To: <20180830185352.3369-14-logang@deltatee.com>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-14-logang@deltatee.com>
Message-ID: <ecbb669a-2e84-1333-7e0d-1560cf014750@grimberg.me>


> +/*
> + * If allow_p2pmem is set, we will try to use P2P memory for the SGL lists for
> + * ?/O commands. This requires the PCI p2p device to be compatible with the
> + * backing device for every namespace on this controller.
> + */
> +static void nvmet_setup_p2pmem(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
> +{
> +	struct nvmet_ns *ns;
> +	int ret;
> +
> +	if (!req->port->use_p2pmem || !req->p2p_client)
> +		return;
> +
> +	mutex_lock(&ctrl->subsys->lock);
> +
> +	ret = pci_p2pdma_add_client(&ctrl->p2p_clients, req->p2p_client);
> +	if (ret) {
> +		pr_err("failed adding peer-to-peer DMA client %s: %d\n",
> +		       dev_name(req->p2p_client), ret);
> +		goto free_devices;
> +	}
> +
> +	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link) {
> +		ret = nvmet_p2pdma_add_client(ctrl, ns);
> +		if (ret)
> +			goto free_devices;
> +	}
> +
> +	if (req->port->p2p_dev) {
> +		if (!pci_p2pdma_assign_provider(req->port->p2p_dev,
> +						&ctrl->p2p_clients)) {
> +			pr_info("peer-to-peer memory on %s is not supported\n",
> +				pci_name(req->port->p2p_dev));
> +			goto free_devices;
> +		}
> +		ctrl->p2p_dev = pci_dev_get(req->port->p2p_dev);
> +	} else {

When is port->p2p_dev == NULL? a little more documentation would help 
here...
