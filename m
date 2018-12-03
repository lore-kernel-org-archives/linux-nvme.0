From: james.smart@broadcom.com (James Smart)
Date: Mon, 3 Dec 2018 10:57:35 -0800
Subject: [PATCH 1/2] blk-mq: Export iterating all tagged requests
In-Reply-To: <0dbbafd4-8b40-5a95-1ea5-30e2cd61826b@acm.org>
References: <20181130202635.11145-1-keith.busch@intel.com>
 <823fc3bf-78a4-c8fb-c80c-e3944f320af0@kernel.dk>
 <20181201164804.GB19557@lst.de>
 <9346f289-f265-e2ee-2d2c-c97973b45e23@suse.de>
 <0dbbafd4-8b40-5a95-1ea5-30e2cd61826b@acm.org>
Message-ID: <2945fa16-3326-7ee8-bb0f-b953ac75b22b@broadcom.com>



On 12/1/2018 10:32 AM, Bart Van Assche wrote:
> On 12/1/18 9:11 AM, Hannes Reinecke wrote:
>>
>> Yes, I'm very much in favour of this, too.
>> We always have this IMO slightly weird notion of stopping the queue, 
>> set some error flags in the driver, then _restarting_ the queue, just 
>> so that the driver then sees the error flag and terminates the requests.
>> Which I always found quite counter-intuitive.
>> So having a common helper for terminating requests for queue errors 
>> would be very welcomed here.
>>
>> But when we have that we really should audit all drivers to ensure 
>> they do the right thin (tm).
>
> Would calling blk_abort_request() for all outstanding requests be 
> sufficient to avoid that the queue has to be stopped and restarted in 
> the nvme-fc driver?

what nvme-fc does is the same as what is done in all the other 
transports - for the same reasons.? If we're eliminating those 
synchronization reasons, and now that we've plugged the request_queue 
path into the transports to check state appropriately, I don' t think 
there are reasons to block the queue.? In some respects, it is nice to 
stop new io while the work to terminate everything else happens, but I 
don't know that it's required.? I would hope that the bounced work due 
to the controller state (returned BLK_STAT_RESOURCE) is actually pausing 
for a short while. I've seen some circumstances where it didn't and was 
infinitely polling. Which would be a change in behavior vs the queue stops.

-- james
