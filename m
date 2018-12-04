From: james.smart@broadcom.com (James Smart)
Date: Tue, 4 Dec 2018 11:13:49 -0800
Subject: [PATCH 1/2] blk-mq: Export iterating all tagged requests
In-Reply-To: <19b3821e-02fa-bd09-1b90-0dd8904e8a57@grimberg.me>
References: <20181130202635.11145-1-keith.busch@intel.com>
 <823fc3bf-78a4-c8fb-c80c-e3944f320af0@kernel.dk>
 <20181201164804.GB19557@lst.de>
 <9346f289-f265-e2ee-2d2c-c97973b45e23@suse.de>
 <8cd9a950-6605-6387-e4d4-4346a46da781@grimberg.me>
 <20181204154559.GJ14775@localhost.localdomain>
 <5af6dfb3-c471-1377-2d1d-b2a4b15eef43@broadcom.com>
 <19b3821e-02fa-bd09-1b90-0dd8904e8a57@grimberg.me>
Message-ID: <2ba6570b-1684-6082-7b70-f51a4136b38a@broadcom.com>



On 12/4/2018 9:23 AM, Sagi Grimberg wrote:
>
>>>>> Yes, I'm very much in favour of this, too.
>>>>> We always have this IMO slightly weird notion of stopping the 
>>>>> queue, set
>>>>> some error flags in the driver, then _restarting_ the queue, just so
>>>>> that the driver then sees the error flag and terminates the requests.
>>>>> Which I always found quite counter-intuitive.
>>>> What about requests that come in after the iteration runs? how are 
>>>> those
>>>> terminated?
>>> If we've reached a dead state, I think you'd want to start a queue 
>>> freeze
>>> before running the terminating iterator.
>>
>> For the requests that come in after the iterator, the 
>> nvmf_check_ready() routine, which validates controller state, will 
>> catch and bounce them.
>
> The point of this patch was to omit the check in queue_rq like Keith
> did in patch #2.

well - I'm not sure that's possible. The fabrics will have different 
time constraints vs pci.

-- james
