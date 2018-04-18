From: anand.sundaram@broadcom.com (Anand Nataraja Sundaram)
Date: Wed, 18 Apr 2018 22:23:45 +0530
Subject: [PATCH 1/1] RDMA over Fibre Channel
In-Reply-To: <20180418131831.GA23425@infradead.org>
References: <20180418094240.26371-1-muneendra.kumar@broadcom.com>
 <20180418102223.GA27364@infradead.org>
 <86f66430d0c577792b663226189d31a1@mail.gmail.com>
 <20180418131831.GA23425@infradead.org>
Message-ID: <67be5e134d10be260f78589d488b1c40@mail.gmail.com>

Hi Christoph,

Just wanted to understand more on your concerns on the mods done to Linux
NVMe.

The whole work was to tunnel IB protocol over existing NVMe protocol.  To
do this we first made sure NVMe stack (host, target) is able to send block
traffic and non-block (object based ) traffic. To do this, no changes were
required in the NVMe protocol itself. Only the target stack needed some
modifications to vector
  (a) NVMe block traffic to backend NVMe Namespace block driver
  (b) non-block  IB protocol traffic to RFC transport layer

The NVMe changes are restricted to below:
drivers/nvme/target/fc.c                        |   94 +-
drivers/nvme/target/io-cmd.c                    |   44 +-
include/linux/nvme-fc-driver.h                  |    6 +

Of the above only the io-cmd.c  is generic target component. The rest are
contained under FC stack.

Finally I respect your decision.  The above intent is to demonstrate
existing NVMe protocol can support both block and non-block workloads. If
this requires working with NVMe core working group, kindly let us know how
to accomplish this.

Thanks,
-anand


-----Original Message-----
From: Christoph Hellwig [mailto:hch@infradead.org]
Sent: Wednesday, April 18, 2018 6:49 PM
To: Muneendra Kumar M <muneendra.kumar at broadcom.com>
Cc: Christoph Hellwig <hch at infradead.org>; linux-rdma at vger.kernel.org;
Amit Kumar Tyagi <amit.tyagi at broadcom.com>; Anand Nataraja Sundaram
<anand.sundaram at broadcom.com>; linux-nvme at lists.infradead.org
Subject: Re: [PATCH 1/1] RDMA over Fibre Channel

On Wed, Apr 18, 2018@05:17:25PM +0530, Muneendra Kumar M wrote:
> Although we concur with the idea of RDMA directly over Fibre channel,
> the actual implementation addressing the above reasons requires
> standardization and coordination with FC HBA vendors and other SAN
> ecosystem players. This effort is ongoing within our organization
(Brocade
> at Broadcom).   However, there is a business case for the current soft
> RDMA implementation for FC, i.e. RDMA over FC-NVMe, as it provides
> existing Fibre channel customers a way to utilize existing FC network
> to transport RDMA workloads as well.  While doing this we are making
> sure NVMe block traffic also can happen on the same FC network.

There might be a business case for you, but with my Linux NVMe
(co-)maintainer hat on I'll have to tell you that this abuse of the Linux
nvme code is a complete no-go.

And even if it wasn't we'd still require the protocol be ratified by the
NVMe technical working group first.
