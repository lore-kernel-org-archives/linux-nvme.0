Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F1C606A321
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 20:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gq5BoiS8;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HEONdQKF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RF2wRavp3sgDNccLPxwwHRzWza/X7uzJbYrpa8vlv3M=; b=gq5BoiS8PX/spFt/eafdrcCZob
	obyqAIQ7iafSYhoLjMGfY1crOjlvYvyFNJrGJcHJ1eKQGBAnPmDbIdu3cmG+ewS4ZOlWGtU0C+9H1
	Ky/3mwvPk+45yOvxV381DBeo3q15gB5vHRPbfVDS619xM7ZCawqMtq27hwhDJTR/RNFPefciCD3kE
	5GE+q3/ksAyVEAOjPu9FclHZpdSVdqhM8p0XZVC+IHYbwG8tUkRBTCg+Ko7oX616FMP7B30cpMGVa
	K7rWEDiJmkIXPr2DKebnNCMpIpGjQ8oUUwpqtXrR50Yw2Eh1XYaMr7mEe7saIxgwS3a5+gvJcesiv
	O8jwJKkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQVpk-00000001dLC-3VWF;
	Mon, 09 Nov 2026 20:19:16 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQVpi-00000001dL4-3cXD
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 20:19:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EC7BA60D83;
	Mon,  9 Nov 2026 20:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C271F0089F;
	Mon,  9 Nov 2026 20:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794255553;
	bh=RF2wRavp3sgDNccLPxwwHRzWza/X7uzJbYrpa8vlv3M=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=HEONdQKFYqL5JB46sJVkMDP5UYqmNenJTWylFjA0YhhL1S7k/8/NkXGLwnXZgHgS5
	 kjkibNl74hiG/Nh+ojCTW1SEIs+9KY9kmUz4zjFXCjcGklDKEd2a035Qi+3lzF6vL0
	 nkKz51qls+xBi1iBxz8EsTjiUNq7JzruIyoNipM2ggs7t3R/KXPXngsguBBaljvosC
	 JmcQsc86p9pzMar1kr9UBwRWHyynsCqc3rOqiAwKxoEaZGnNilDKweAgRNN2CAM+Ai
	 A87aCVIonM4mCikfEcN+hm5V5ggmstMHEz8R/zjBjzeHasF4o3p/07d8fITOdD4IaG
	 tGiTJXEBuzM2g==
Message-ID: <sashiko-outbox-205567@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_NO_DEEPEST_PS for Lexar NQ790
To: "Platon Miller" <platon.ksenzenkokk@gmail.com>, linux-nvme@lists.infradead.org
In-Reply-To: <20261109201503.10098-1-platon.ksenzenkokk@gmail.com>
References: <20261109201503.10098-1-platon.ksenzenkokk@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 20:19:11 +0000
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

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] nvme-pci: unreachable duplicate PCI ID entries in
  nvme_id_table [1]
--

commit 429e3e2e059a46cae1c4b2dd37e74978a88e3c7d
Author: Platon Miller <platon.ksenzenkokk@gmail.com>

nvme-pci: add NVME_QUIRK_NO_DEEPEST_PS for Lexar NQ790

This commit adds the NVME_QUIRK_NO_DEEPEST_PS quirk for the Lexar NQ790
SSD (PCI ID 1d97:5236) to prevent it from entering its non-operational
PS4 state via APST.

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index f8088d5aa724c..5414b16d44387 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -4508,6 +4508,8 @@ static const struct pci_device_id nvme_id_table[] =
=3D {
>  	{ PCI_DEVICE(0x1d97, 0x2269), /* Lexar NM760 */
>  		.driver_data =3D NVME_QUIRK_BOGUS_NID |
>  				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
> +	{ PCI_DEVICE(0x1d97, 0x5236), /* Lexar NQ790 / NM800 PRO */
> +		.driver_data =3D NVME_QUIRK_NO_DEEPEST_PS, },

[Severity: Medium]
This problem wasn't introduced by this patch, but nvme_id_table contains
duplicate PCI ID entries for 0x1d97:0x2263 [1]:

drivers/nvme/host/pci.c:nvme_id_table[] =3D {
    ...
	{ PCI_DEVICE(0x1d97, 0x2263),   /* SPCC */
		.driver_data =3D NVME_QUIRK_DISABLE_WRITE_ZEROES, },
    ...
	{ PCI_DEVICE(0x1d97, 0x2263), /* Lexar NM610 */
		.driver_data =3D NVME_QUIRK_BOGUS_NID, },
    ...
};

Because pci_match_device() stops at the first matching vendor and device
ID, is the Lexar NM610 entry unreachable, leaving those drives with
NVME_QUIRK_DISABLE_WRITE_ZEROES instead of NVME_QUIRK_BOGUS_NID?

[1] https://sashiko.dev/#/bug/linux-6e3b737e-406a-4fa3-94f8-00407fa27202

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109201503.1009=
8-1-platon.ksenzenkokk@gmail.com?part=3D1

