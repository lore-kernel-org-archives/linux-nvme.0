Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64516606A31A
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hNNhtiRP;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y/xY1FGh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=qGdhYKZ1ojjIG4EwgBFW7rFIlEc+8YjWXLSDbmZdKuA=; b=hNNhtiRPOFqPgc2vWIXsmDrCgg
	po/zaasskcN+1f8fT0AAE5NbWaQCwMEj2jF76681ngV0Slldc/eLUbAexbW0MownFVeuGCPlKVree
	Q1y5oYU6XCnHEknXG7vMj9xhcayPINIISK5ciu7CI9Yc4nif2epjYMcqn8FyPE+5CzRj2jrsYpOum
	aU6QpDGRmGblbNJ/IyiwjOAaSo49DsGuHmUjhqLHcHiP4czl7jCGTZjE5DdsAP1qfUb82ZKmyDWEq
	8rjcJwyVcr77UlUj9h7AHynGt7O3mZxdn5xPpDNgA7TpTvLgt+0YY3XjfZqAbUX/3WIjq0lVIlC2z
	XchfXjCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLKEc-00000002Xta-0KnM;
	Mon, 26 Oct 2026 12:55:30 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLKEa-00000002XtS-2r3w
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 12:55:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A7099601FB;
	Mon, 26 Oct 2026 12:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406321F01825;
	Mon, 26 Oct 2026 12:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793019327;
	bh=qGdhYKZ1ojjIG4EwgBFW7rFIlEc+8YjWXLSDbmZdKuA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y/xY1FGh02dh4wgUn2QEoOhsxtmCMu+s4CQJ6IRMUmUVQvAroAlZWXFIhRbnm/hG3
	 Uay9PvzJsMAjsGmdpR1rtDfOQNYGWGkdte7R7li98tjay9Iy1PAWQVjO/oFUoUuX2m
	 EUIlGoEuzPgPtsp7OhEDRu/EipncA2pKagUyFIpRipU7/CdyrYq/+uJ8dG63L3/6kM
	 xtSEVJdfi4Lplf2+RJVAPCrEDBmOnHgFCeHW+QzPF0/1pDrduaTvzTlAddoWCWyXpy
	 sBN9tEnErrAM46pQo/w4jHc+DXUgJvbF+BGPG13ElwgfrdNisavyf5qNOmUiyuWp/K
	 miEFjs4mA5FQA==
Message-ID: <sashiko-outbox-185251@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] nvme: expose queue information via debugfs
To: "Nilay Shroff" <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261026123411.1988949-6-nilay@linux.ibm.com>
References: <20261026123411.1988949-4-nilay@linux.ibm.com>
 <20261026123411.1988949-6-nilay@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 12:55:26 +0000
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] nvme-tcp: race with queue teardown in nvme_tcp_print_io_queue_info=
()
- [Medium] nvme: debugfs: nvme_io_queue_info_start() skips queues on resume=
d reads
- [Low] nvme: debugfs: missing static qualifier on nvme_io_queue_info_seq_o=
ps
--

commit 0f7d7347ae3aacfc41bb3e9a63226f587e2b9ffd
Author: Nilay Shroff <nilay@linux.ibm.com>

nvme: expose queue information via debugfs

This commit adds an io_queue_info debugfs attribute to expose per-queue
information for NVMe controllers using seq_file iteration. For NVMe-TCP,
it outputs each I/O queue's bound CPU and TCP socket source and
destination address and port.

> diff --git a/drivers/nvme/host/debugfs.c b/drivers/nvme/host/debugfs.c
> index 798fec4730f0a..8ea0413f7b753 100644
> --- a/drivers/nvme/host/debugfs.c
> +++ b/drivers/nvme/host/debugfs.c
> @@ -25,6 +25,61 @@ struct nvme_debugfs_ctx {
>  	struct nvme_debugfs_attr *attr;
>  };
> =20
> +static void *nvme_io_queue_info_start(struct seq_file *m, loff_t *pos)
> +{
> +	struct nvme_debugfs_ctx *ctx =3D m->private;
> +	struct nvme_ns *ns =3D ctx->data;
> +	struct nvme_ctrl *ctrl =3D ns->ctrl;
> +
> +	/*
> +	 * IO queues starts at offset 1.
> +	 */
> +	return (++*pos < ctrl->queue_count) ? pos : NULL;
> +}

[Severity: Medium]
Will unconditionally pre-incrementing *pos in nvme_io_queue_info_start()
cause queues to be skipped when seq_read_iter() resumes reading on a
subsequent read() call or after a seq_file buffer overflow?

In fs/seq_file.c:seq_read_iter(), the Fill loop advances m->index via
m->op->next() before checking whether the user buffer is full or whether
m->op->show() overflowed the seq_file buffer:

	p =3D m->op->next(m, p, &m->index);
	...
	if (!p || IS_ERR(p))	// no next record for us
		break;
	if (m->count >=3D iov_iter_count(iter))
		break;
	err =3D m->op->show(m, p);
	if (err > 0) {		// ->show() says "skip it"
		m->count =3D offs;
	} else if (err || seq_has_overflowed(m)) {
		m->count =3D offs;
		break;
	}

When the loop stops because the seq_file buffer overflowed or the caller's
buffer was filled, m->index has already been incremented by
nvme_io_queue_info_next() to the next unshown queue ID. On the next read,
seq_read_iter() calls nvme_io_queue_info_start(m, &m->index), which
executes ++*pos a second time and skips that queue.

Should nvme_io_queue_info_start() only advance *pos when *pos is 0?

> +
> +static void *nvme_io_queue_info_next(struct seq_file *m, void *v, loff_t=
 *pos)
> +{
> +	struct nvme_debugfs_ctx *ctx =3D m->private;
> +	struct nvme_ns *ns =3D ctx->data;
> +	struct nvme_ctrl *ctrl =3D ns->ctrl;
> +
> +	return (++*pos < ctrl->queue_count) ? pos : NULL;
> +}
> +
> +static void nvme_io_queue_info_stop(struct seq_file *m, void *v)
> +{
> +	/* nothing to be done */
> +}
> +
> +static int nvme_io_queue_info_show(struct seq_file *m, void *v)
> +{
> +	struct nvme_debugfs_ctx *ctx =3D m->private;
> +	struct nvme_ns *ns =3D ctx->data;
> +	struct nvme_ctrl *ctrl =3D ns->ctrl;
> +
> +	if (ctrl->ops->print_io_queue_info)
> +		return ctrl->ops->print_io_queue_info(m, ctrl, *(loff_t *)v);
> +
> +	return 0;
> +}
> +
> +const struct seq_operations nvme_io_queue_info_seq_ops =3D {
> +	.start =3D nvme_io_queue_info_start,
> +	.next =3D nvme_io_queue_info_next,
> +	.stop =3D nvme_io_queue_info_stop,
> +	.show =3D nvme_io_queue_info_show
> +};

[Severity: Low]
Should nvme_io_queue_info_seq_ops be marked static since it is only used
within drivers/nvme/host/debugfs.c?

[ ... ]

> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 7190eb10c2481..a59169629d56b 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2691,6 +2691,59 @@ static void nvme_tcp_free_ctrl(struct nvme_ctrl *n=
ctrl)
>  	kfree(ctrl);
>  }
> =20
> +static int nvme_tcp_print_io_queue_info(struct seq_file *m,
> +		struct nvme_ctrl *ctrl, int qid)
> +{
> +	int cpu;
> +	struct sockaddr_storage src, dst;
> +	struct nvme_tcp_ctrl *tctrl =3D to_tcp_ctrl(ctrl);
> +	struct nvme_tcp_queue *queue =3D &tctrl->queues[qid];
> +	int ret =3D -EINVAL;
> +
> +	if (!qid || qid >=3D ctrl->queue_count)
> +		return -EINVAL;
> +
> +	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
> +		return 0;
> +
> +	mutex_lock(&queue->queue_lock);
> +	if (!queue->sock)
> +		goto unlock;
> +
> +	ret =3D kernel_getsockname(queue->sock, (struct sockaddr *)&src);
> +	if (ret <=3D 0)
> +		goto unlock;
> +
> +	ret =3D kernel_getpeername(queue->sock, (struct sockaddr *)&dst);
> +	if (ret <=3D 0)
> +		goto unlock;

[Severity: High]
Can nvme_tcp_print_io_queue_info() race with queue teardown during
controller reset or error recovery?

Holding a reference on struct nvme_ns keeps the namespace and controller
allocated, but does not prevent nvme_reset_ctrl_work() or
nvme_tcp_error_recovery_work() from running nvme_tcp_teardown_io_queues()
while io_queue_info is being read.

In nvme_tcp_stop_queue_nowait(), NVME_TCP_Q_LIVE is cleared under
queue->queue_lock while queue->sock remains non-NULL:

	mutex_lock(&queue->queue_lock);
	if (test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
		__nvme_tcp_stop_queue(queue);
	/* Stopping the queue will disable TLS */
	queue->tls_enabled =3D false;
	mutex_unlock(&queue->queue_lock);

Shortly after, nvme_tcp_free_io_queues() -> nvme_tcp_free_queue() runs
without holding queue->queue_lock, frees queue->sock before clearing the
pointer, and destroys queue->queue_lock:

	__fput_sync(queue->sock->file);
	queue->sock =3D NULL;
	memalloc_noio_restore(noio_flag);

	kfree(queue->pdu);
	mutex_destroy(&queue->send_mutex);
	mutex_destroy(&queue->queue_lock);
	mutex_destroy(&queue->pf_cache_lock);

If nvme_tcp_print_io_queue_info() checks test_bit(NVME_TCP_Q_LIVE,
&queue->flags) just before teardown, it can acquire queue->queue_lock
after nvme_tcp_stop_queue_nowait() unlocks it, see queue->sock !=3D NULL
because NVME_TCP_Q_LIVE is not re-checked under the lock, and dereference
queue->sock in kernel_getsockname() and kernel_getpeername() concurrently
with __fput_sync(queue->sock->file), or touch queue->queue_lock while
nvme_tcp_free_queue() destroys it (and reconnect re-initializes it in
nvme_tcp_alloc_queue()).

In addition, if !queue->sock is taken under queue->queue_lock (where ret
is still -EINVAL) or if kernel_getpeername() returns -ENOTCONN on a
shut-down socket, returning a negative error code from the seq_file show
callback aborts the entire seq_read_iter() read instead of skipping the
stopped queue.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026123411.1988=
949-4-nilay@linux.ibm.com?part=3D2

