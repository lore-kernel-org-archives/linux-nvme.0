From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 19 Apr 2018 02:39:46 -0700
Subject: [PATCH 1/1] RDMA over Fibre Channel
In-Reply-To: <67be5e134d10be260f78589d488b1c40@mail.gmail.com>
References: <20180418094240.26371-1-muneendra.kumar@broadcom.com>
 <20180418102223.GA27364@infradead.org>
 <86f66430d0c577792b663226189d31a1@mail.gmail.com>
 <20180418131831.GA23425@infradead.org>
 <67be5e134d10be260f78589d488b1c40@mail.gmail.com>
Message-ID: <20180419093946.GA7181@infradead.org>

On Wed, Apr 18, 2018@10:23:45PM +0530, Anand Nataraja Sundaram wrote:
> Just wanted to understand more on your concerns on the mods done to Linux
> NVMe.
> 
> The whole work was to tunnel IB protocol over existing NVMe protocol.  To
> do this we first made sure NVMe stack (host, target) is able to send block
> traffic and non-block (object based ) traffic. To do this, no changes were
> required in the NVMe protocol itself. Only the target stack needed some
> modifications to vector
>   (a) NVMe block traffic to backend NVMe Namespace block driver
>   (b) non-block  IB protocol traffic to RFC transport layer
> 
> The NVMe changes are restricted to below:
> drivers/nvme/target/fc.c                        |   94 +-
> drivers/nvme/target/io-cmd.c                    |   44 +-
> include/linux/nvme-fc-driver.h                  |    6 +

You forgot the larger chunks of Linux NVMe code you copied while
stripping the copyrights and incorrectly relicensing it to a BSD-like
license.

The point is that IFF you really want to do RDMA over NVMe you need to
defined a new NVMe I/O command set for it and get it standardized.  If
that is done we could do a proper upper level protocol interface for it,
instead of just hacking it into the protocol and code through the
backdoor.  But as said before there is no upside of using NVMe, I can
see the interest in layering on top of FCP to reuse existing hardware
accelerations, similar to how NVMe layers on top of FCP for that reason,
but there isn't really any value in throwing in another NVMe layer.
