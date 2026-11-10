Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E13606A31C
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 23:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jwzWzkWa;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=StC6DEPL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Ubr2Kx0k+SUIadvG/kYW7BZwNJv1izUZsmpmtwRZAos=; b=jwzWzkWau1Z5PZQMfEXMAHwZdf
	A8cDDPTGAuxF/K/f1jOUyKioy2L0/8wzRvrra89zV0pOf1Lz/99gmot9066nQY1I1JJKapWusJkzD
	gHuiFUVvXexyIQYAIvDqb31gfKB+unhlkyS13xAWx17rtA081ff/NoxCRVaL3XADDii/IA/CKAOJc
	3YWZtuJHtOICDZZKmVGbbE2Ik3ya4NpmYYqfdXQn/KlyaoVjfpxs27PLHTDy6FQf4k/SNI9UsMHq9
	/1sGBlSIZuT8dBn8Cy7k9illvKhfBlZ8L4o+0UyQVeaPF/REnLFnUjNiOBN5IxEqJwzckZ2CK0Uwo
	sKwq4nBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQvGZ-00000005EvH-0iAE;
	Tue, 10 Nov 2026 23:28:39 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQvGX-00000005EvA-3U7e
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 23:28:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 010D445782;
	Tue, 10 Nov 2026 23:28:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75791F0093C;
	Tue, 10 Nov 2026 23:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794353316;
	bh=Ubr2Kx0k+SUIadvG/kYW7BZwNJv1izUZsmpmtwRZAos=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=StC6DEPLMh/xds8qaUnUinllaknEa/gYAAr9zBzAoMS+IvB8Ri0Kaf8zDlkPRPvxT
	 yLtGaIi02Kt2IqJxpkLckNb4GI7HTD/GmzjioBGgo5mwh6goZhdGfPsbNcojDYk9jg
	 aVg9qnTSfirb35EzWn6JXQ6kUXl1Y1BM6rTinc4cRRYVCPerKuDJ1r4+csJZzQIFFE
	 i/uqBH8pvUbOKp8YZZehRIe4m8l+iV+UyZZRlGB5Zw/2RZDkgbQVQAHUF2FFNS6mta
	 Sqywnvzyl5OQLJf2NHHBFAFTxfGhPnMBsG/e+mdMSrQGExK+Zd9y2z3nR5DqdzIOmA
	 0VwVa5mV+G1FA==
Message-ID: <sashiko-outbox-207909@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvme-pci: merge duplicate 1d97:2263 entries in
 nvme_id_table
To: "Platon Miller" <platon.ksenzenkokk@gmail.com>, linux-nvme@lists.infradead.org
In-Reply-To: <20261109202635.11310-1-platon.ksenzenkokk@gmail.com>
References: <20261109202635.11310-1-platon.ksenzenkokk@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 23:28:36 +0000
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
- [Low] nvme-pci: missing Fixes trailer for commit 200dccd07df2
--

commit af53f4b897c6ac918cbb3f87118e60968865a60f
Author: Platon Miller <platon.ksenzenkokk@gmail.com>

> nvme-pci: merge duplicate 1d97:2263 entries in nvme_id_table
>
> The nvme_id_table currently contains two separate entries for PCI ID
> 1d97:2263: one for SPCC with NVME_QUIRK_DISABLE_WRITE_ZEROES, and another
> later in the table for Lexar NM610 with NVME_QUIRK_BOGUS_NID.
>
> Because pci_match_device() returns on the first match, the Lexar NM610
> entry is unreachable, leaving those drives without NVME_QUIRK_BOGUS_NID.
>
> Merge the quirks for 1d97:2263 into a single entry with both
> NVME_QUIRK_DISABLE_WRITE_ZEROES and NVME_QUIRK_BOGUS_NID, and remove the
> redundant entry.
>
> Signed-off-by: Platon Miller <platon.ksenzenkokk@gmail.com>

[Severity: Low]
Since the second 1d97:2263 entry was unreachable from when it was added,
should the commit message include a Fixes tag?

  Fixes: 200dccd07df2 ("nvme-pci: add NVME_QUIRK_BOGUS_NID for Lexar NM610")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109202635.1131=
0-1-platon.ksenzenkokk@gmail.com?part=3D1

