From: sbradshaw@micron.com (Sam Bradshaw (sbradshaw))
Date: Wed, 3 Dec 2014 20:02:06 +0000
Subject: Testing NVME Split BIO
In-Reply-To: <CANvN+en7gSosgC3o8VyB+ALyhUswfL15jZN=V+ynKvpmgEAaWA@mail.gmail.com>
References: <BL2PR04MB1635C3D325742BB32A47B6D927B0@BL2PR04MB163.namprd04.prod.outlook.com>
 <80B89753B40C5141A3E2D53FE7A2A8A9945EDA0E@NTXBOIMBX02.micron.com>
 <CANvN+en7gSosgC3o8VyB+ALyhUswfL15jZN=V+ynKvpmgEAaWA@mail.gmail.com>
Message-ID: <80B89753B40C5141A3E2D53FE7A2A8A9945EDCF9@NTXBOIMBX02.micron.com>



> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On
> Behalf Of Andrey Kuzmin
> Sent: Wednesday, December 03, 2014 11:27 AM
> To: Jeffrey Lien
> Cc: Sam Bradshaw (sbradshaw); linux-nvme at lists.infradead.org
> Subject: Re: Testing NVME Split BIO
> 
> Assuming an NVME device/namespace formatted with 4K block size, I'd
> give a shot to allocating, say, 8K in user-space with memalign (so that
> my virtual 8K occupy exactly 2 physical pages), and then issuing a 4K
> write to the respective nvme block device using any offset into the
> allocated memory you'd like, such as 2K suggested by Sam in that other
> email.
> Regards,
> Andrey

Using this approach, you'll still end up with a virtually contiguous block, which won't be split.
