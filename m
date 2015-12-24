From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 24 Dec 2015 06:25:28 -0800
Subject: [PATCH RFC 3/4] nvme: Move IO termination code to the core
In-Reply-To: <1450956241-4626-4-git-send-email-sagig@mellanox.com>
References: <1450956241-4626-1-git-send-email-sagig@mellanox.com>
 <1450956241-4626-4-git-send-email-sagig@mellanox.com>
Message-ID: <20151224142528.GD2646@infradead.org>

> +void nvme_fail_admin_cmds(struct nvme_ctrl *ctrl,
> +		busy_tag_iter_fn *terminate_io, void *priv)
> +{
> +	blk_mq_tagset_busy_iter(ctrl->admin_tagset, terminate_io, priv);
> +}
> +EXPORT_SYMBOL_GPL(nvme_fail_admin_cmds);
> +
> +void nvme_fail_io_cmds(struct nvme_ctrl *ctrl,
> +		busy_tag_iter_fn *terminate_io, void *priv)
> +{
> +	blk_mq_tagset_busy_iter(ctrl->tagset, terminate_io, priv);
> +}
> +EXPORT_SYMBOL_GPL(nvme_fail_io_cmds);

But I see absolutely no point for these helpers.  These are trivial
one-liners that can stay in the transport drivers.  And with that we
also don't need the admin_tagset pointer in the generic controller
(at least yet..)
