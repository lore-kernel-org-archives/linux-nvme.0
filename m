From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 20 Jul 2018 09:01:07 -0700
Subject: [RFC PATCH 0/2] Re-work CMB and add WDS support.
In-Reply-To: <20180720145009.GB9294@sbauer-Z170X-UD5>
References: <20180719230628.31494-1-scott.bauer@intel.com>
 <20180720144628.GA29886@infradead.org>
 <20180720145009.GB9294@sbauer-Z170X-UD5>
Message-ID: <20180720160107.GA10150@infradead.org>

On Fri, Jul 20, 2018@08:50:10AM -0600, Scott Bauer wrote:
> On Fri, Jul 20, 2018@07:46:28AM -0700, Christoph Hellwig wrote:
> > On Thu, Jul 19, 2018@05:06:26PM -0600, Scott Bauer wrote:
> > > The second patch unfortunately bounces (memcpys) the data from host to CMB.
> > > I originally tried to map the CMB into userspace via a custom nvme mmap
> > > handler, but I'm dumb and could never get gup for direct io working correctly.
> > 
> > Why?
> 
> What part are you asking why about? 

All of the above.  What is the motivation for this series?
