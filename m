From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 30 May 2017 01:39:43 -0700
Subject: [PATCH v2 2/2] nvme_fc: add uevent for auto-connect
In-Reply-To: <20170513190559.25484-3-jsmart2021@gmail.com>
References: <20170513190559.25484-1-jsmart2021@gmail.com>
 <20170513190559.25484-3-jsmart2021@gmail.com>
Message-ID: <20170530083943.GB18275@infradead.org>

> +nvme_fc_signal_discovery_scan(struct nvme_fc_lport *lport,
> +		struct nvme_fc_rport *rport)
> +{
> +	char hostaddr[80];	/* NVMEFC_HOST_TRADDR=...*/
> +	char tgtaddr[80];	/* NVMEFC_TRADDR=...*/
> +	char *envp[4] = { "FC_EVENT=nvmediscovery", hostaddr, tgtaddr, NULL };
> +
> +	if (!(rport->remoteport.port_role & FC_PORT_ROLE_NVME_DISCOVERY))
> +		return;
> +
> +	snprintf(hostaddr, sizeof(hostaddr),
> +		"NVMEFC_HOST_TRADDR=nn-0x%016llx:pn-0x%016llx",
> +		lport->localport.node_name, lport->localport.port_name);
> +	snprintf(tgtaddr, sizeof(tgtaddr),
> +		"NVMEFC_TRADDR=nn-0x%016llx:pn-0x%016llx",
> +		rport->remoteport.node_name, rport->remoteport.port_name);
> +	kobject_uevent_env(&nvmefc_device->kobj, KOBJ_CHANGE, envp);

Please use kasprintf so that we have a dynamic allocation and don't
need to hardcode buffer sizes.

> +	spin_lock_irqsave(&rport->lock, flags);
> +	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
> +		if (__nvme_fc_options_match(opts, ctrl)) {
> +			found = true;
> +			break;
> +		}
> +	}
> +	spin_unlock_irqrestore(&rport->lock, flags);
> +
> +	if (found) {
> +		ret = -EALREADY;
> +		goto out_fail;
> +	}

Thus seems neither related to the intent of the patch, nor does it make
sense at all.
