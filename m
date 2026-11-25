Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F84606A31E
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 14:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UcWeAWhQ;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=asP8/PGJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=yPuYlPBJOpm73JY6+sDUlvAVcHSaw0CIAD9ZIBqsPTY=; b=UcWeAWhQRrPkVlQS6bH4AwMvSN
	9p5yU7b9GYOACrkBlfd73LKEV+nFBRejcQ6KO/Zhfi/nNs6pDw458xUsA9a1D1rrX17sDD/Cg/c88
	N6C8J4BLOxcuW7vYn+RwTXanu7d8rjyNbTGuPFId+1cyK/9f1oT+xRlfP9MWkoesfOJLqV6kNeKOG
	L4QstnvlqG/WaWwoelhu0QLe/Z5Vrd6yXxrAtKznTIRfuVNAEHgS8QAkCOxQ0NO3lb69J8fVgHiUI
	L8H3H88ymz8El0o8W7hJedPTcWKYyymw6FcwHrw9wS+wNUzQpuLSAc04YURfs5wL84d8KEIOnoHaF
	boVW+3jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWDwg-0000000A9j6-2qCy;
	Wed, 25 Nov 2026 14:26:02 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWDwe-0000000A9iZ-0bA2
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 14:26:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8959443803
	for <linux-nvme@lists.infradead.org>; Wed, 25 Nov 2026 14:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F391F000ED;
	Wed, 25 Nov 2026 14:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795616759;
	bh=yPuYlPBJOpm73JY6+sDUlvAVcHSaw0CIAD9ZIBqsPTY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=asP8/PGJUCdwlbo0B8KjQgftMbXkpLtm9UxnJCPsKScrwwQ98dg+X4aXLkSW9cD8h
	 f3ohVNR/Jp0w6gREaCFkA2L7wgxQQyPrtsdSyjAe5HVqT7YeUwB1VoY+Uvt2qTFrrN
	 7J0xwByDdZDYK4W7POqadK0MuJno+mBoWURBm/wpPttho2xEnpN1/n91/Y0Mew4fEO
	 dUQhf3SdYfK23+tr5ZIbtFypJlN3VNdUqsXOiIdLFTzkvh2IahAAadyIvGV4s1/rDI
	 IRR5QF4gFXDLV1UBtv9rSdX5aPuTkePPpPlAHia7JnotUGQhMC0YCyeW8Jhzsqu4tZ
	 vqW8DIYmu7XlA==
Message-ID: <sashiko-outbox-233553@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvme-rdma: use current network namespace
To: "Hannes Reinecke" <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261125141737.2383-1-hare@kernel.org>
References: <20261125141737.2383-1-hare@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 14:25:58 +0000
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
- [High] nvme-rdma: netns reference leak in nvme_rdma_free_ctrl()
--

commit ea2302951454868193e26cecb0bf291eea317e73
Author: Hannes Reinecke <hare@kernel.org>

nvme-rdma: use current network namespace

This commit records the caller's network namespace in struct nvme_rdma_ctrl
and passes it to inet_pton_with_scope() and rdma_create_id() instead of
init_net.

> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 32189fdfc0f51..76b4cba80b369 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c

[ ... ]

> @@ -2288,6 +2289,8 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(=
struct device *dev,
>  	if (!ctrl)
>  		return ERR_PTR(-ENOMEM);
>  	ctrl->ctrl.opts =3D opts;
> +	ctrl->net =3D get_net(current->nsproxy->net_ns);
> +
>  	/*
>  	 * Safe to init list while allocating ctrl object.
>  	 */

[ ... ]

> @@ -2354,6 +2357,7 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(=
struct device *dev,
>  out_kfree_queues:
>  	kfree(ctrl->queues);
>  out_free_ctrl:
> +	put_net(ctrl->net);
>  	kfree(ctrl);
>  	return ERR_PTR(ret);
>  }

[Severity: High]
Does this leak ctrl->net when a controller is freed after
nvme_rdma_alloc_ctrl() succeeds?  Once nvme_init_ctrl() succeeds,
controller teardown goes through nvme_put_ctrl() -> nvme_rdma_free_ctrl(),
which frees ctrl without calling put_net(ctrl->net), preventing the
network namespace from ever being destroyed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125141737.2383=
-1-hare@kernel.org?part=3D1

