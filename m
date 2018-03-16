From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Mar 2018 17:16:55 +0100
Subject: [GIT PULL] nvme fix for 4.16-rc6
In-Reply-To: <e58b5357-6885-75dc-c027-9bea3cd6829d@kernel.dk>
References: <20180316160110.GC720@localhost.localdomain>
 <e58b5357-6885-75dc-c027-9bea3cd6829d@kernel.dk>
Message-ID: <20180316161655.GA13293@lst.de>

On Fri, Mar 16, 2018@09:14:34AM -0700, Jens Axboe wrote:
> On 3/16/18 9:01 AM, Keith Busch wrote:
> > Hi Jens,
> > 
> > One last fix from Jianchao to address a troubling scenario Ming identified
> > with offlining CPUs that could leave nvme controllers unusable. We can
> > not allow that to occur, so we wish to include a new IRQ spread that
> > prevents that situation.
> 
> Since this isn't really a regression in this release, how about
> we push this one to 4.17 instead?

It is a regression in 4.15.  So I think we should fix this ASAP.
