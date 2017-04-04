From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 4 Apr 2017 09:46:29 -0600
Subject: [RFC 6/8] nvmet: Be careful about using iomem accesses when
 dealing with p2pmem
In-Reply-To: <080b68b4-eba3-861c-4f29-5d829425b5e7@grimberg.me>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1490911959-5146-7-git-send-email-logang@deltatee.com>
 <080b68b4-eba3-861c-4f29-5d829425b5e7@grimberg.me>
Message-ID: <20170404154629.GA13552@obsidianresearch.com>

On Tue, Apr 04, 2017@01:59:26PM +0300, Sagi Grimberg wrote:
> Note that the nvme completion queues are still on the host memory, so
> this means we have lost the ordering between data and completions as
> they go to different pcie targets.

Hmm, in this simple up/down case with a switch, I think it might
actually be OK.

Transactions might not complete at the NVMe device before the CPU
processes the RDMA completion, however due to the PCI-E ordering rules
new TLPs directed to the NVMe will complete after the RMDA TLPs and
thus observe the new data. (eg order preserving)

It would be very hard to use P2P if fabric ordering is not preserved..

Jason
