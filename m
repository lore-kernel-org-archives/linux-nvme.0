From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 14 Feb 2017 00:17:50 -0800
Subject: [PATCH V5 1/4] block: sed-opal: change ioctl to take user
 pointer instead of unsinged long
In-Reply-To: <20170213161509.GA18913@sbauer-Z170X-UD5>
References: <1487002272-17940-1-git-send-email-scott.bauer@intel.com>
 <1487002272-17940-2-git-send-email-scott.bauer@intel.com>
 <20170213161509.GA18913@sbauer-Z170X-UD5>
Message-ID: <20170214081750.GA20251@infradead.org>

On Mon, Feb 13, 2017@09:15:10AM -0700, Scott Bauer wrote:
> esOn Mon, Feb 13, 2017@09:11:09AM -0700, Scott Bauer wrote:
> > Signed-off-by: Scott Bauer <scott.bauer at intel.com>
> > ---
> >  block/sed-opal.c         | 6 ++++--
> >  drivers/nvme/host/core.c | 3 ++-
> >  include/linux/sed-opal.h | 4 ++--
> >  3 files changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/block/sed-opal.c b/block/sed-opal.c
> > index bf1406e..2448d4a 100644
> > --- a/block/sed-opal.c
> > +++ b/block/sed-opal.c
> > @@ -2344,9 +2344,11 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
> >  }
> >  EXPORT_SYMBOL(opal_unlock_from_suspend);
> >  
> > -int sed_ioctl(struct opal_dev *dev, unsigned int cmd, unsigned long ptr)
> > +int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
> >  {
> > -	void __user *arg = (void __user *)ptr;
> > +	void *ioctl_ptr;
> > +	int ret = -ENOTTY;
> > +	unsigned int cmd_size = _IOC_SIZE(cmd);
> 
> ugh, I apparently messed up my rebase these should be in patch 2 or maybe I should
> sqash p1 and p2  together.

I guess it should be 1 and 3.  No real opinipon on that, but can you
chose a simpler and more fitting name than ioctl_ptr?  I'd suggest 'p'.
