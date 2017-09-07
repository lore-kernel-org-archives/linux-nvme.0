From: mb@lightnvm.io (=?UTF-8?Q?Matias_Bj=c3=b8rling?=)
Date: Thu, 7 Sep 2017 14:34:48 +0200
Subject: [PATCH] nvme: fix lightnvm check
In-Reply-To: <20170907122046.GA19161@lst.de>
References: <20170906094825.8845-1-hch@lst.de>
 <20170906150604.GD17331@localhost.localdomain>
 <20170907120128.GB18794@lst.de>
 <4735ef51-e4a8-d34a-d6e4-fa969a3c1b58@lightnvm.io>
 <20170907122046.GA19161@lst.de>
Message-ID: <841888da-a0c8-2e1e-cc55-71346ffce01f@lightnvm.io>

On 09/07/2017 02:20 PM, Christoph Hellwig wrote:
> On Thu, Sep 07, 2017@02:15:52PM +0200, Matias Bj?rling wrote:
>> I must have misunderstood when we discussed it. I understood it as to add
>> detection to the NVMe specification.
>>
>> Going with Class code might not be the right way due to them describing the
>> base protocol.
> 
> Well - existing NVMe (except Linux with lighnvm) simply expect a NVMe
> PCIe device to support the NVM I/O command set.  So if you have a drive
> that wants to speak a different one it needs to be bindable to a new
> driver and thus have a different PCIe class code.
> 
> But even with that in place we should also have the new command set
> in CAP - so that a common code base can work all these devices, and
> the command set can be used over fabrics as well for example.

Agree.

> 
>> bit. Another approach, as OCSSD has grown, might be to use the existing
>> command set, and teach the identify command about Zones/Chunks, where one
>> writes sequentially within.
> 
> Even then we need a way to identify such devices.  SCSI is a great
> example - if the device has zones that MUST be written sequentially
> it's a new ZBC device type.  If the device just wants zones to be
> written sequentially but can handle random writes with a performance
> penalty it's the good old SBC type with a few extensions.
> 

Agree, it would be a device type that requires the zones to be written 
sequentially.

I did a PoC a while back on exposing OCSSD as a ZBC device. Fairly 
straight-forward to do.

https://github.com/OpenChannelSSD/linux/commit/d1e0dbd88fab049631c868c6a6f6b6806ca752ec
