From: james.smart@broadcom.com (James Smart)
Date: Tue, 4 Dec 2018 14:09:42 -0800
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
Message-ID: <975230d1-01b4-64a7-f906-ca1a6893f846@broadcom.com>



On 12/4/2018 1:21 PM, Keith Busch wrote:
> On Tue, Dec 04, 2018@11:33:33AM -0800, James Smart wrote:
>> I disagree.? The cases I've run into are on the admin queue - where we are
>> sending io to initialize the controller when another error/reset occurs, and
>> the checks are required to identify/reject the "old" initialization
>> commands, with another state check allowing them to proceed on the "new"
>> initialization commands.? And there are also cases for ioctls and other
>> things that occur during the middle of those initialization steps that need
>> to be weeded out.?? The Admin queue has to be kept live to allow the
>> initialization commands on the new controller.
>>
>> state checks are also needed for those namespace validation cases....
>>
>>> Once quiesced, the proposed iterator can handle the final termination
>>> of the request, perform failover, or some other lld specific action
>>> depending on your situation.
>> I don't believe they can remain frozen, definitely not for the admin queue.
>> -- james
> Quiesced and frozen carry different semantics.
>
> My understanding of the nvme-fc implementation is that it returns
> BLK_STS_RESOURCE in the scenario you've described where the admin
> command can't be executed at the moment. That just has the block layer
> requeue it for later resubmission 3 milliseconds later, which will
> continue to return the same status code until you're really ready for
> it.

BLK_STS_RESOURCE is correct - but for "normal" io, which comes from the 
filesystem, etc and are mostly on the io queues.

But if the io originated from other sources, like the core layer via 
nvme_alloc_request() - used by lots of service routines for the 
transport to initialize the controller, core routines to talk to the 
controller, and ioctls from user space - then they are failed with a 
PATHING ERROR status.? The status doesn't mean much to these other 
places which mainly care if they succeed or not, and if not, they fail 
and unwind.? It's pretty critical for these paths to get that error 
status as many of those threads do synchronous io.? And this is not just 
for nvme-fc. Any transport initializing the controller and getting half 
way through it when an error occurs that kills the association will 
depend on this behavior.? PCI is a large exception as interaction with a 
pci function is very different from sending packets over a network and 
detecting network errors.

Io requests, on the io queues, that are flagged as multipath, also are 
failed this way rather than requeued.? We would need some iterator here 
to classify the type of io (one valid to go down another path) and move 
it to another path (but the transport doesn't want to know about other 
paths).


>
> What I'm proposing is that instead of using that return code, you may
> have nvme-fc control when to dispatch those queued requests by utilizing
> the blk-mq quiesce on/off states. Is there a reason that wouldn't work?

and quiesce on/off isn't sufficient to do this.

-- james
