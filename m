From: willy@linux.intel.com (Matthew Wilcox)
Date: Mon, 17 Aug 2015 16:12:37 -0400
Subject: [PATCH 1/2] nvme: remove spurious use of *_to_cpup helpers
In-Reply-To: <1439838580-29647-2-git-send-email-hch@lst.de>
References: <1439838580-29647-1-git-send-email-hch@lst.de>
 <1439838580-29647-2-git-send-email-hch@lst.de>
Message-ID: <20150817201237.GC9645@linux.intel.com>

On Mon, Aug 17, 2015@09:09:39PM +0200, Christoph Hellwig wrote:
> Switch to the normal endianess helpers that take an integer instead of
> the pointer to it.

Why?  Some CPUs have a 'load-reversed-endian' instruction, which can be
used in the _to_cpup() cases, but not in the _to_cpu() cases.

> -				cqe->command_id, le16_to_cpup(&cqe->sq_id));
> +				cqe->command_id, le16_to_cpu(cqe->sq_id));
