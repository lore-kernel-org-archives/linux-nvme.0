From: Stephen.Bates@pmcs.com (Stephen Bates)
Date: Wed, 1 Jul 2015 19:14:57 +0000
Subject: [PATCHv2 2/2] NVMe: Use CMB for the SQ if available
In-Reply-To: <20150701165448.GA3290@localhost.localdomain>
References: <1435098787-13083-1-git-send-email-jonathan.derrick@intel.com>
 <1435098787-13083-3-git-send-email-jonathan.derrick@intel.com>
 <36F6EBABA23FEF4391AF72944D228901EB289031@BBYEXM02.pmc-sierra.internal>
 <20150701165448.GA3290@localhost.localdomain>
Message-ID: <36F6EBABA23FEF4391AF72944D228901EB289BEC@BBYEXM02.pmc-sierra.internal>

Jon

> > This seems a little backwards to me in the sense that if the drive advertises
> CMB with SQ support the host is forced into using the CMB for SQs. Surely
> the host should have some ability to over-ride what the drive says? At the
> very least an argument into the  module to ignore CMB capabilities seems
> appropriate.
> 
> That seems like a good idea to allow it to be disabled as a module param

Great.

> 
> >Ultimately it would be good to have the host have the ability to use its
> preference when a device is reset. Or am I missing something?
> 
> Would using a module param cover your concerns here?

I would find that acceptable to get the CMB support started and sufficient for your patchset. As we add support for other CMB areas I think we need something a bit more flexible for two reasons:

1. To allocate the CMB space up for SQs, CQ, WDS, RDS zones. The host should have a way of controlling how the CMB is split  up when we have support for more than one CMB  data type.

2. As noted in my earlier email we might want to change the allocation in a semi-dynamic fashion (via a device reset perhaps).

But I think we can add this functionality over time. Happy to hear what others think though.

Cheers

Stephen Bates

> -----Original Message-----
> From: Jon Derrick [mailto:jonathan.derrick at intel.com]
> Sent: Wednesday, July 1, 2015 5:55 PM
> To: Stephen Bates
> Cc: linux-nvme at lists.infradead.org; keith.busch at intel.com
> Subject: Re: [PATCHv2 2/2] NVMe: Use CMB for the SQ if available
> 
> Hi Stephen,
> 
> Thanks for reviewing
> 
> > This seems a little backwards to me in the sense that if the drive advertises
> CMB with SQ support the host is forced into using the CMB for SQs. Surely
> the host should have some ability to over-ride what the drive says? At the
> very least an argument into the  module to ignore CMB capabilities seems
> appropriate.
> 
> That seems like a good idea to allow it to be disabled as a module param
> 
> >Ultimately it would be good to have the host have the ability to use its
> preference when a device is reset. Or am I missing something?
> 
> Would using a module param cover your concerns here?
