From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 17 Jul 2017 20:59:09 +0000
Subject: [PATCH] nvme : add Scatter-Gather List (SGL) support in NVMe
 driver.
In-Reply-To: <04aaed5c-1a8a-f601-6c9c-88bf1cf66e8a@mellanox.com>
References: <1499968479-5286-1-git-send-email-chaitanya.kulkarni@hgst.com>
 <1499968479-5286-2-git-send-email-chaitanya.kulkarni@hgst.com>
 <20170714210623.GB24365@localhost.localdomain>
 <20170715085008.GB25753@infradead.org>
 <04aaed5c-1a8a-f601-6c9c-88bf1cf66e8a@mellanox.com>
Message-ID: <MWHPR04MB10082C8A086CE3BCA6CBE53A86A00@MWHPR04MB1008.namprd04.prod.outlook.com>

Hi Max,

Is this the correct patch you mentioned in earlier email :- https://www.spinics.net/lists/linux-rdma/msg48612.html ?

In case if not can you please send the core code patch? 

I'll give it a try, so it will be easy if we decide to have it integrated with current SGL patch.

-Regards,
Chaitanya


-----Original Message-----
From: Max Gurtovoy [mailto:maxg@mellanox.com] 
Sent: Sunday, July 16, 2017 5:01 PM
To: Christoph Hellwig <hch at infradead.org>; Keith Busch <keith.busch at intel.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni at wdc.com>; linux-nvme at lists.infradead.org
Subject: Re: [PATCH] nvme : add Scatter-Gather List (SGL) support in NVMe driver.



On 7/15/2017 11:50 AM, Christoph Hellwig wrote:
> On Fri, Jul 14, 2017@05:06:24PM -0400, Keith Busch wrote:
>>> 2. Set up the IO size threshold to determine whether to use
>>>     SGLs or PRPs for each IO. (set sgl_threshold to 4096 to
>>>     use SGL only for IOs which are >= 4096 in the size).
>>
>> For this to really make a difference, you should clear 
>> blk_queue_virt_boundary for SGL capable devices.
>
> SGLs make sense for bigger I/O alone.  But not having to set the 
> blk_queue_virt_boundary would be another benefit, Although you'll 
> probably need a 64k page size system for that to matter in practice.
>
> I remember Max had a patch for fabrics to support the Mellanox 
> arbitrary SGL registrations, which should share some core code with 
> allowing that for PCIe with SGLs.
>
> Max, what happened to that?
>

Actually this series was reviwed but because of a bug that was repro with sg_gaps MR type we decided to put this on hold until we figure this out. I couldn't repro the SRP issue in my lab and only Laurence did it with his setup but we couldn't find the root cause yet. We are using this mr type in upstream iser and also in our SRP driver in MLNX_OFED without issues so we can think of re-submiting it.
Regarding the core code, I guess I can send a patch for Chaitanya to embed in his patchset for the SGL support, agreed ?
