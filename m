From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 30 Mar 2017 01:11:07 -0700
Subject: [PATCH] nvme: make nvme error status codes converted to errno
 detailed
In-Reply-To: <1490782103-14668-1-git-send-email-guanjunxiong@huawei.com>
References: <1490782103-14668-1-git-send-email-guanjunxiong@huawei.com>
Message-ID: <20170330081107.GA2991@infradead.org>

On Wed, Mar 29, 2017@06:08:23PM +0800, Guan Junxiong wrote:
> From: Junxiong Guan <guanjunxiong at huawei.com>
> 
> For more detailed information about nvme error status when ending
> blk_mq request,some of nvme error status codes can be categorized into
> different errnos explicitly. For example, NVME_SC_ACCESS_DENIED and
> NVME_SC_CONNECT_CTRL_BUSY can be converted to EACCESS and EBUSY repec-
> tively.This patch makes conversion from those nvme error status to errno
> detailed.

NAK.  Most of these codes arw not defined for the block layer and don't
make any sense.  Also I have a major rework in this area pending that
would conflict with this patch.
