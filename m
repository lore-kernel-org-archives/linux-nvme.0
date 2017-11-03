From: joe@perches.com (Joe Perches)
Date: Fri, 03 Nov 2017 08:16:37 -0700
Subject: [PATCH 3/3] nvme: fix eui_show() print format
In-Reply-To: <20171103125516.GC25186@lst.de>
References: <1509703370-20379-1-git-send-email-javier@cnexlabs.com>
 <1509703370-20379-4-git-send-email-javier@cnexlabs.com>
 <20171103125516.GC25186@lst.de>
Message-ID: <1509722197.15520.17.camel@perches.com>

On Fri, 2017-11-03@13:55 +0100, Christoph Hellwig wrote:
> On Fri, Nov 03, 2017@11:02:50AM +0100, Javier Gonz?lez wrote:
> > Signed-off-by: Javier Gonz?lez <javier at cnexlabs.com>
[]
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
[]
> > @@ -2108,7 +2108,7 @@ static ssize_t eui_show(struct device *dev, struct device_attribute *attr,
> >  								char *buf)
> >  {
> >  	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
> > -	return sprintf(buf, "%8phd\n", ns->eui);
> > +	return sprintf(buf, "%8phD\n", ns->eui);
> >  }
> >  static DEVICE_ATTR(eui, S_IRUGO, eui_show, NULL);
> 
> This looks correct.  I wonder what the old code printed - does someone
> have a device with an EUI-64 at hand to quickly cross check what we
> did before?

It uses spaces between bytes and not dashes.

The code has been this way a couple years now.

I think this proposal, while it might fix an
unintentional output style, could also be an API
and could cause user breakage if changed.

Perhaps this should just become

	%8ph

without D
