From: keith.busch@intel.com (Keith Busch)
Date: Wed, 16 Aug 2017 12:07:14 -0400
Subject: nvme-4.14 rebased
In-Reply-To: <fe7dede5-824f-fc20-766d-417775193c66@intel.com>
References: <20170816081346.GA18770@lst.de>
 <fe7dede5-824f-fc20-766d-417775193c66@intel.com>
Message-ID: <20170816160714.GK7233@localhost.localdomain>

On Fri, Aug 11, 2017@05:08:37AM -0600, Jon Derrick wrote:
> On 08/16/2017 02:13 AM, Christoph Hellwig wrote:
> > Hi all,
> > 
> > I've rebased the nvme-4.14 branch on top of the nvme-4.13 branch
> > to avoid conflicts.  As part of that I made the timestamp set features
> > return an error similar to the other reset fixes.
> > 
> > Jon: can you double check the change is correct?
> > 
> 
> Hi Christoph,
> 
> The only thing I'd suggest is not letting a failure to set the timestamp
> be a failure to initialize the controller.

It looks like Christoph just has it fail initialization if the timestamp
feature command never gets a controller response. We actually do need
to abandon controller init in that case since the controller is disabled
in the timeout handler.
