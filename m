From: axboe@fb.com (Jens Axboe)
Date: Wed, 28 Jan 2015 09:13:13 -0700
Subject: [PATCH/RFC] NVMe: add support for doing offline/online of attached
 namespaces
In-Reply-To: <alpine.LNX.2.00.1501272044190.15481@localhost.lm.intel.com>
References: <20150123152430.GA6107@kernel.dk>
 <alpine.LNX.2.00.1501272044190.15481@localhost.lm.intel.com>
Message-ID: <54C90A99.4040903@fb.com>

On 01/27/2015 01:59 PM, Keith Busch wrote:
> On Fri, 23 Jan 2015, Jens Axboe wrote:
>> Add two new ioctls for the char control device:
>>
>> - NVME_IOCTL_OFFLINE_DISK will offline namespaces/disks and leave only
>>  the admin queue and char dev running.
>>
>> - NVME_IOCTL_ONLINE_DISK will do discovery and add namespaces and disks
>>  back into the system.
>>
>> The intended use case is for safely doing a format or firmware upgrade,
>> where device and hardware characteristics could change substantially
>> beyond just device size and block size.
>>
>> This is an RFC patch. The goal is as listed, being able to detach any
>> namespaces and bdevs from a device, so we just have the admin part left.
>> I'm open to alternative suggestions on how to handle this. Solutions
>> that include rmmod/modprobe if the driver wont work if you have more
>> than one NVMe device in a system.
>>
>> I've run this through various stress testing, and it seems to hold up
>> fine.
>
> Looks pretty good, I think we need something like this. We trust a user
> too much to not to do something bad when changing things like block sizes,
> so it'd be good to have a mechanisms to make this safer.
>
> Should these actions be IOCTLs? I think 'sysfs' might be easier to use,
> and easier for adding additional actions in the future.

Might not hurt to have both entry points for it. From a format (or
other) tool, the ioctl path would be more convenient as it could just do
it for you. I don't see the sysfs path being used much - I could be
wrong, of course. In any case, not a big deal to me and would not really
change the patch as both paths would hook in the same place.

> Could we try for something with more control? For example, I might change
> the block format on namespace 2, but namespace 1 is my root partition
> so I don't want to delete that disk.

That's not a bad idea... I'll update it to do that, or at least with the
option of doing that.

> I don't think you need to reference count the namespace open's. The
> controller reference is also taken, and the last namespace reference
> can't be released until the last controller reference is also released,
> so it seems redundant.

I'll re-run it, but I had issues with not referencing the ns opens
(which is why it exists in the patch). Could be a sign of something else
being wrong, of course. It's been a while since I last did the
exhaustive testing, so perhaps the recent hotplug changes helps it out.
>
> That's all I got right now. Thanks!


-- 
Jens Axboe
