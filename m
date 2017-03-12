From: leon@kernel.org (Leon Romanovsky)
Date: Sun, 12 Mar 2017 21:29:55 +0200
Subject: [PATCH] IB/core: Protect against self-requeue of a cq work item
In-Reply-To: <1489003252-1893-1-git-send-email-sagi@grimberg.me>
References: <1489003252-1893-1-git-send-email-sagi@grimberg.me>
Message-ID: <20170312192955.GG2079@mtr-leonro.local>

On Wed, Mar 08, 2017@10:00:52PM +0200, Sagi Grimberg wrote:
> We need to make sure that the cq work item does not
> run when we are destroying the cq. Unlike flush_work,
> cancel_work_sync protects against self-requeue of the
> work item (which we can do in ib_cq_poll_work).
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---

Thanks,
Reviewed-by: Leon Romanovsky <leonro at mellanox.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170312/b1a2a558/attachment.sig>
