From: muneendra.kumar@broadcom.com (Muneendra Kumar M)
Date: Wed, 18 Apr 2018 17:17:25 +0530
Subject: [PATCH 1/1] RDMA over Fibre Channel
In-Reply-To: <20180418102223.GA27364@infradead.org>
References: <20180418094240.26371-1-muneendra.kumar@broadcom.com>
 <20180418102223.GA27364@infradead.org>
Message-ID: <86f66430d0c577792b663226189d31a1@mail.gmail.com>

Hi Christoph,

The current implementation of RDMA over Fibre channel uses NVMe for the
below reasons:
1. Existing FC-NVMe HBA and FC network can be used without requiring any
changes.
2. NVMe namespace based discovery is used for RDMA node discovery.
3. FC-NVMe provides us a way to achieve Zero copy TX/RX for non-block
workloads.

Although we concur with the idea of RDMA directly over Fibre channel, the
actual implementation addressing the above reasons requires
standardization and coordination with FC HBA vendors and other SAN
ecosystem players. This effort is ongoing within our organization (Brocade
at Broadcom).   However, there is a business case for the current soft
RDMA implementation for FC, i.e. RDMA over FC-NVMe, as it provides
existing Fibre channel customers a way to utilize existing FC network to
transport RDMA workloads as well.  While doing this we are making sure
NVMe block traffic also can happen on the same FC network.

The below link  gives more technical details. We are glad to discuss any
further details on the same.

https://github.com/brocade/RDMAoverFC/blob/master/RDMA%20over%20FC.pdf

Regards,
Muneendra, Amit & Anand.


-----Original Message-----
From: Christoph Hellwig [mailto:hch@infradead.org]
Sent: Wednesday, April 18, 2018 3:52 PM
To: muneendra.kumar at broadcom.com
Cc: linux-rdma at vger.kernel.org; amit.tyagi at broadcom.com;
anand.sundaram at broadcom.com; linux-nvme at lists.infradead.org
Subject: Re: [PATCH 1/1] RDMA over Fibre Channel

On Wed, Apr 18, 2018 at 02:42:40AM -0700, muneendra.kumar at broadcom.com
wrote:
> Eventhough it is inspired from the Soft RoCE driver, the underlying
> transport layer is FC-NVMe (short for 'NVMe over fibre channel').
> The request, response and completion state machines in the driver have
> been heavily modified to adapt to the Exchange based Data transfer
> mechanism of Fibre channel.

That sounds like a bad joke.  Please stop abusing the NVMe code for this
otherwise reasonable idea.  You should be able to layer this over plain
FCP just fine.
