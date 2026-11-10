Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE06606A330
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 08:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4vqJ4O4l;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O1/EnTip
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=skEVfqx7t7LQxOETtYiMuktJy9Ohr2UOEEN57phuOec=; b=4vqJ4O4lzwu4DShRnzgp2xerKP
	bMVmyXGrM5Vt2azM3mlQVs7tadZFaGKprE9mZW4YZ8MTFJFaAJ/FnYxPzMKIqxp1bywG/1pd+6RiJ
	wgbFZj2JPZ+Mcyx30bM2kv3dNEi44v07vgJ+EXRkzXgGC+OyRFqR+VhSa5il9fVj88c7KRlbNrtgy
	YL1NG50WgCgIdu3AB+PgPYdxJkJlZ1csvBmMDQqViO6UokRWndqXBCzoI7XsLduHPohH+eOTcg7Ca
	4xZRBku+NJgCkt5KrIR7J5jqAyBTZk/VGn+KltVULfdcU5AUK3IbtMvdhXna/X/GS7eL3MXdLLTTN
	2z8pWnaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQgr0-00000003362-0EMa;
	Tue, 10 Nov 2026 08:05:18 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQgqy-0000000335r-3vu0
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 08:05:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5061D40E14;
	Tue, 10 Nov 2026 08:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102021F0089F;
	Tue, 10 Nov 2026 08:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794297916;
	bh=skEVfqx7t7LQxOETtYiMuktJy9Ohr2UOEEN57phuOec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O1/EnTipsRyAHDtT4RbyHnVLCjFmYtlOV7gzQbIhlR5XrRqSUyLx97CVIXxUe8HEm
	 1hQwiW2gHUdye7ecxEUmKh3OWExI0lLnMLP0YzPZkd0wmgtKgGjmqt0lB6nHAvbWRW
	 HRUPKDsUkvZMduDdPJqQZEH6KSe8qOOmXUBHdyW2r2H9Q/8XAAqRITZRoAH2Mi4okH
	 gkV6dXysPghUvm/Bp6gg0dNSeFO58qSw0mwB2Rm8lluyVNPbEznWnMquXUQbQ94EQb
	 WZK0Ga2p/fabjYMC2d68KZiu1GXXI+mjtCVRri0oYiRX8JnmgYY8uNX4ZRoJ4DuPfR
	 Ce+YaOmAoyG+w==
Message-ID: <sashiko-outbox-206563@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvmet: synchronize DH-CHAP secret removal
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261110075733.2578-1-sreekuttan2156239@gmail.com>
References: <20261110075733.2578-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 08:05:14 +0000
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
- [Low] nvmet: missing Fixes trailer for nvmet_auth_set_key() secret
  clearing fix
--

commit e2778d1ca53fb43c219da377cd2d67684a67c943
Author: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

> nvmet: synchronize DH-CHAP secret removal
>
> The empty-secret path in nvmet_auth_set_key() modifies and frees
> host authentication secrets without holding nvmet_config_sem.
>
> nvmet_setup_auth() accesses these fields under the read lock,
> allowing concurrent secret removal to cause a use-after-free.
>
> Acquire nvmet_config_sem for writing while clearing the secrets
> to synchronize with authentication setup.
>
> Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

[Severity: Low]
Since this fixes the unlocked empty-secret path added to
nvmet_auth_set_key(), should this include:

  Fixes: bb2df18958b4 ("nvmet-auth: allow to clear DH-HMAC-CHAP keys")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110075733.2578=
-1-sreekuttan2156239@gmail.com?part=3D1

