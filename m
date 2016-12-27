From: scott.bauer@intel.com (Scott Bauer)
Date: Tue, 27 Dec 2016 15:12:22 -0700
Subject: [PATCH v3 4/5] nvme: Implement resume_from_suspend and SED
 Allocation code.
In-Reply-To: <3d8b8516-aac6-c11c-dbbb-47fc01308f8c@jbeekman.nl>
References: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
 <1482176149-2257-5-git-send-email-scott.bauer@intel.com>
 <3d8b8516-aac6-c11c-dbbb-47fc01308f8c@jbeekman.nl>
Message-ID: <20161227221221.GA2902@sbauer-Z170X-UD5>

On Sun, Dec 25, 2016@03:15:52PM +0100, Jethro Beekman wrote:
> On 19-12-16 20:35, Scott Bauer wrote:
> > @@ -1796,6 +1797,13 @@ static void nvme_reset_work(struct work_struct *work)
> >  	if (result)
> >  		goto out;
> >  
> > +	result = nvme_opal_initialize(&dev->ctrl);
> > +	if (result)
> > +		goto out;
> 
> It seems you always try to intialize OPAL even if the drive doesn't support it.
> I think you should check if the device supports security commands and then see
> if it supports OPAL before calling this. See e.g.
> https://lkml.org/lkml/2016/6/19/139 . Ideally, this code would check all
> supported protocols and initialize the appropriate security device based on that.

The nvme_opal_initalize should probably be changed to nvme_opal_allocate or something.
It's not really initalizing anything other than allocting the necessary structures
for OPAL. In order to determine if the controller supports opal we need to allocate
the previously mentioned structures anyway. I want to stay away from making payloads
(specifically discovery0 ) payload in the nvme driver and allow the opal core to do a
all the grunt work. In the future we'll probably have to refactor the core a bit to do
just packet generation. It looks like at least for NVMe we're going to have to do a discovery
to figure out whether we've got mutiple locking ranges per NS or just one global lr during
initialization.
