From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 21 Apr 2017 03:39:20 -0700
Subject: [PATCH] multipath-tools: Add Huawei prioritizer for nvme
In-Reply-To: <1492770478-14848-1-git-send-email-zouming.zouming@huawei.com>
References: <1492770478-14848-1-git-send-email-zouming.zouming@huawei.com>
Message-ID: <20170421103920.GA14037@infradead.org>

On Fri, Apr 21, 2017@10:27:58AM +0000, Zou Ming wrote:
> Tool to make use of a NVMe-feature called HUAWEI Asymmetric Namespace Access.
> It determines the ANA state of a device and prints a priority value to stdout.

NAK.  Please work with the NVMe comittee to get your inputs into the
ANA technical proposal.  We will not support proprietary Multipating
for NVMe under Linux.
