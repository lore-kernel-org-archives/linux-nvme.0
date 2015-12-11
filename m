From: keith.busch@intel.com (Keith Busch)
Date: Fri, 11 Dec 2015 20:33:58 +0000
Subject: [PATCH] nvme: Allow controllers to specify a min queue depth
 for CMB
In-Reply-To: <20151211202546.GA4116@localhost.localdomain>
References: <1449862594-26103-1-git-send-email-jonathan.derrick@intel.com>
 <20151211200653.GA26595@lst.de>
 <20151211202546.GA4116@localhost.localdomain>
Message-ID: <20151211203358.GA24365@localhost.localdomain>

On Fri, Dec 11, 2015@01:25:46PM -0700, Jon Derrick wrote:
> Hi Christoph,
> 
> >  - please don't overload the quirks bitmap with actual values
> I agree it may not have been the best place for it, but I wasn't sure how/where it could go to be matched with specific devices. Certain devices may want 8, 16, or 32.

IMHO, I think these need to be tunable from sysfs. There are several
ideas on carving up CMB for various purposes, and don't think we can
let the driver make these policy decisions for the user.
 
> >  - why do we even need to add a quirk?  I quick look at the spec
> >    doesn't seem to require us to align the submission queue size
> >  - this patchs adds a quirk, but no use of it so it's effectively just dead
> >    code
> It is not that apparent. It inherits the restriction on the Create I/O Submission Queue command (NVM-Express 1.2a, 5.4, Figure 54).

I just kicked the technical reflector to fix this restriction on CMB
queues. Let's see how that plays out.
