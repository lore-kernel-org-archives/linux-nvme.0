From: andrey.v.kuzmin@gmail.com (Andrey Kuzmin)
Date: Wed, 3 Dec 2014 22:26:38 +0300
Subject: Testing NVME Split BIO
In-Reply-To: <80B89753B40C5141A3E2D53FE7A2A8A9945EDA0E@NTXBOIMBX02.micron.com>
References: <BL2PR04MB1635C3D325742BB32A47B6D927B0@BL2PR04MB163.namprd04.prod.outlook.com>
 <80B89753B40C5141A3E2D53FE7A2A8A9945EDA0E@NTXBOIMBX02.micron.com>
Message-ID: <CANvN+en7gSosgC3o8VyB+ALyhUswfL15jZN=V+ynKvpmgEAaWA@mail.gmail.com>

Assuming an NVME device/namespace formatted with 4K block size, I'd
give a shot to allocating, say, 8K in user-space with memalign (so
that my virtual 8K occupy exactly 2 physical pages), and then issuing
a 4K write to the respective nvme block device using any offset into
the allocated memory you'd like, such as 2K suggested by Sam in that
other email.
Regards,
Andrey


On Wed, Dec 3, 2014 at 9:42 PM, Sam Bradshaw (sbradshaw)
<sbradshaw@micron.com> wrote:
>
>
>> -----Original Message-----
>> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On
>> Behalf Of Jeffrey Lien
>> Sent: Wednesday, December 03, 2014 10:19 AM
>> To: linux-nvme at lists.infradead.org
>> Subject: Testing NVME Split BIO
>>
>> We are trying to create a testcase to verify the nvme split bio
>> function.   Does anyone have any ideas or suggestions for a simple way
>> to force a split bio request?
>
> We built a device mapper shim layer that does this.  Using a 4k transfer, single bvec, the mapper would:
> 1) bio_alloc a bio with 2 bvecs
> 2) point the first bvec at the original bvec but truncate the size to 2k
> 3) alloc a 4k page, kmap it, memcpy the upper 2k from the original bvec page into a non-zero offset into the allocated page
> 4) point the second bvec in the allocated bio at the bvec with non-zero offset
> 5) hand it off to the driver
>
> Make sure your allocated bio callback does any cleanup then calls the original callback with a pointer to the original bio.
>
> A device mapper shim approach may not be the "easiest" but has other benefits for traffic shaping beyond this use case.
>
> -Sam
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
