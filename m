From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 24 May 2018 09:16:34 -0600
Subject: [PATCHv2 0/8] nvme timeout fixes v2
In-Reply-To: <CACVXFVOgKq78d97jw6cGc5=kZmEjW-DcEKYuicPUmm007OSPkA@mail.gmail.com>
References: <20180522220332.9244-1-keith.busch@intel.com>
 <20180523030057.GF31196@ming.t460p>
 <20180523161614.GE11037@localhost.localdomain>
 <20180524032257.GB15354@ming.t460p>
 <20180524135757.GI11037@localhost.localdomain>
 <CACVXFVOgKq78d97jw6cGc5=kZmEjW-DcEKYuicPUmm007OSPkA@mail.gmail.com>
Message-ID: <20180524151634.GJ11037@localhost.localdomain>

On Thu, May 24, 2018@11:04:29PM +0800, Ming Lei wrote:
> > Okay, fair enough. Easy enuogh to fix.
> >
> > Just a reality check here, what is your expectation for this test? Any
> > driver should just give up on device truly behaving this way should.
> 
> No IO hang, no oops, and either pass or fail should be fine.
> 
> Do you think this is reasonable?

Great, that is definitely reasonable.
