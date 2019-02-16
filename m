From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 15 Feb 2019 18:54:35 -0700
Subject: [LSF/MM TOPIC] NVMe Performance: Userspace vs Kernel
In-Reply-To: <11A6C7D0-A26D-410F-8EE3-9AF524DF2050@nutanix.com>
References: <DAB8A2DA-37D3-4CBE-8AD7-356E3CE8B0D3@nutanix.com>
 <1550266894.31902.104.camel@acm.org>
 <11A6C7D0-A26D-410F-8EE3-9AF524DF2050@nutanix.com>
Message-ID: <5a370041-bd59-049f-3cb4-7635dedac8f8@kernel.dk>

(resending, as my phone email client turned this into html crap)

> Hi Bart,
>
> I configured 5.0-rc6 and had a look at the io_uring code. Finally worked out how to use FIO's t/io_uring to submit IO and poll completions without system calls. My _initial_ numbers still show SPDK being faster and more efficient.
>
> Searching the lists, I found a few mentions that Jens published a comparison stating otherwise, but I can't find it. Could you please give me some pointers?

I posted some numbers with v5:

https://lore.kernel.org/linux-block/20190116175003.17880-1-axboe at kernel.dk/

Sounds like you are using sqpoll, you probably don?t want to do that for
peak performance. And you probably want to experiment a bit to reach the
best performance, both in terms of setup/placement and kernel
configuration, runtime options (like iostats), etc.

-- 
Jens Axboe
