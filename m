Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65393606A31A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 03:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zAquv1Hb;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KPXZNBBf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gr8UwMwNA4tO2C8qgIMJNc3FcocVo0aMxb8k8JdnGmM=; b=zAquv1HbrQnXfXTQa4i3z5Oto9
	HfugRZTw5MkBa7mINPhCRHqO72xhHUbzmac9AmOdQdxPuT6NO0CGdpE8dbgf9yeNCE2SBIX4Mn7FS
	y4QfxBGXveCQKrEu79YIWOvHNGSRvT/4ZIU4lNsd2u4vwR8bjInRPMPGk9TM++NDF2wcPAn7v0R5F
	o8gWPmi4uklJrSIT1D07LtTNOE3sWtBWIaoY2+p1g01ujnRIuT9ES/Yl7ahMQ5xWOOk+NqvFy8Ctk
	tfU807n92eJR58wg+lDtQg2acuUf7r7OSmM432HRH1RpxOf3YSA9LFQRyYnuv00E7Y7S/soEZ9Y6P
	RMXrHXZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMHA5-00000008GoN-1qCR;
	Thu, 29 Oct 2026 03:50:45 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMHA3-00000008GoA-33vb
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 03:50:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 99CE5600DA;
	Thu, 29 Oct 2026 03:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F901F01828;
	Thu, 29 Oct 2026 03:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793245842;
	bh=gr8UwMwNA4tO2C8qgIMJNc3FcocVo0aMxb8k8JdnGmM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KPXZNBBf64Bx/l3h2XaGwqRzpj0O/ggtU1x4ltuRDLtYjsY/DT/lqj1HQj+5SkuZ4
	 DltCQzkrGNSmGCPZOmrBRZ1wZNaRC6iJ6qEUj31xc5YwnpCn4hBd+FQ3pvEzWHxBRo
	 99tCSTOn4Uu0T7jdRF68vQxctclpmx7odZ/Tdo9xBLg2r293x2/zxuoSRF17FVtaTP
	 5P2fW+0u3ibwy+VbMUsDq0dsJlOEkGQjG2PGZLCfq2xg5ynlfjI3k+JXdvKDKnGT2K
	 M2DHd8JveKuVA+qw6f5xw4XQ8cLZFW+LS1kp/EkSUcSzAPYl2NQRU+n4opMJOhFqVR
	 anZ2oyZ1+rxEA==
Message-ID: <sashiko-outbox-188683@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] nvmet: Handle a NULL admin queue in
 nvmet_queue_tls_keyid()
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261029034306.3626274-1-kanie@linux.alibaba.com>
References: <20261029034306.3626274-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 03:50:41 +0000
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] nvmet: UAF race in nvmet_queue_tls_keyid() during admin queue tear=
down
--

commit 7f7e86c9399b0b51dffaf7a9659e2eee6e379123
Author: Guixin Liu <kanie@linux.alibaba.com>

nvmet: Handle a NULL admin queue in nvmet_queue_tls_keyid()

This commit adds a NULL pointer check for sq in nvmet_queue_tls_keyid() to
avoid dereferencing a NULL admin queue when the tls_key debugfs entry is re=
ad
before the admin queue is created or after it is destroyed.

> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 9cec19e6f4857..8bfc953b69f24 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -959,6 +959,8 @@ static inline void nvmet_req_bio_put(struct nvmet_req=
 *req, struct bio *bio)
>  #ifdef CONFIG_NVME_TARGET_TCP_TLS
>  static inline key_serial_t nvmet_queue_tls_keyid(struct nvmet_sq *sq)
>  {
> +	if (!sq)
> +		return 0;
>  	return sq->tls_key ? key_serial(sq->tls_key) : 0;
>  }

[Severity: High]
Does checking for a NULL sq here actually prevent a use-after-free when
nvmet_ctrl_tls_key_show() races with admin queue teardown?

In drivers/nvme/target/debugfs.c, nvmet_ctrl_tls_key_show() reads
ctrl->sqs[0] without holding any lock or reference pinning the queue or its
key:

static int nvmet_ctrl_tls_key_show(struct seq_file *m, void *p)
{
	struct nvmet_ctrl *ctrl =3D m->private;
	key_serial_t keyid =3D nvmet_queue_tls_keyid(ctrl->sqs[0]);

	seq_printf(m, "%08x\n", keyid);
	return 0;
}

Concurrently, during admin queue teardown in drivers/nvme/target/tcp.c,
nvmet_tcp_release_queue_work() releases the TLS key, destroys the sq, and
frees the queue:

	nvmet_sq_put_tls_key(&queue->nvme_sq);
	nvmet_tcp_uninit_data_in_cmds(queue);
	nvmet_sq_destroy(&queue->nvme_sq);
	nvmet_cq_put(&queue->nvme_cq);
	...
	kfree(queue);

where nvmet_sq_put_tls_key() drops the key reference before clearing
sq->tls_key:

static inline void nvmet_sq_put_tls_key(struct nvmet_sq *sq)
{
	if (sq->tls_key) {
		key_put(sq->tls_key);
		sq->tls_key =3D NULL;
	}
}

and nvmet_sq_destroy() in drivers/nvme/target/core.c only clears
sq->ctrl->sqs[sq->qid] afterwards:

	if (ctrl) {
		ctrl->reset_tbkas =3D true;
		sq->ctrl->sqs[sq->qid] =3D NULL;
		nvmet_ctrl_put(ctrl);
		sq->ctrl =3D NULL; /* allows reusing the queue later */
	}

Can this still lead to two use-after-free races when reading the tls_key
debugfs entry while the controller stays alive via other references on
ctrl->ref (such as I/O queues or the keep-alive timer)?

1. nvmet_sq_put_tls_key() runs before nvmet_sq_destroy() clears
   ctrl->sqs[0], and calls key_put(sq->tls_key) before setting
   sq->tls_key =3D NULL. If nvmet_ctrl_tls_key_show() runs concurrently,
   sq is still non-NULL, so can nvmet_queue_tls_keyid() dereference
   sq->tls_key in key_serial(sq->tls_key) while or after key_put() frees
   the struct key?

2. If nvmet_ctrl_tls_key_show() loads a non-NULL sq =3D ctrl->sqs[0] just
   before nvmet_sq_destroy() sets sq->ctrl->sqs[0] =3D NULL and
   nvmet_tcp_release_queue_work() calls kfree(queue), the !sq check in
   nvmet_queue_tls_keyid() will still see the non-NULL pointer and
   dereference sq->tls_key on the freed queue.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029034306.3626=
274-1-kanie@linux.alibaba.com?part=3D1

