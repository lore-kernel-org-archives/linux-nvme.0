From: keith.busch@intel.com (Keith Busch)
Date: Tue, 4 Dec 2018 14:43:49 -0700
Subject: [PATCH 1/2] blk-mq: Export iterating all tagged requests
In-Reply-To: <20181204212117.GC16751@localhost.localdomain>
References: <20181130202635.11145-1-keith.busch@intel.com>
 <823fc3bf-78a4-c8fb-c80c-e3944f320af0@kernel.dk>
 <20181201164804.GB19557@lst.de>
 <9346f289-f265-e2ee-2d2c-c97973b45e23@suse.de>
 <8cd9a950-6605-6387-e4d4-4346a46da781@grimberg.me>
 <20181204154559.GJ14775@localhost.localdomain>
 <11e02aa5-b0cb-b4cf-0af4-da3db8db9e36@grimberg.me>
 <20181204174806.GA16751@localhost.localdomain>
 <b5b306cd-7341-7ce3-f2dc-fe98a01327fe@broadcom.com>
 <20181204212117.GC16751@localhost.localdomain>
Message-ID: <20181204214349.GD16751@localhost.localdomain>

On Tue, Dec 04, 2018@02:21:17PM -0700, Keith Busch wrote:
> On Tue, Dec 04, 2018@11:33:33AM -0800, James Smart wrote:
> > On 12/4/2018 9:48 AM, Keith Busch wrote:
> > > Once quiesced, the proposed iterator can handle the final termination
> > > of the request, perform failover, or some other lld specific action
> > > depending on your situation.
> > 
> > I don't believe they can remain frozen, definitely not for the admin queue.
> > -- james
> 
> Quiesced and frozen carry different semantics.
> 
> My understanding of the nvme-fc implementation is that it returns
> BLK_STS_RESOURCE in the scenario you've described where the admin
> command can't be executed at the moment. That just has the block layer
> requeue it for later resubmission 3 milliseconds later, which will
> continue to return the same status code until you're really ready for
> it.
> 
> What I'm proposing is that instead of using that return code, you may
> have nvme-fc control when to dispatch those queued requests by utilizing
> the blk-mq quiesce on/off states. Is there a reason that wouldn't work?

BTW, this is digressing from this patch's use case. The proposed iteration
doesn't come into play for the above scenario, which can be handled with
existing interfaces.
