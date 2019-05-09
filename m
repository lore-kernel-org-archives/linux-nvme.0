From: kbusch@kernel.org (Keith Busch)
Date: Thu, 9 May 2019 15:54:09 -0600
Subject: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
In-Reply-To: <7a002851c435481593f8629ec9193e40@AUSX13MPC101.AMER.DELL.COM>
References: <064701C3-2BD4-4D93-891D-B7FBB5040FC4@canonical.com>
 <CAJZ5v0ggMwpJt=XWXu4gU51o8y4BpJ4KZ5RKzfk3+v8GGb-QbQ@mail.gmail.com>
 <A4DD2E9F-054E-4D4B-9F77-D69040EBE120@canonical.com>
 <20190509095601.GA19041@lst.de>
 <225CF4F7-C8E1-4C66-B362-97E84596A54E@canonical.com>
 <20190509103142.GA19550@lst.de>
 <AB325926-0D77-4851-8E8A-A10599756BF9@canonical.com>
 <31b7d7959bf94c15a04bab0ced518444@AUSX13MPC101.AMER.DELL.COM>
 <20190509192807.GB9675@localhost.localdomain>
 <7a002851c435481593f8629ec9193e40@AUSX13MPC101.AMER.DELL.COM>
Message-ID: <20190509215409.GD9675@localhost.localdomain>

On Thu, May 09, 2019@09:37:58PM +0000, Mario.Limonciello@dell.com wrote:
> > +int nvme_set_power(struct nvme_ctrl *ctrl, unsigned npss)
> > +{
> > +	int ret;
> > +
> > +	mutex_lock(&ctrl->scan_lock);
> > +	nvme_start_freeze(ctrl);
> > +	nvme_wait_freeze(ctrl);
> > +	ret = nvme_set_features(ctrl, NVME_FEAT_POWER_MGMT, npss, NULL, 0,
> > +				NULL);
> > +	nvme_unfreeze(ctrl);
> > +	mutex_unlock(&ctrl->scan_lock);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(nvme_set_power);
> 
> I believe without memory barriers at the end disks with HMB this will
> still kernel panic (Such as Toshiba BG3).

Well, the mutex has an implied memory barrier, but your HMB explanation
doesn't make much sense to me anyway. The "mb()" in this thread's original
patch is a CPU memory barrier, and the CPU had better not be accessing
HMB memory. Is there something else going on here?
 
> This still allows D3 which we found at least failed to go into deepest state and blocked
> platform s0ix for the following SSDs (maybe others):
> Hynix PC601
> LiteOn CL1

We usually write features to spec first, then quirk non-compliant
devices after.
