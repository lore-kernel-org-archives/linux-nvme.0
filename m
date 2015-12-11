From: jonathan.derrick@intel.com (Jon Derrick)
Date: Fri, 11 Dec 2015 13:59:34 -0700
Subject: [PATCH] nvme: Allow controllers to specify a min queue depth for
 CMB
In-Reply-To: <20151211203358.GA24365@localhost.localdomain>
References: <1449862594-26103-1-git-send-email-jonathan.derrick@intel.com>
 <20151211200653.GA26595@lst.de>
 <20151211202546.GA4116@localhost.localdomain>
 <20151211203358.GA24365@localhost.localdomain>
Message-ID: <20151211205934.GA4235@localhost.localdomain>

> > >  - please don't overload the quirks bitmap with actual values
> > I agree it may not have been the best place for it, but I wasn't sure how/where it could go to be matched with specific devices. Certain devices may want 8, 16, or 32.
> 
> IMHO, I think these need to be tunable from sysfs. There are several
> ideas on carving up CMB for various purposes, and don't think we can
> let the driver make these policy decisions for the user.
>  
I like that idea. We could do some interesting things by letting users/udev tweak the CMB's uses.
