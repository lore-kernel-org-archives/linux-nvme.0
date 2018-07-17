From: hch@lst.de (Christoph Hellwig)
Date: Tue, 17 Jul 2018 15:55:27 +0200
Subject: [PATCH 2/5] nvmet: fixup crash on NULL device path
In-Reply-To: <f4775b23-c601-6e57-c892-be88a23c5cf3@suse.com>
References: <20180716105837.101125-1-hare@suse.de>
 <20180716105837.101125-3-hare@suse.de> <20180717134841.GA16604@lst.de>
 <f4775b23-c601-6e57-c892-be88a23c5cf3@suse.com>
Message-ID: <20180717135527.GA17719@lst.de>

On Tue, Jul 17, 2018@03:48:41PM +0200, Hannes Reinecke wrote:
> On 07/17/2018 03:48 PM, Christoph Hellwig wrote:
> > On Mon, Jul 16, 2018@12:58:34PM +0200, Hannes Reinecke wrote:
> >> index 094d216ae62a..76efc8120c00 100644
> >> --- a/drivers/nvme/target/configfs.c
> >> +++ b/drivers/nvme/target/configfs.c
> >> @@ -295,6 +295,12 @@ static ssize_t nvmet_ns_device_path_store(struct config_item *item,
> >>  	ns->device_path = kstrndup(page, strcspn(page, "\n"), GFP_KERNEL);
> >>  	if (!ns->device_path)
> >>  		goto out_unlock;
> >> +	if (!strlen(ns->device_path)) {
> >> +		kfree(ns->device_path);
> >> +		ns->device_path = NULL;
> >> +		ret = -EINVAL;
> >> +		goto out_unlock;
> >> +	}
> > 
> > I think this should rather be:
> > 
> > 	ret = -EINVAL;
> > 	len = strcspn(page, "\n");
> > 	if (len == 0)
> > 		goto out_unlock;
> > 	ret = -ENOMEM;
> > 	ns->device_path = kstrndup(page, len, GFP_KERNEL);
> > 	if (!ns->device_path)
> > 		goto out_unlock;
> > 
> Okay.

Actually, based on a comment in mm/util.c we could even use kmemdup_nul
instead of kstrndup, might be worth to give it a spin.

> > Looks sensible, but please split this into a separate patch.
> > 
> Right. And should be sent independently of the ANA stuff, too.

Yes, this looks like 4.18 material.
