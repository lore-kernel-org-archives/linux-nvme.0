From: freeman.zhang1992@gmail.com (Zhengyu Zhang)
Date: Thu, 16 Nov 2017 09:47:22 +0800
Subject: Is There Any Plan for Bit-Bucket SGL Implement?
In-Reply-To: <20171115155145.GA2989@localhost.localdomain>
References: <03d5178a-1edc-8a8b-f55b-9c96ee7d4101@gmail.com>
 <20171115155145.GA2989@localhost.localdomain>
Message-ID: <52c16cf5-c25a-319d-4843-3053bff6d72a@gmail.com>

Hi Keith!

Thank you very much for your reply.

On 11/15/17 11:51 PM, Keith Busch wrote:
>> - Is there any plan to implement (Bit-Bucket)SGL in linux kernel?
> 
> No plans to do this as far as I know. The read request the nvme driver
> receives has no way of conveying information for it to set up a bit-bucket
> descriptor. Even if it did, there doesn't appear to be any user for
> such a feature in Linux.
> 
>> - Is there any other way to make use of this feature?
> 
> Not in Linux.
> 
>> - Is this feature hardware-specific?
> 
> Yes, hardware advertises support for the feature in identify controller's
> SGLS field, bit 16.
> 

It's a pity to know this. The spec notes this feature certainly for a
reason but I just don't know their original motivation :(

Actually, I thought I could be the user of bit-bucket SGL when
developing my data processing application. Or at least, I can do some
tests to see whether this feature can improve performance since
bit-bucket SGL may reduce command number drastically when users perform
sequential read-skip interleave operations.

I plan to check some other drivers (e.g. SPDK) or maybe try to figure
out some patches myself (if my p3700 hardware supports it)...


Thanks!
Zhengyu
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0xFA035ADF.asc
Type: application/pgp-keys
Size: 3123 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20171116/d6539e38/attachment.bin>
