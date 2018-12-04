From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 3 Dec 2018 17:33:06 -0800
Subject: [PATCH 1/2] blk-mq: Export iterating all tagged requests
In-Reply-To: <9346f289-f265-e2ee-2d2c-c97973b45e23@suse.de>
References: <20181130202635.11145-1-keith.busch@intel.com>
 <823fc3bf-78a4-c8fb-c80c-e3944f320af0@kernel.dk>
 <20181201164804.GB19557@lst.de>
 <9346f289-f265-e2ee-2d2c-c97973b45e23@suse.de>
Message-ID: <8cd9a950-6605-6387-e4d4-4346a46da781@grimberg.me>


>>>> A driver may wish to iterate every tagged request, not just ones that
>>>> satisfy blk_mq_request_started(). The intended use is so a driver may
>>>> terminate entered requests on quiesced queues.
>>>
>>> How about we just move the started check into the handler passed in for
>>> those that care about it? Much saner to make the interface iterate
>>> everything, and leave whatever state check to the callback.
>>
>> So we used to do that, and I changed it back in May to test for
>> MQ_RQ_IN_FLIGHT, and then Ming changed it to check
>> blk_mq_request_started.? So this is clearly a minefield of sorts..
>>
>> Note that at least mtip32xx, nbd, skd and the various nvme transports
>> want to use the function to terminate all requests in the error
>> path, and it would be great to have one single understood, documented
>> and debugged helper for that in the core, so this is a vote for moving
>> more of the logic in your second helper into the core code.? skd
>> will need actually use ->complete to release resources for that, though
>> and mtip plays some odd abort bits.? If it weren't for the interesting
>> abort behavior in nvme-fc that means we could even unexport the
>> low-level interface.
>>
> Yes, I'm very much in favour of this, too.
> We always have this IMO slightly weird notion of stopping the queue, set 
> some error flags in the driver, then _restarting_ the queue, just so 
> that the driver then sees the error flag and terminates the requests.
> Which I always found quite counter-intuitive.

What about requests that come in after the iteration runs? how are those
terminated?
