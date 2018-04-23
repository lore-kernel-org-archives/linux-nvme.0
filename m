From: anand.sundaram@broadcom.com (Anand Nataraja Sundaram)
Date: Mon, 23 Apr 2018 17:18:26 +0530
Subject: [PATCH 1/1] RDMA over Fibre Channel
In-Reply-To: <20180419093946.GA7181@infradead.org>
References: <20180418094240.26371-1-muneendra.kumar@broadcom.com>
 <20180418102223.GA27364@infradead.org>
 <86f66430d0c577792b663226189d31a1@mail.gmail.com>
 <20180418131831.GA23425@infradead.org>
 <67be5e134d10be260f78589d488b1c40@mail.gmail.com>
 <20180419093946.GA7181@infradead.org>
Message-ID: <133d4386e01fa081506409a8f2a523e3@mail.gmail.com>

Agreed some of the host nvme code was wrongly duplicated under BSD-like
license in
drivers/infiniband/sw/rfc/rfc_tb.c              |  795 +++++++++++++

Bottom line: We need both NVMe host and NVMe target stack changes to
tunnel RDMA over FC-NVMe.

This exercise just proved that RDMA can be tunneled over FC-NVMe. I agree
we need some standardization to transport RDMA workload over FC networks.

The clear advantage of doing RDMA over NVMe is that we could do end to end
zero-copy between RDMA applications. Doing RDMA over SCSI-FCP incurs a
one-copy penalty between RDMA applications.
However doing RDMA over FC directly (as a new FC-4 Upper Level Protocol
type) is also a possibility. Here FC-VI could also be considered. All this
required using new HBAs.

As a FC-SAN Community, we will work out which is the best route for RDMA
over FC standardization.

Thanks for your feedback,
-anand




-----Original Message-----
From: Christoph Hellwig [mailto:hch@infradead.org]
Sent: Thursday, April 19, 2018 3:10 PM
To: Anand Nataraja Sundaram <anand.sundaram at broadcom.com>
Cc: Christoph Hellwig <hch at infradead.org>; Muneendra Kumar M
<muneendra.kumar at broadcom.com>; linux-rdma at vger.kernel.org; Amit Kumar
Tyagi <amit.tyagi at broadcom.com>; linux-nvme at lists.infradead.org
Subject: Re: [PATCH 1/1] RDMA over Fibre Channel

On Wed, Apr 18, 2018@10:23:45PM +0530, Anand Nataraja Sundaram wrote:
> Just wanted to understand more on your concerns on the mods done to
> Linux NVMe.
>
> The whole work was to tunnel IB protocol over existing NVMe protocol.
> To do this we first made sure NVMe stack (host, target) is able to
> send block traffic and non-block (object based ) traffic. To do this,
> no changes were required in the NVMe protocol itself. Only the target
> stack needed some modifications to vector
>   (a) NVMe block traffic to backend NVMe Namespace block driver
>   (b) non-block  IB protocol traffic to RFC transport layer
>
> The NVMe changes are restricted to below:
> drivers/nvme/target/fc.c                        |   94 +-
> drivers/nvme/target/io-cmd.c                    |   44 +-
> include/linux/nvme-fc-driver.h                  |    6 +

You forgot the larger chunks of Linux NVMe code you copied while stripping
the copyrights and incorrectly relicensing it to a BSD-like license.

The point is that IFF you really want to do RDMA over NVMe you need to
defined a new NVMe I/O command set for it and get it standardized.  If
that is done we could do a proper upper level protocol interface for it,
instead of just hacking it into the protocol and code through the
backdoor.  But as said before there is no upside of using NVMe, I can see
the interest in layering on top of FCP to reuse existing hardware
accelerations, similar to how NVMe layers on top of FCP for that reason,
but there isn't really any value in throwing in another NVMe layer.
