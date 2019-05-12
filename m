From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 12 May 2019 23:30:58 +0900
Subject: [PATCH] nvme/pci: Use host managed power state for suspend
In-Reply-To: <SN6PR04MB452735778FD952AA838E78C9860E0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <SN6PR04MB452735778FD952AA838E78C9860E0@SN6PR04MB4527.namprd04.prod.outlook.com>
Message-ID: <20190512143056.GA7761@minwooim-desktop>

> > +	union nvme_result res;
> > +	int ret;
> > +
> > +	if (!result)
> > +		return -EINVAL;
> > +
> > +	memset(&c, 0, sizeof(c));
> > +	c.features.opcode = nvme_admin_get_features;
> > +	c.features.fid = cpu_to_le32(NVME_FEAT_POWER_MGMT);
> > +
> > +	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &c, &res,
> > +			NULL, 0, 0, NVME_QID_ANY, 0, 0, false);
> > +	if (ret >= 0)
> > +		*result = le32_to_cpu(res.u32);
> May be add a check for result here in above if before deref pointer :-
> 	if (ret >= 0 && result)
> 

'result' already has been checked in a few lines above.
