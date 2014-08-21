From: keith.busch@intel.com (Keith Busch)
Date: Thu, 21 Aug 2014 08:19:52 -0600 (MDT)
Subject: [PATCH v12] NVMe: Convert to blk-mq
In-Reply-To: <53F5E0F1.20808@bjorling.me>
References: <1408126604-10611-1-git-send-email-m@bjorling.me>
 <1408126604-10611-2-git-send-email-m@bjorling.me>
 <alpine.LRH.2.03.1408181643280.4696@AMR> <53F5E0F1.20808@bjorling.me>
Message-ID: <alpine.LRH.2.03.1408210752180.4696@AMR>

On Thu, 21 Aug 2014, Matias Bj?rling wrote:
> On 08/19/2014 12:49 AM, Keith Busch wrote:
>> I see the driver's queue suspend logic is removed, but I didn't mean to
>> imply it was safe to do so without replacing it with something else. I
>> thought maybe we could use the blk_stop/start_queue() functions if I'm
>> correctly understanding what they're for.
>
> They're usually only used for the previous request model.
>
> Please correct me if I'm wrong. The flow of suspend is as following 
> (roughly):
>
> 1. Freeze user threads
> 2. Perform sys_sync
> 3. Freeze freezable kernel threads
> 4. Freeze devices
> 5. ...
>
> On nvme suspend, we process all outstanding request and cancels any 
> outstanding IOs, before going suspending.
>
> From what I found, is it still possible for IOs to be submitted and lost in 
> the process?

For suspend/resume, I think we're okay. There are three other ways the
drive can be reset where we'd want to quiesce IO:

  I/O timeout
  Controller Failure Status (CSTS.CFS) set
  User initiated reset via sysfs

>>   * After a reset, we are not guaranteed that we even have the same number
>>   of h/w queues. The driver frees ones beyond the device's capabilities,
>>   so blk-mq may have references to freed memory. The driver may also
>>   allocate more queues if it is capable, but blk-mq won't be able to take
>>   advantage of that.
>
> Ok. Out of curiosity, why can the number of exposed nvme queues change from 
> the hw perspective on suspend/resume?

The only time you might expect something like that is if a f/w upgrade
occured prior to the device reset and it supports different queues. The
number of queues supported could be more or less than previous. I wouldn't
normally expect different f/w to support different queue count, but it's
certainly allowed.

Otherwise the spec allows the controller to return errors even though
the queue count feature was succesful. This could be for a variety of
reasons from resource limits or other internal device errors.
