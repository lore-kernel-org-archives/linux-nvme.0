From: keith.busch@intel.com (Keith Busch)
Date: Wed, 3 Dec 2014 20:56:42 +0000 (UTC)
Subject: Testing NVME Split BIO
In-Reply-To: <CANvN+en7gSosgC3o8VyB+ALyhUswfL15jZN=V+ynKvpmgEAaWA@mail.gmail.com>
References: <BL2PR04MB1635C3D325742BB32A47B6D927B0@BL2PR04MB163.namprd04.prod.outlook.com>
 <80B89753B40C5141A3E2D53FE7A2A8A9945EDA0E@NTXBOIMBX02.micron.com>
 <CANvN+en7gSosgC3o8VyB+ALyhUswfL15jZN=V+ynKvpmgEAaWA@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1412032044360.4225@localhost.lm.intel.com>

I don't think it's possible to synthesize split conditions from user
space if you're formatted 4k physical block size.

This will force splits for any <4k block format.
---
#define _GNU_SOURCE

#include <fcntl.h>
#include <string.h>
#include <stdio.h>

int main(int argc, char **argv)
{
 	struct iovec iov[2];
 	unsigned char *buffer;
 	int fd, err;

 	if (posix_memalign((void **)&buffer, 0x4000, 0x1000))
 		return 1;
 	if (argc < 2) {
 		fprintf(stderr, "usage: %s <device>\n", argv[0]);
 		return 1;
 	}

 	fd = open(argv[1], O_RDONLY | O_DIRECT);
 	if (fd <= 0) {
 		perror(argv[1]);
 		return 1;
 	}

 	memset(buffer, 0, 0x4000);

 	iov[0].iov_base = &buffer[0x800];
 	iov[1].iov_base = &buffer[0x2800];
 	iov[0].iov_len = 0x1000;
 	iov[1].iov_len = 0x1000;

 	err = readv(fd, iov, 2);
 	if (err)
 		perror("readv");
 	return err;
}
--

On Wed, 3 Dec 2014, Andrey Kuzmin wrote:
> Assuming an NVME device/namespace formatted with 4K block size, I'd
> give a shot to allocating, say, 8K in user-space with memalign (so
> that my virtual 8K occupy exactly 2 physical pages), and then issuing
> a 4K write to the respective nvme block device using any offset into
> the allocated memory you'd like, such as 2K suggested by Sam in that
> other email.
> Regards,
> Andrey
>
>
> On Wed, Dec 3, 2014 at 9:42 PM, Sam Bradshaw (sbradshaw)
> <sbradshaw@micron.com> wrote:
>>
>>
>>> -----Original Message-----
>>> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On
>>> Behalf Of Jeffrey Lien
>>> Sent: Wednesday, December 03, 2014 10:19 AM
>>> To: linux-nvme at lists.infradead.org
>>> Subject: Testing NVME Split BIO
>>>
>>> We are trying to create a testcase to verify the nvme split bio
>>> function.   Does anyone have any ideas or suggestions for a simple way
>>> to force a split bio request?
>>
>> We built a device mapper shim layer that does this.  Using a 4k transfer, single bvec, the mapper would:
>> 1) bio_alloc a bio with 2 bvecs
>> 2) point the first bvec at the original bvec but truncate the size to 2k
>> 3) alloc a 4k page, kmap it, memcpy the upper 2k from the original bvec page into a non-zero offset into the allocated page
>> 4) point the second bvec in the allocated bio at the bvec with non-zero offset
>> 5) hand it off to the driver
>>
>> Make sure your allocated bio callback does any cleanup then calls the original callback with a pointer to the original bio.
>>
>> A device mapper shim approach may not be the "easiest" but has other benefits for traffic shaping beyond this use case.
>>
>> -Sam
