Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9567606A31C
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2026 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1X9Rg/mE;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lDn719lG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=YvT/MMxYWrdIylhdUN2GQRbcVI7kCYlhH+C3Z+QTodY=; b=1X9Rg/mE/EGFEmBJB157v/FXtX
	/h5DJQ6M0OAi+qHzMRcJQfCNkuvz0u/m+WeRsBLVqRAi8V7akGAYtGf2xDWFLsr/FnPOUPU8Pxhwv
	8gc+Rm3G80s+ySpPmMn4weHCvtk/NKQ1K3iWpzXqaRhlm7vDWt+c1c6C6vdCq+vZBj8hrUWpr+mvQ
	oxlTG5/tl+NiBLAuhQOeiOeg6hC146asO4yo4seNrWI1QR30wmOPN0BzC8K/iwWOraabaxuavoidZ
	NuJ7ca2XIZd15LCjZKfV/NVhiK8lwkw2Z9Mg8fbvze08GV6Vfa5cvtp1c506pBoWoCbOidbmPoHEo
	IanAfZSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ1og-0000000G7Pt-42vb;
	Sun, 08 Nov 2026 12:16:10 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ1of-0000000G7Pn-25Ht
	for linux-nvme@lists.infradead.org;
	Sun, 08 Nov 2026 12:16:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 975D7605FB;
	Sun,  8 Nov 2026 12:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE8C1F0089F;
	Sun,  8 Nov 2026 12:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794140168;
	bh=YvT/MMxYWrdIylhdUN2GQRbcVI7kCYlhH+C3Z+QTodY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=lDn719lGBHmuW1IQws7MdmxzfVLnlMasSEze3RpJyVuPN6skJ30TeXQ+jSNHGg9+7
	 jxa6ozqkwd5qv4U+qYievVjw0VQyA+gfPH13HbN2yCwusn5AEVVb6c7+8iIGGRuOj8
	 rrAe2bwMKuCKG7uS7NXVQq04x/vjRHCVlzdCUoXcP5n7Dd9qy50mXRwoszd87s6BIu
	 IWxte2xdWY9YOUZ9l+7TqO8hIdk+5BjKLgNkA9LP2IUmG5LcGUb4FqioqOZSrQNFhP
	 71TuC9KF/r+UkGEgD60M1Bq+uDHf38rkukY5AHnv5tmS15PkOjTW9EySImSmN61ICL
	 KSF4LcJCdoKng==
Message-ID: <sashiko-outbox-203706@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/2] RDMA/cma: Add rdma_reclassify_id_for_listen()
To: =?utf-8?b?U2hpbidpY2hpcm8gS2F3YXNha2k=?= <shinichiro.kawasaki@wdc.com>, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org
In-Reply-To: <20261108120154.148824-2-shinichiro.kawasaki@wdc.com>
References: <20261108120154.148824-1-shinichiro.kawasaki@wdc.com>
 <20261108120154.148824-2-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 12:16:07 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] RDMA/cma: missing handler_mutex lockdep reclassification in
  cma_listen_on_dev()
- [Low] RDMA/cma: missing kernel-doc for rdma_reclassify_id_for_listen()
  ordering rules
--

commit 1c34d3d5b4de4179de0a92ec2b97020a760e60b6
Author: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

RDMA/cma: Add rdma_reclassify_id_for_listen()

This commit adds rdma_reclassify_id_for_listen() to assign a separate lockd=
ep
class to the handler_mutex of listening rdma_cm_id instances.

Link: https://lore.kernel.org/linux-nvme/at36um4zrsfOr3kh@shinmob/

> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 337a49d1acf72..436e2467a36ff 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -1064,6 +1064,19 @@ __rdma_create_kernel_id(struct net *net, rdma_cm_e=
vent_handler event_handler,
>  }
>  EXPORT_SYMBOL(__rdma_create_kernel_id);
> =20
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +static struct lock_class_key cma_listen_handler_mutex_key;
> +void rdma_reclassify_id_for_listen(struct rdma_cm_id *id)
> +{
> +	struct rdma_id_private *id_priv;
> +
> +	id_priv =3D container_of(id, struct rdma_id_private, id);
> +	lockdep_set_class(&id_priv->handler_mutex,
> +			  &cma_listen_handler_mutex_key);
> +}
> +EXPORT_SYMBOL(rdma_reclassify_id_for_listen);
> +#endif

[Severity: Medium]
Does cma_listen_on_dev() also need to reclassify dev_id_priv->handler_mutex
for wildcard listeners?

When a caller binds a listening cm_id to a wildcard address (such as 0.0.0.0
or ::), rdma_listen() -> cma_listen_on_all() -> cma_listen_on_dev() allocat=
es
an internal per-device child listening ID (dev_id_priv) for each RDMA devic=
e:

drivers/infiniband/core/cma.c:cma_listen_on_dev() {
	...
	dev_id_priv =3D
		__rdma_create_id(net, cma_listen_handler, id_priv,
				 id_priv->id.ps, id_priv->id.qp_type, id_priv);
	...
}

Because dev_id_priv->handler_mutex keeps the default handler_mutex lockdep
class, destroying the wildcard listening cm_id under nvmet_config_sem still
triggers the same lockdep circular locking dependency warning when
rdma_destroy_id() -> _destroy_id() -> cma_cancel_operation() ->
cma_cancel_listens() -> _cma_cancel_listens() calls
rdma_destroy_id(&dev_id_priv->id).

> diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
> index d639ff889e649..59dda4b0173e7 100644
> --- a/include/rdma/rdma_cm.h
> +++ b/include/rdma/rdma_cm.h
> @@ -158,6 +158,12 @@ struct rdma_cm_id *rdma_create_user_id(rdma_cm_event=
_handler event_handler,
>  	__rdma_create_kernel_id(net, event_handler, context, ps, qp_type,      \
>  				KBUILD_MODNAME)
> =20
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +void rdma_reclassify_id_for_listen(struct rdma_cm_id *id);
> +#else
> +static inline void rdma_reclassify_id_for_listen(struct rdma_cm_id *id) =
{}
> +#endif

[Severity: Low]
Could rdma_reclassify_id_for_listen() have a kernel-doc comment like the
neighboring declarations in include/rdma/rdma_cm.h?  Since it calls
lockdep_set_class() on handler_mutex, documenting that it must be called on=
 a
newly created rdma_cm_id before rdma_bind_addr() or rdma_listen() can acqui=
re
handler_mutex would make the ordering requirement clear to callers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108120154.1488=
24-1-shinichiro.kawasaki@wdc.com?part=3D1

