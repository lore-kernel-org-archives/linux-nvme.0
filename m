From: keith.busch@intel.com (Keith Busch)
Date: Fri, 3 Nov 2017 09:13:51 -0600
Subject: [PATCH 3/3] nvme: fix eui_show() print format
In-Reply-To: <20171103125516.GC25186@lst.de>
References: <1509703370-20379-1-git-send-email-javier@cnexlabs.com>
 <1509703370-20379-4-git-send-email-javier@cnexlabs.com>
 <20171103125516.GC25186@lst.de>
Message-ID: <20171103151351.GB11300@localhost.localdomain>

On Fri, Nov 03, 2017@01:55:16PM +0100, Christoph Hellwig wrote:
> On Fri, Nov 03, 2017@11:02:50AM +0100, Javier Gonz?lez wrote:
> > Signed-off-by: Javier Gonz?lez <javier at cnexlabs.com>
> > ---
> >  drivers/nvme/host/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index ae8ab0a1ef0d..f05c81774abf 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
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

It just prints the same as the 'ph' format, which would look like this:

  01 02 03 04 05 06 07 08

The change will make it look like this:

  01-02-03-04-05-06-07-08

I think that was the original intention.

Reviewed-by: Keith Busch <keith.busch at intel.com>
