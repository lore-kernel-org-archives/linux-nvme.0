From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 18 Jul 2017 01:10:58 +0300
Subject: [PATCH] nvme : add Scatter-Gather List (SGL) support in NVMe
 driver.
In-Reply-To: <MWHPR04MB10082C8A086CE3BCA6CBE53A86A00@MWHPR04MB1008.namprd04.prod.outlook.com>
References: <1499968479-5286-1-git-send-email-chaitanya.kulkarni@hgst.com>
 <1499968479-5286-2-git-send-email-chaitanya.kulkarni@hgst.com>
 <20170714210623.GB24365@localhost.localdomain>
 <20170715085008.GB25753@infradead.org>
 <04aaed5c-1a8a-f601-6c9c-88bf1cf66e8a@mellanox.com>
 <MWHPR04MB10082C8A086CE3BCA6CBE53A86A00@MWHPR04MB1008.namprd04.prod.outlook.com>
Message-ID: <7fe8b19a-3e9e-4053-96f9-9513151537f1@mellanox.com>

Hi Chaitanya,

On 7/17/2017 11:59 PM, Chaitanya Kulkarni wrote:
> Hi Max,
>
> Is this the correct patch you mentioned in earlier email :- https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Flinux-rdma%2Fmsg48612.html&data=02%7C01%7Cmaxg%40mellanox.com%7C40a4add8efd44d99194008d4cd56b5e8%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636359219705908501&sdata=%2B7W6wsCDUtkz2JlcKXphVZjQBsy9WnlwlRQvctkGqJI%3D&reserved=0 ?
>
> In case if not can you please send the core code patch?

Yes, this is the patch I'm talking about.
See Sagi's comment regarding the virt_boundary.
Would you like me to send you an updated version for the core with 
ctrl->virt_boundary instead of ctrl->sg_gaps_support ?

>
> I'll give it a try, so it will be easy if we decide to have it integrated with current SGL patch.
>
> -Regards,
> Chaitanya
>
>
> -----Original Message-----
> From: Max Gurtovoy [mailto:maxg at mellanox.com]
> Sent: Sunday, July 16, 2017 5:01 PM
> To: Christoph Hellwig <hch at infradead.org>; Keith Busch <keith.busch at intel.com>
> Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni at wdc.com>; linux-nvme at lists.infradead.org
> Subject: Re: [PATCH] nvme : add Scatter-Gather List (SGL) support in NVMe driver.
>
>
>
> On 7/15/2017 11:50 AM, Christoph Hellwig wrote:
>> On Fri, Jul 14, 2017@05:06:24PM -0400, Keith Busch wrote:
>>>> 2. Set up the IO size threshold to determine whether to use
>>>>     SGLs or PRPs for each IO. (set sgl_threshold to 4096 to
>>>>     use SGL only for IOs which are >= 4096 in the size).
>>>
>>> For this to really make a difference, you should clear
>>> blk_queue_virt_boundary for SGL capable devices.
>>
>> SGLs make sense for bigger I/O alone.  But not having to set the
>> blk_queue_virt_boundary would be another benefit, Although you'll
>> probably need a 64k page size system for that to matter in practice.
>>
>> I remember Max had a patch for fabrics to support the Mellanox
>> arbitrary SGL registrations, which should share some core code with
>> allowing that for PCIe with SGLs.
>>
>> Max, what happened to that?
>>
>
> Actually this series was reviwed but because of a bug that was repro with sg_gaps MR type we decided to put this on hold until we figure this out. I couldn't repro the SRP issue in my lab and only Laurence did it with his setup but we couldn't find the root cause yet. We are using this mr type in upstream iser and also in our SRP driver in MLNX_OFED without issues so we can think of re-submiting it.
> Regarding the core code, I guess I can send a patch for Chaitanya to embed in his patchset for the SGL support, agreed ?
>
