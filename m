From: keith.busch@intel.com (Keith Busch)
Date: Wed, 18 Apr 2018 09:34:11 -0600
Subject: [PATCH] nvme: Fix disk names when not using nvme multipath
In-Reply-To: <20180418150429.GA7862@lst.de>
References: <20180417220344.14698-1-keith.busch@intel.com>
 <20180418064412.GB11757@lst.de>
 <20180418132657.GJ11513@localhost.localdomain>
 <20180418150429.GA7862@lst.de>
Message-ID: <20180418153410.GM11513@localhost.localdomain>

On Wed, Apr 18, 2018@05:04:29PM +0200, Christoph Hellwig wrote:
> On Wed, Apr 18, 2018@07:26:58AM -0600, Keith Busch wrote:
> > No-can-do. If we did that with nvme-multipath, we could find NMIC
> > namespaces using the susbystem instance for the disk name, and non-NMIC
> > using the controller instance: we'll have a different set of name
> > conflicts to deal with.
> 
> True.  ? think I was also trying to solve the wrong problem to start
> with, that's what happens if you get up a 4am :)
> 
> Another just as completely untested attempt below:

It's a bit of an eyesore, but looks like it will work for the most
part. :)
 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 197a6ba9700f..ffca28dd2836 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -68,6 +68,11 @@ static bool streams;
>  module_param(streams, bool, 0644);
>  MODULE_PARM_DESC(streams, "turn on support for Streams write directives");
>  
> +bool multipath = true;
> +module_param(multipath, bool, 0644);

I think the permissions just have to be 0444 so that the user can't change the
naming method after some disks were named with the alternate method.

> +MODULE_PARM_DESC(multipath,
> +	"turn on native support for multiple controllers per subsystem");
