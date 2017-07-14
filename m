From: hch@lst.de (Christoph Hellwig)
Date: Fri, 14 Jul 2017 14:48:40 +0200
Subject: [PATCH v2 2/2] nvmet: preserve controller serial number
 between reboots
In-Reply-To: <20170714124632.GA13633@linux-x5ow.site>
References: <20170714120517.13552-1-jthumshirn@suse.de>
 <20170714120517.13552-3-jthumshirn@suse.de> <20170714123208.GE26187@lst.de>
 <20170714124632.GA13633@linux-x5ow.site>
Message-ID: <20170714124840.GA26791@lst.de>

On Fri, Jul 14, 2017@02:46:32PM +0200, Johannes Thumshirn wrote:
> On Fri, Jul 14, 2017@02:32:08PM +0200, Christoph Hellwig wrote:
> > This patch itself looks good:
> > 
> > Reviewed-by: Christoph Hellwig <hch at lst.de>
> > 
> > >  static struct configfs_attribute *nvmet_subsys_attrs[] = {
> > >  	&nvmet_subsys_attr_attr_allow_any_host,
> > >  	&nvmet_subsys_attr_version,
> > > +	&nvmet_subsys_attr_attr_serial,
> > 
> > but the new version attribute really needs the attr prefix so that
> > nvmetcli can pick it up.  And we should also add nvmetcli support
> > for it.  Can you do the rename before your series to ease backporting
> > as that should go into 3.12 (just like your serial number fix).
> > 
> 
> Is it OK if I send the patches in the same series? 

Yes.  Just move the version fix to the beginning, please.
