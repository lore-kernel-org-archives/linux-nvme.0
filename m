Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7951E606A31C
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2026 12:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qK9nfNzE;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVhyyxTF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=qJ557ubguD7akLNuo6proHNeTF7lGLlV1QWeKnfH/N4=; b=qK9nfNzEa9zAo8UpkPrdqG9mAK
	FHKNXKyKkwq+V2OMjlpk49CmZkOfNfKnMHs7kGS1U4T0fWe1BZwP5AijuA/5YEH6lsHdfEUiD9ENp
	dWNx3NWRCkYW6csJqYKXP738oc/Riv4WO0+fXYttUWpgNRmzAvnqlOHTZtwiwZvr/XWCYyP4pS8dK
	IugdfWRVtc+JNcPVcs9V53TYPBjrqSDmpVEHTNLVPcs/4fS64BaQGo+WMtgwrl9TBprolKIWU/+eh
	BDsvmHL8qQljhU90uBlzVaRjKkq8Az0ixxjUpbN573yFn0TYbiZgBT4knFPEA/Y7WtyeM14pHoe4f
	RO5BwFJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ1pB-0000000G7Tt-0mik;
	Sun, 08 Nov 2026 12:16:41 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ1p9-0000000G7Te-23w1
	for linux-nvme@lists.infradead.org;
	Sun, 08 Nov 2026 12:16:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4386040657;
	Sun,  8 Nov 2026 12:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8301F0089F;
	Sun,  8 Nov 2026 12:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794140199;
	bh=qJ557ubguD7akLNuo6proHNeTF7lGLlV1QWeKnfH/N4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=BVhyyxTFUDGukz05IZSEX+q+j2MtfBPlNfYPnIoscjbU6pQMIy5ZkhfsRv6cjPtvf
	 /kQUWVjW8/Y17+gHLrfMNrjw8LseLavouDEbOnKorzgbGKxjOwAu7RpLXPG2fWhpXl
	 TGmOoBzG/s4eCQ8TfOMyoHScDVLAOHBU6FTr6wIdCRjpwsFBBQwwVCVxOZnGZsG89G
	 M+AeTLj5OcUyWJbzPWHWfOJbOYFyot0qsoXlyF1EYj6wJ+4Kufoulot3J7dJqRaupo
	 JrO2jw0F06QrKKgjLi3LQrrpWMu+Q0tQdzfSt2W805JSzqcSeXGHytJMrPq5oDwonH
	 xfMYDTpKnxlWw==
Message-ID: <sashiko-outbox-203707@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 2/2] nvmet-rdma: use a separate lockdep class for
 the listening cm_id
To: =?utf-8?b?U2hpbidpY2hpcm8gS2F3YXNha2k=?= <shinichiro.kawasaki@wdc.com>, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org
In-Reply-To: <20261108120154.148824-3-shinichiro.kawasaki@wdc.com>
References: <20261108120154.148824-1-shinichiro.kawasaki@wdc.com>
 <20261108120154.148824-3-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 12:16:38 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] nvmet-rdma: wildcard listener child cm_ids keep default lockdep
  class
--

commit a129fce174ee6d77cacc5458875c55e53aa41b7e
Author: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

nvmet-rdma: use a separate lockdep class for the listening cm_id

This commit calls rdma_reclassify_id_for_listen() on the port's listening
cm_id in nvmet_rdma_enable_port() to give its handler_mutex a separate
lockdep class from connected queue cm_ids.

Link: https://lore.kernel.org/linux-nvme/at36um4zrsfOr3kh@shinmob/

> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index b9e39d1657d29..94f6d8edb517f 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -1914,6 +1914,8 @@ static int nvmet_rdma_enable_port(struct nvmet_rdma=
_port *port)
>  		return PTR_ERR(cm_id);
>  	}
> =20
> +	rdma_reclassify_id_for_listen(cm_id);
> +
>  	/*
>  	 * Allow both IPv4 and IPv6 sockets to bind a single port
>  	 * at the same time.

[Severity: Low]
Does this still leave the per-device child listening cm_ids in the default
handler_mutex lockdep class when port->addr is a wildcard address?

For a wildcard address, rdma_bind_addr() leaves id_priv->cma_dev NULL, so
rdma_listen() calls cma_listen_on_all() -> cma_listen_on_dev(), which
creates a per-device child dev_id_priv via __rdma_create_id() without
reclassifying its handler_mutex:

drivers/infiniband/core/cma.c:cma_listen_on_dev() {
	...
	dev_id_priv =3D
		__rdma_create_id(net, cma_listen_handler, id_priv,
				 id_priv->id.ps, id_priv->id.qp_type, id_priv);
	...
}

When nvmet_rdma_disable_port() later calls rdma_destroy_id(cm_id) under
nvmet_config_sem, _cma_cancel_listens() calls
rdma_destroy_id(&dev_id_priv->id) and takes dev_id_priv->handler_mutex,
triggering the same false-positive lockdep warning.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108120154.1488=
24-1-shinichiro.kawasaki@wdc.com?part=3D2

