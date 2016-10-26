From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Wed, 26 Oct 2016 13:00:29 -0700
Subject: [PATCH v3 7/7] nvme-fabrics: Add FC LLDD loopback driver to
 test FC-NVME
In-Reply-To: <580d0fff.s6PUdAo4MvJBY1Pu%james.smart@broadcom.com>
References: <580d0fff.s6PUdAo4MvJBY1Pu%james.smart@broadcom.com>
Message-ID: <1477512029.3009.114.camel@linux.intel.com>



> +static struct fcloop_nport *
> +fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
> +{
> +	struct fcloop_nport *newnport, *nport = NULL;
> +	struct fcloop_lport *tmplport, *lport = NULL;
> +	struct fcloop_ctrl_options *opts;
> +	unsigned long flags;
> +	u32 opts_mask = (remoteport) ? RPORT_OPTS : TGTPORT_OPTS;
> +	int ret;
> +
> +	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
> +	if (!opts)
> +		return NULL;
> +
> +	ret = fcloop_parse_options(opts, buf);
> +	if (ret)
> +		goto out_free_opts;
> +
> +	/* everything there ? */
> +	if ((opts->mask & opts_mask) != opts_mask) {
> +		ret = -EINVAL;
> +		goto out_free_opts;
> +	}
> +
> +	newnport = kzalloc(sizeof(*nport), GFP_KERNEL);

Nitpick- looks odd to use a pointer variable instead of *newnport for
the sizeof parameter, especially when that is the way '*opts' is done a
few lines above it.

> +	if (!newnport)
> +		goto out_free_opts;
> +
> +	INIT_LIST_HEAD(&newnport->nport_list);
> +	newnport->node_name = opts->wwnn;
> +	newnport->port_name = opts->wwpn;
> +	if (opts->mask & NVMF_OPT_ROLES)
> +		newnport->port_role = opts->roles;
> +	if (opts->mask & NVMF_OPT_FCADDR)
> +		newnport->port_id = opts->fcaddr;
> +	kref_init(&newnport->ref);
> +
> +	spin_lock_irqsave(&fcloop_lock, flags);
> +
> +	list_for_each_entry(tmplport, &fcloop_lports, lport_list) {
> +		if ((tmplport->localport->node_name == opts->wwnn)
> &&
> +		????(tmplport->localport->port_name == opts->wwpn))
> +			goto out_invalid_opts;
> +
> +		if ((tmplport->localport->node_name == opts->lpwwnn) 
> &&
> +		????(tmplport->localport->port_name == opts-
> >lpwwpn))
> +			lport = tmplport;
> +	}
> +
> +	if (remoteport) {
> +		if (!lport)
> +			goto out_invalid_opts;
> +		newnport->lport = lport;
> +	}
> +
> +	list_for_each_entry(nport, &fcloop_nports, nport_list) {
> +		if (nport->node_name == opts->wwnn &&
> +		????nport->port_name == opts->wwpn) {
> +			if ((remoteport && nport->rport) ||
> +			????(!remoteport && nport->tport)) {
> +				nport = NULL;
> +				goto out_invalid_opts;
> +			}
> +
> +			fcloop_nport_get(nport);
> +
> +			spin_unlock_irqrestore(&fcloop_lock, flags);
> +
> +			if (remoteport)
> +				nport->lport = lport;
> +			if (opts->mask & NVMF_OPT_ROLES)
> +				nport->port_role = opts->roles;
> +			if (opts->mask & NVMF_OPT_FCADDR)
> +				nport->port_id = opts->fcaddr;
> +			goto out_free_opts;

It looks like if we ever get here, we will leak memory as newnport has
been kzalloc'ed at this point but this will jump to the "out_free_opts"
goto statement.

> +		}
> +	}
> +
> +	list_add_tail(&newnport->nport_list, &fcloop_nports);
> +
> +	spin_unlock_irqrestore(&fcloop_lock, flags);
> +
> +	kfree(opts);
> +	return newnport;
> +
> +out_invalid_opts:
> +	spin_unlock_irqrestore(&fcloop_lock, flags);
> +	kfree(newnport);
> +out_free_opts:
> +	kfree(opts);
> +	return nport;
> +}
> +

> +static ssize_t
> +fcloop_create_remote_port(struct device *dev, struct
> device_attribute *attr,
> +		const char *buf, size_t count)
> +{
> +	struct nvme_fc_remote_port *remoteport;
> +	struct fcloop_nport *nport;
> +	struct fcloop_rport *rport;
> +	struct nvme_fc_port_info pinfo;
> +	int ret;
> +
> +	nport = fcloop_alloc_nport(buf, count, true);
> +	if (!nport)
> +		return -EIO;
> +
> +	pinfo.node_name = nport->node_name;
> +	pinfo.port_name = nport->port_name;
> +	pinfo.port_role = nport->port_role;
> +	pinfo.port_id = nport->port_id;
> +
> +	ret = nvme_fc_register_remoteport(nport->lport->localport,
> +						&pinfo,
> &remoteport);
> +	if (ret || !remoteport) {
> +		fcloop_nport_put(nport);
> +		return ret;

Possible memory leak for nport??

> +	}
> +
> +	/* success */
> +	rport = remoteport->private;
> +	rport->remoteport = remoteport;
> +	rport->targetport = (nport->tport) ???nport->tport-
> >targetport : NULL;
> +	if (nport->tport) {
> +		nport->tport->remoteport = remoteport;
> +		nport->tport->lport = nport->lport;
> +	}
> +	rport->nport = nport;
> +	rport->lport = nport->lport;
> +	nport->rport = rport;
> +
> +	return ret ? ret : count;
> +}
> +
> +

snip...

> +
> +static ssize_t
> +fcloop_create_target_port(struct device *dev, struct
> device_attribute *attr,
> +		const char *buf, size_t count)
> +{
> +	struct nvmet_fc_target_port *targetport;
> +	struct fcloop_nport *nport;
> +	struct fcloop_tport *tport;
> +	struct nvmet_fc_port_info tinfo;
> +	int ret;
> +
> +	nport = fcloop_alloc_nport(buf, count, false);
> +	if (!nport)
> +		return -EIO;
> +
> +	tinfo.node_name = nport->node_name;
> +	tinfo.port_name = nport->port_name;
> +	tinfo.port_id = nport->port_id;
> +
> +	ret = nvmet_fc_register_targetport(&tinfo, &tgttemplate,
> NULL,
> +						&targetport);
> +	if (ret) {
> +		fcloop_nport_put(nport);
> +		return ret;

Possible memory leak by not de-allocating 'nport'?

> +	}
> +
> +	/* success */
> +	tport = targetport->private;
> +	tport->targetport = targetport;
> +	tport->remoteport = (nport->rport) ???nport->rport-
> >remoteport : NULL;
> +	if (nport->rport)
> +		nport->rport->targetport = targetport;
> +	tport->nport = nport;
> +	tport->lport = nport->lport;
> +	nport->tport = tport;
> +
> +	return ret ? ret : count;
> +}
> +
>?

Thanks,
J
