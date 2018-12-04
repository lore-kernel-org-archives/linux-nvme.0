From: james.smart@broadcom.com (James Smart)
Date: Tue, 4 Dec 2018 11:33:33 -0800
Subject: [PATCH 1/2] blk-mq: Export iterating all tagged requests
In-Reply-To: <20181204174806.GA16751@localhost.localdomain>
References: <20181130202635.11145-1-keith.busch@intel.com>
 <823fc3bf-78a4-c8fb-c80c-e3944f320af0@kernel.dk>
 <20181201164804.GB19557@lst.de>
 <9346f289-f265-e2ee-2d2c-c97973b45e23@suse.de>
 <8cd9a950-6605-6387-e4d4-4346a46da781@grimberg.me>
 <20181204154559.GJ14775@localhost.localdomain>
 <11e02aa5-b0cb-b4cf-0af4-da3db8db9e36@grimberg.me>
 <20181204174806.GA16751@localhost.localdomain>
Message-ID: <b5b306cd-7341-7ce3-f2dc-fe98a01327fe@broadcom.com>



On 12/4/2018 9:48 AM, Keith Busch wrote:
> On Tue, Dec 04, 2018@09:38:29AM -0800, Sagi Grimberg wrote:
>>>>> Yes, I'm very much in favour of this, too.
>>>>> We always have this IMO slightly weird notion of stopping the queue, set
>>>>> some error flags in the driver, then _restarting_ the queue, just so
>>>>> that the driver then sees the error flag and terminates the requests.
>>>>> Which I always found quite counter-intuitive.
>>>> What about requests that come in after the iteration runs? how are those
>>>> terminated?
>>> If we've reached a dead state, I think you'd want to start a queue freeze
>>> before running the terminating iterator.
>> Its not necessarily dead, in fabrics we need to handle disconnections
>> that last for a while before we are able to reconnect (for a variety of
>> reasons) and we need a way to fail I/O for failover (or requeue, or
>> block its up to the upper layer). Its less of a "last resort" action
>> like in the pci case.
>>
>> Does this guarantee that after freeze+iter we won't get queued with any
>> other request? If not then we still need to unfreeze and fail at
>> queue_rq.
> It sounds like there are different scenarios to consider.
>
> For the dead controller, we call blk_cleanup_queue() at the end which
> ends callers who blocked on entering.
>
> If you're doing a failover, you'd replace the freeze with a current path
> update in order to prevent new requests from entering.
and if you're not multipath ???? I assume you want the io queues to be 
frozen so they queue there - which can block threads such as ns 
verification. It's good to have them live, as todays checks bounce the 
io, letting the thread terminate as its in a reset/reconnect state, 
which allows those threads to exit out or finish before a new reconnect 
kicks them off again. We've already been fighting deadlocks with the 
reset/delete/rescan paths and these io paths. suspending the queues 
completely over the reconnect will likely create more issues in this area.


> In either case, you don't need checks in queue_rq. The queue_rq check
> is redundant with the quiesce state that blk-mq already provides.

I disagree.? The cases I've run into are on the admin queue - where we 
are sending io to initialize the controller when another error/reset 
occurs, and the checks are required to identify/reject the "old" 
initialization commands, with another state check allowing them to 
proceed on the "new" initialization commands.? And there are also cases 
for ioctls and other things that occur during the middle of those 
initialization steps that need to be weeded out.?? The Admin queue has 
to be kept live to allow the initialization commands on the new controller.

state checks are also needed for those namespace validation cases....

>
> Once quiesced, the proposed iterator can handle the final termination
> of the request, perform failover, or some other lld specific action
> depending on your situation.

I don't believe they can remain frozen, definitely not for the admin queue.
-- james
