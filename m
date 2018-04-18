From: hch@lst.de (Christoph Hellwig)
Date: Wed, 18 Apr 2018 12:19:13 +0200
Subject: [PATCH] nvme: fix the suspicious RCU usage warning in
 nvme_mpath_clear_current_path
In-Reply-To: <1524036767-3701-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1524036767-3701-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <20180418101913.GB15833@lst.de>

On Wed, Apr 18, 2018@03:32:47PM +0800, Jianchao Wang wrote:
> With lockdep enabled, when trigger nvme_remove, suspicious RCU
> usage warning will be printed out.
> Fix it with adding srcu_read_lock/unlock in it.

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
