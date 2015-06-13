From: m@bjorling.me (Matias Bjorling)
Date: Sat, 13 Jun 2015 18:17:11 +0200
Subject: [PATCH v4 0/8] Support for Open-Channel SSDs
In-Reply-To: <20150611102935.GA4419@infradead.org>
References: <1433508870-28251-1-git-send-email-m@bjorling.me>
 <20150609074643.GA5707@infradead.org> <55787DDE.7020801@bjorling.me>
 <20150611102935.GA4419@infradead.org>
Message-ID: <557C5787.3000608@bjorling.me>

On 06/11/2015 12:29 PM, Christoph Hellwig wrote:
> On Wed, Jun 10, 2015@08:11:42PM +0200, Matias Bjorling wrote:
>> 1. A get/put flash block API, that user-space applications can use.
>> That will enable application-driven FTLs. E.g. RocksDB can be integrated
>> tightly with the SSD. Allowing data placement and garbage collection to
>> be strictly controlled. Data placement will reduce the need for
>> over-provisioning, as data that age at the same time are placed in the
>> same flash block, and garbage collection can be scheduled to not
>> interfere with user requests. Together, it will remove I/O outliers
>> significantly.
>>
>> 2. Large drive arrays with global FTL. The stacking block device model
>> enables this. It allows an FTL to span multiple devices, and thus
>> perform data placement and garbage collection over tens to hundred of
>> devices. That'll greatly improve wear-leveling, as there is a much
>> higher probability of a fully inactive block with more flash.
>> Additionally, as the parallelism grows within the storage array, we can
>> slice and dice the devices using the get/put flash block API and enable
>> applications to get predictable performance, while using large arrays
>> that have a single address space.
>>
>> If it too much for now to get upstream, I can live with (2) removed and
>> then I make the changes you proposed.
> 
> In this case your driver API really isn't the Linux block API
> anymore.  I think the right API is a simple asynchronous submit with
> callback into the driver, with the block device only provided by
> the lightnvm layer.

Agree. A group is working on a RocksDB prototype at the moment. When
that is done, such an interface would be polished and submitted for
review. The first patches here are to lay the groundwork for block I/O
FTLs and generic flash block interface.

> 
> Note that for NVMe it might still make sense to implement this using
> blk-mq and a struct request, but those should be internal similar to
> how NVMe implements admin commands.

How about handling I/O merges? In the case where a block API is exposed
with a global FTL, filesystems relies on I/O merges for improving
performance. If using internal commands, merging has to implemented in
the lightnvm stack itself, I rather want to use blk-mq and not duplicate
the effort. I've kept the stacking model, so that I/Os go through the
queue I/O path and then picked up in the device driver.
