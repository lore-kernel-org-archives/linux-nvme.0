From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 22 Aug 2014 10:48:48 -0700
Subject: [PATCH] fs/block_dev.c: Use hd_part to find block inodes
In-Reply-To: <1408724896-3671-1-git-send-email-keith.busch@intel.com>
References: <1408724896-3671-1-git-send-email-keith.busch@intel.com>
Message-ID: <20140822174848.GA11819@infradead.org>

On Fri, Aug 22, 2014@10:28:16AM -0600, Keith Busch wrote:
> When using the GENHD_FL_EXT_DEVT disk flags, a newly added device may
> be assigned the same major/minor as one that was previously removed but
> opened, and the pesky userspace refuses to close it!

Which means life time rules for those dev_t allocations are broken.
Please fix it to not release the dev_t until the device isn't referenced
at all.
