From: mundu2510@gmail.com (mundu agarwal)
Date: Sun, 20 Jul 2014 19:45:04 +0530
Subject: [PATCH 1/1] NVMe I/O queue depth change to module parameter
In-Reply-To: <20140716132739.GH5855@linux.intel.com>
References: <1405445798-6440-1-git-send-email-mundu2510@gmail.com>
 <20140715182836.GF5855@linux.intel.com>
 <CACuVHZ=vSQ1341CUziDZJjv5DkGzw-9K7WOda59yfpT3WOzG2Q@mail.gmail.com>
 <20140716132739.GH5855@linux.intel.com>
Message-ID: <CACuVHZnzjuVmSZwVFHOoRbzfspuUfs-1cdNpNww60j4pcHnH_A@mail.gmail.com>

Thanks Willy, for detailed explanation.
 Since the HW/device/controller is under evaluation stage, device
parameters such as queue depth, best/worst timing for command
processing to be decide based on computing environment (slow computing
machines - Desktop/Laptop, Fast computing device - Server systems). To
manage the optimal configuration for queue depth, command timeout and
other parameters of the device is needed the frequent change. For ex.
slow performed or optimal environment these parameters (specifically
queue depth) may not need 1024 depth though device published more than
that as you explained in detail.

Regards,
Mundu

On Wed, Jul 16, 2014@6:57 PM, Matthew Wilcox <willy@linux.intel.com> wrote:
> On Wed, Jul 16, 2014@11:00:31AM +0530, mundu agarwal wrote:
>> Willy,
>>
>> In one of the server test environment, user unable to change I/O queue
>> depth more than 1024. Controller supports much higher number but still
>> limit to 1024.
>>  Is there any thought for keeping 1024 only ?
>
> That's the kind of comment you need to write in the changelog description.
>
> Now, the reason I limited a queue to 1024 entries was that this was
> sufficient to saturate a PCIe bus with typical flash latencies.
>
> If the PCIe bus is x8 gen3, we have 8GB/s of bandwidth available.
> Assuming that I/Os are on average 4k and it's a 50/50 read/write split,
> we need to service 4 million IOPS to saturate the bus (I haven't heard
> of anyone producing a 4 million IOPS device, but let's assume someone's
> trying to).
>
> Assuming the controller takes about 100us to service any individual
> request, servicing 4 million I/Os serially would take 400 seconds, so
> we need to have at least 400 I/Os with the device at all times in order
> to hit our goal of saturating the PCIe bus.
>
> So with 1024 I/Os on any given queue, we're a factor of 2.5 above that
> goal, *per queue*.  So increasing the maximum queue depth any further
> isn't going to help us achieve our goal of saturating the PCIe bus.
> Indeed, it's only going to upset some of the other timeouts; we've already
> had reports that I/Os will start to time out if you saturate all of the
> queues as the controllers can't complete the I/Os fast enough.
>
> So what's your motivation for needing a deeper queue?
