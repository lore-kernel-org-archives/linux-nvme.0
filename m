From: sbradshaw@micron.com (Sam Bradshaw (sbradshaw))
Date: Thu, 19 Feb 2015 17:45:08 +0000
Subject: [PATCH] NVMe: Metadata and PI format support
In-Reply-To: <alpine.LNX.2.00.1502191700160.32385@localhost.lm.intel.com>
References: <1422670317-23420-1-git-send-email-keith.busch@intel.com>
 <80B89753B40C5141A3E2D53FE7A2A8A99979435A@NTXBOIMBX02.micron.com>
 <alpine.LNX.2.00.1502171449101.32385@localhost.lm.intel.com>
 <54E3747A.2000902@micron.com>
 <alpine.LNX.2.00.1502191700160.32385@localhost.lm.intel.com>
Message-ID: <80B89753B40C5141A3E2D53FE7A2A8A99979D6B5@NTXBOIMBX02.micron.com>



> -----Original Message-----
> From: Keith Busch [mailto:keith.busch at intel.com]
> Sent: Thursday, February 19, 2015 9:06 AM
> To: Sam Bradshaw (sbradshaw)
> Cc: Keith Busch; linux-nvme at lists.infradead.org
> Subject: Re: [PATCH] NVMe: Metadata and PI format support
> 
> On Tue, 17 Feb 2015, Sam Bradshaw wrote:
> >>> If there is interest in incorporating this support, we can provide
> a
> >>> patch on top of this that enables 16b/32b/64b metadata with PI and
> >>> supports PIL={0,1}
> >>
> >> I would also like that to work. I was hoping to reuse the
> >> t10_pi_generate/verify functions for this. Those can work if the
> >> iter->prot_buf is incremented by the blk_intergity's tuple_size
> >> iter->rather
> >> than just the 8-byte PI field.
> >>
> >> That'd work with PIL=0, not sure what to do with PIL=1. Maybe we
> >> should just define our own functions for nvme even though they'd
> >> mostly be the same as the ones scsi uses.
> >
> > We were unable to come up with an elegant solution that reused the
> > t10_pi_generate/verify functions while also handling the PIL=1 case.
> > So we defined our own functions.
> 
> I see you support 16/32/64 exclusively. As unlikely it may be someone
> would implement something other than those, the specification allows
> 64k different metadata formats with as many more combinations for PIL.
> Could the solution be generalized to accomodate arbitrary formats in a
> single function rather than require a definition for each possible
> combination?

Probably.  I see a few different solutions but perhaps the simplest would be to 
attach an opaque pointer to struct blk_integrity to encapsulate the namespace 
specific metadata details and have the iterator pass it back to the generator/verifier 
function.

It might make sense to make these changes in combination with enhancements to the
iterator to handle CRC calculation/verification that cross multiple bvecs.

-Sam
