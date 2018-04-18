From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 18 Apr 2018 06:18:31 -0700
Subject: [PATCH 1/1] RDMA over Fibre Channel
In-Reply-To: <86f66430d0c577792b663226189d31a1@mail.gmail.com>
References: <20180418094240.26371-1-muneendra.kumar@broadcom.com>
 <20180418102223.GA27364@infradead.org>
 <86f66430d0c577792b663226189d31a1@mail.gmail.com>
Message-ID: <20180418131831.GA23425@infradead.org>

On Wed, Apr 18, 2018@05:17:25PM +0530, Muneendra Kumar M wrote:
> Although we concur with the idea of RDMA directly over Fibre channel, the
> actual implementation addressing the above reasons requires
> standardization and coordination with FC HBA vendors and other SAN
> ecosystem players. This effort is ongoing within our organization (Brocade
> at Broadcom).   However, there is a business case for the current soft
> RDMA implementation for FC, i.e. RDMA over FC-NVMe, as it provides
> existing Fibre channel customers a way to utilize existing FC network to
> transport RDMA workloads as well.  While doing this we are making sure
> NVMe block traffic also can happen on the same FC network.

There might be a business case for you, but with my Linux NVMe
(co-)maintainer hat on I'll have to tell you that this abuse of the
Linux nvme code is a complete no-go.

And even if it wasn't we'd still require the protocol be ratified by the
NVMe technical working group first.
