From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 9 Jun 2015 00:31:51 -0700
Subject: [PATCH v4 2/8] nvme: don't overwrite req->cmd_flags on sync cmd
In-Reply-To: <1433508870-28251-3-git-send-email-m@bjorling.me>
References: <1433508870-28251-1-git-send-email-m@bjorling.me>
 <1433508870-28251-3-git-send-email-m@bjorling.me>
Message-ID: <20150609073151.GA20450@infradead.org>

On Fri, Jun 05, 2015@02:54:24PM +0200, Matias Bj??rling wrote:
> In __nvme_submit_sync_cmd, the request direction is overwritten when
> the REQ_FAILFAST_DRIVER flag is set.

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>

This is a fix for a last minute regression and needs to got into the
drivers/for-4.2 tree ASAP.
