Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FB9606A31E
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 11:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=p1jlv1/j;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J1OIFLo5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/SCOrQ6SV1doPNUQs3a3+BFW8vQQCi8I4fOfzweUP3M=; b=p1jlv1/jAMqWbLz9zKMcxQbwHl
	YuIqq1A6D2zCm9AJakhVffcpdz85rVC6JFwMBb99hK53TRJdhccMoiZ8tD2pxyv7K4Q6SIyf1SEJo
	8+DqZHa4lq8VW6yr+V82h5t98UQ3oZbmMnAtWNDZdWBbMvEg8y0ro2zzMZn067Gz+7nsruGvJ4WnJ
	0vr+2xCNLRFXM2sQZL/mjJr/JD3eFreRonUUtxY62R8xpDCRdM2HhIf+CBpdHlCaxQ0E2oHZrQIpp
	nbshzqNe3ZRaTUPDoQZ8s/h3EUwtFBmYgid7ZKm4zgxxkRwgH3nBS9eYwkfmpkt+S7OlQRqUMGCfH
	b2V7PyKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWY7a-0000000D5lq-0z3s;
	Thu, 26 Nov 2026 11:58:38 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWY7Z-0000000D5lU-0fhf
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 11:58:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 96E7A436E6
	for <linux-nvme@lists.infradead.org>; Thu, 26 Nov 2026 11:58:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AC11F000C4;
	Thu, 26 Nov 2026 11:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795694316;
	bh=/SCOrQ6SV1doPNUQs3a3+BFW8vQQCi8I4fOfzweUP3M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J1OIFLo5dR1Z90m2vGMAchGmF1+1V6CpMh3UOlOpDYs27RE6SxEGNUpUMpby+S2nS
	 OHtCAaWodaiuApHEUnbXMBpVjIGbgC17oPa3QmlD49AmfvK0+xc8Q7pNc9M/fHG5ux
	 33aflduwEHeBXLb8d5clflrJeO2mD1xaBBva8mQQoV9Ws44Tobb5PjMa1Fq+luYFrm
	 S/9Z2S+42CBhyKLDRIiYLmUxFmClbHoWVYyDCu4UcwUYj4cv/82qrDTjofwwMnkyGq
	 D1EBmuFjpw9VOOK1oaIzkNXcYWeBAMDXyHvQLopXnhgmEeEvVz9cKNSycRQPbGCtEF
	 cxJJYXP/iRr1g==
Message-ID: <sashiko-outbox-235454@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2] nvme-tcp: use correct network namespace to resolve
 addresses
To: "Hannes Reinecke" <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261126115121.6032-1-hare@kernel.org>
References: <20261126115121.6032-1-hare@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 11:58:36 +0000
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] nvme-tcp: missing Fixes trailer for nvme_tcp_alloc_ctrl() netns
  and RCU fixes
--

commit a9e44348b8fe94c523f1cf508bd4bb1ce6079725
Author: Hannes Reinecke <hare@kernel.org>

> nvme-tcp: use correct network namespace to resolve addresses
>
> Resolving network addresses should use the current network namespace;
> the passed-in addresses might not exist in the default network namespace.
> And while at use dev_get_by_name_rcu() with proper rcu locks to avoid
> a possible crash on network namespace changes.
>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>

[Severity: Low]
Resolving opts->traddr and opts->host_traddr against init_net dates back
to 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver"), and the
unlocked __dev_get_by_name() call was introduced in 8b43ced64d2b
("nvme-tcp: use __dev_get_by_name instead dev_get_by_name for
OPT_HOST_IFACE").  Should this include:

  Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
  Fixes: 8b43ced64d2b ("nvme-tcp: use __dev_get_by_name instead dev_get_by_=
name for OPT_HOST_IFACE")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126115121.6032=
-1-hare@kernel.org?part=3D1

