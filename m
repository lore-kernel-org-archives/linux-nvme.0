Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3869606A31A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 06:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IAf2Jjza;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QUtQsmur
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Ezp3oDN7Y2VQe15nNyu9ImVDd8HQhLrjk3u3Vao5tLg=; b=IAf2Jjzal0xq4aLRZoUMSr4xtQ
	ehUDwQpuOqjdyl2zWcyPhH7srMhnIiHJIxpQeQ4ajcXMXiquH3W6o5fJbF2/AueidTmsGs567V+7G
	Z0mhUvAl28UExNa/3rvnmYA22nzkZsdTAHJHzs0eIna5rK21Zpmfw25rEN2VZ71ArfHuxK/nJUhnw
	DYHhO2WrB0ee762bK9aVLonuVrS0SG+0Yapk2ufzqJYllgoMHp8j5LFxW8IN4BXW1MxktT/zQzA+5
	nc0dj67EUxBclF2BG8VI/ErXDHXZtCxJ79NG8n5xjFuUwr88AQfP3XpVo9bf2fExYqtBElEKvnWWS
	PC8/T/RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLxZh-00000006R8B-44vf;
	Wed, 28 Oct 2026 06:55:53 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLxZg-00000006R7n-0xLw
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 06:55:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 00BF3410BF;
	Wed, 28 Oct 2026 06:55:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E661F01825;
	Wed, 28 Oct 2026 06:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793170550;
	bh=Ezp3oDN7Y2VQe15nNyu9ImVDd8HQhLrjk3u3Vao5tLg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QUtQsmurrqw3D8PrcoNHRifpcbCaWjEpq0GXc4l19HWuEBB9VO+/q7CTiXReXATUI
	 2ujtjhh+D+KcAp86HDL5R5++av9XExDXpqj1Gm+I2Sn6f04t+aqkhCEKTEhwQWc9ZD
	 09vj7flnjcS4R1CM5ZPgVr4Tyrka8V+6lavV9yA8yD1//jUc7yj1FbJ1eXt01T+NIm
	 EDt4dmffnx0mjZ//Og+vQcl2grc1RrtPyHnBxUI7hTtPdPlDrhQmVP0F7ph+3ffyoy
	 5Eg1OpqUEWDE82yRam3L4dz5990JiDx9BJtI6RUHcKU+EfFTm0SZjfRNdVWtkXd8Ee
	 VUvFaUyFOiAAg==
Message-ID: <sashiko-outbox-187571@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvmet: Check the admin queue before reading its TLS key
 in debugfs
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261028064417.548948-1-kanie@linux.alibaba.com>
References: <20261028064417.548948-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 06:55:50 +0000
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
- [High] nvmet: unsynchronized ctrl->sqs[0] access in nvmet_ctrl_tls_key_sh=
ow()
--

commit 3cf90339b7ea83703b0eb52aef8d8c4af5c44e19
Author: Guixin Liu <kanie@linux.alibaba.com>

nvmet: Check the admin queue before reading its TLS key in debugfs

This commit checks whether ctrl->sqs[0] is non-NULL in
nvmet_ctrl_tls_key_show() before querying the admin queue's TLS key ID for
debugfs output.

> diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
> index e85fe1d4c9f8d..a27a501fe61a4 100644
> --- a/drivers/nvme/target/debugfs.c
> +++ b/drivers/nvme/target/debugfs.c
> @@ -136,8 +136,10 @@ NVMET_DEBUGFS_ATTR(nvmet_ctrl_host_traddr);
>  static int nvmet_ctrl_tls_key_show(struct seq_file *m, void *p)
>  {
>  	struct nvmet_ctrl *ctrl =3D m->private;
> -	key_serial_t keyid =3D nvmet_queue_tls_keyid(ctrl->sqs[0]);
> +	key_serial_t keyid =3D 0;
> =20
> +	if (ctrl->sqs[0])
> +		keyid =3D nvmet_queue_tls_keyid(ctrl->sqs[0]);

[Severity: High]
Can this unlocked check and reload of ctrl->sqs[0] race with admin queue
teardown in nvmet_tcp_release_queue_work() and nvmet_sq_destroy(), or with
the error path in nvmet_install_queue()?

First, ctrl->sqs[0] is checked and then reloaded without READ_ONCE() or any
lock synchronizing against nvmet_sq_destroy() in drivers/nvme/target/core.c:

    if (sq->qid =3D=3D 0) {
        ctrl->reset_tbkas =3D true;
        sq->ctrl->sqs[sq->qid] =3D NULL;
        nvmet_ctrl_put(ctrl);
    }

If ctrl->sqs[0] is cleared to NULL between the if (ctrl->sqs[0]) check and
the argument evaluation for nvmet_queue_tls_keyid(ctrl->sqs[0]), NULL is
passed into nvmet_queue_tls_keyid() in drivers/nvme/target/nvmet.h:

    static inline key_serial_t nvmet_queue_tls_keyid(struct nvmet_sq *sq)
    {
        return sq->tls_key ? key_serial(sq->tls_key) : 0;
    }

which dereferences sq->tls_key on a NULL pointer.

Second, even when ctrl->sqs[0] is read as non-NULL, nothing pins the queue =
or
sq->tls_key while nvmet_ctrl_tls_key_show() runs. During queue teardown in
drivers/nvme/target/tcp.c, nvmet_tcp_release_queue_work() executes:

    nvmet_sq_put_tls_key(&queue->nvme_sq);
    nvmet_tcp_uninit_data_in_cmds(queue);
    nvmet_sq_destroy(&queue->nvme_sq);
    ...
    kfree(queue);

where nvmet_sq_put_tls_key() in drivers/nvme/target/nvmet.h drops the key
reference before ctrl->sqs[0] is cleared:

    static inline void nvmet_sq_put_tls_key(struct nvmet_sq *sq)
    {
        if (sq->tls_key) {
            key_put(sq->tls_key);
            sq->tls_key =3D NULL;
        }
    }

Because the controller debugfs directory stays alive until the final
ctrl->ref is dropped in nvmet_ctrl_free() -> nvmet_debugfs_ctrl_free(ctrl)
(for example, while queue->nvme_cq or I/O queues still hold controller
references), a concurrent reader of the tls_key debugfs file can dereference
sq->tls_key after key_put() or dereference sq after kfree(queue).

Could this be avoided by reading the key directly from ctrl->tls_key (or
caching the key serial on struct nvmet_ctrl), or by properly serializing
access to the queue and its key?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028064417.5489=
48-1-kanie@linux.alibaba.com?part=3D1

