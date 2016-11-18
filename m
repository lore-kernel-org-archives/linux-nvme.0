From: keith.busch@intel.com (Keith Busch)
Date: Fri, 18 Nov 2016 10:41:29 -0500
Subject: [PATCH v2 2/5] block: add support for REQ_OP_WRITE_ZEROES
In-Reply-To: <1479421031-6060-1-git-send-email-ckulkarnilinux@gmail.com>
References: <1479421031-6060-1-git-send-email-ckulkarnilinux@gmail.com>
Message-ID: <20161118154129.GE12377@localhost.localdomain>

On Thu, Nov 17, 2016@02:17:11PM -0800, Chaitanya Kulkarni wrote:
> From: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
> 
> This adds a new block layer operation to zero out a range of
> LBAs. This allows to implement zeroing for devices that don't use
> either discard with a predictable zero pattern or WRITE SAME of zeroes.
> The prominent example of that is NVMe with the Write Zeroes command,
> but in the future this should also help with improving the way
> zeroing discards work.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
> ---

I think we also to assign queue_limits for stacked devices in
blk_stack_limits. Otherwise, looks good.
