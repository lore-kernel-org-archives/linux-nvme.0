From: keith.busch@intel.com (Keith Busch)
Date: Wed, 18 Apr 2018 07:26:58 -0600
Subject: [PATCH] nvme: Fix disk names when not using nvme multipath
In-Reply-To: <20180418064412.GB11757@lst.de>
References: <20180417220344.14698-1-keith.busch@intel.com>
 <20180418064412.GB11757@lst.de>
Message-ID: <20180418132657.GJ11513@localhost.localdomain>

On Wed, Apr 18, 2018@08:44:12AM +0200, Christoph Hellwig wrote:
> On Tue, Apr 17, 2018@04:03:44PM -0600, Keith Busch wrote:
> > When CONFIG_NVME_MULTIPATH is set, but we're not using nvme to multipath,
> > namespaces with multiple paths were not creating unique names due to
> > reusing the same instance number from the namespace's head.
> 
> Hmm.  They should still differ in the controller instance, though.
> 
> Shouldn't we need something like this instead (untested):
> 
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 197a6ba9700f..bfd67bc71455 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3001,10 +3001,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  		sprintf(disk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
>  				ctrl->cntlid, ns->head->instance);
>  		flags = GENHD_FL_HIDDEN;
> -	} else {
> -		sprintf(disk_name, "nvme%dn%d", ctrl->subsys->instance,
> -				ns->head->instance);
> -	}
> +	} else
>  #else
>  	/*
>  	 * But without the multipath code enabled, multiple controller per

No-can-do. If we did that with nvme-multipath, we could find NMIC
namespaces using the susbystem instance for the disk name, and non-NMIC
using the controller instance: we'll have a different set of name
conflicts to deal with.
