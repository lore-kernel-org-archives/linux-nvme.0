From: axboe@fb.com (Jens Axboe)
Date: Fri, 23 Jan 2015 10:24:45 -0700
Subject: [PATCH/RFC] NVMe: add support for doing offline/online of attached
 namespaces
In-Reply-To: <20150123171112.GA2650@infradead.org>
References: <20150123152430.GA6107@kernel.dk>
 <20150123171112.GA2650@infradead.org>
Message-ID: <54C283DD.8080809@fb.com>

On 01/23/2015 10:11 AM, Christoph Hellwig wrote:
> On Fri, Jan 23, 2015@08:24:30AM -0700, Jens Axboe wrote:
>> This is an RFC patch. The goal is as listed, being able to detach any
>> namespaces and bdevs from a device, so we just have the admin part left.
>> I'm open to alternative suggestions on how to handle this. Solutions
>> that include rmmod/modprobe if the driver wont work if you have more
>> than one NVMe device in a system.
>
> Aways use the scsi to nvme translation and run the thing through the
> SCSI layer where all these issues are already handled?  I'm only half
> joking, with features like multipathing and reservations coming up
> this actually does seem like the best long term direction once we've
> cut the remaining fat from the SCSI I/O path.

It'd be an interesting experiment in seeing how close scsi-mq is to raw 
performance, I'd be worried there's still quite a gap though. Maybe when 
we're further along it starts to become a more viable option, at least I 
would not rule it out.

At the same time, this is a feature we use/need now. So I don't think a 
potential switch in future direction should preclude that from being 
done now.

-- 
Jens Axboe
