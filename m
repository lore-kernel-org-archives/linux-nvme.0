From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 3 Nov 2017 10:29:54 -0600
Subject: [GIT PULL] nvme updates for Linux 4.15
In-Reply-To: <20171103121703.kupyb5rvuyvaevsr@infradead.org>
References: <20171103121703.kupyb5rvuyvaevsr@infradead.org>
Message-ID: <1b8f7a21-af73-d1d6-200e-a4f6b8fdd3a1@kernel.dk>

On 11/03/2017 06:17 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> below are the currently queue nvme updates for Linux 4.15.  There are
> a few more things that could make it for this merge window, but I'd
> like to get things into linux-next, especially for the unlikely case
> that Linus decided to cut -rc8.
> 
> Highlights:
>  - support for SGLs in the PCIe driver (Chaitanya Kulkarni)
>  - disable I/O schedulers for the admin queue (Israel Rukshin)
>  - various Fibre Channel fixes and enhancements (James Smart)
>  - various refactoring for better code sharing between transports
>    (Sagi Grimberg and me)
> 
> as well as lots of little bits from various contributors.

Pulled, thanks.

-- 
Jens Axboe
