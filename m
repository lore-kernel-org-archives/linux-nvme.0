Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB1D606A335
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 22:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=j+Zdwr0Y;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SIHmDKTm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6cSzz+gPAByQvDVoRikecclGPWHztWnkKxHO71lH9Ik=; b=j+Zdwr0YXOHS/37NaDK5L2GTtD
	sOw34rj/R7wbzu6CTA4UpP9bA4e4nfWu/1KmcFsm29pnIQogmFbBSgEAsKoU5FrmQTYUl1bOf6Dq6
	RTC/6p3atYTXGbLy2HW+XXM1L39pjODbhNRP3TyY3ufRgOd8s7Cn9xMbowfQr7qR1nw2s3TVboQOL
	Y18X0Q39O5xWoSlpSwTKO8mJhD6/c1+YWLiN3RVw0qF9WREC86WsA71RSdrJV6qtLlcB/Zxa2ffYD
	MlMtN7/Fev39N0eoVfNCJTB/Mzix7zOJm/+USrzS+33vXP3LcRO9x5Sj6GdmHNAtoFRksT/eiKxEm
	o+S82WoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVctb-000000057H3-2QJT;
	Mon, 23 Nov 2026 22:52:23 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVctS-000000057Gx-40X9
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 22:52:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 691F261847;
	Mon, 23 Nov 2026 22:52:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDB71F000D2;
	Mon, 23 Nov 2026 22:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795474333;
	bh=6cSzz+gPAByQvDVoRikecclGPWHztWnkKxHO71lH9Ik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SIHmDKTmQOnMCVgHGFdUD704FN5Q0LoHMZ7lhR/2AMqfS4k8b8E0pM3YSeWH+H4Zt
	 SUA8rKiAPYZtijHkqjRsRt/WAmhXiziROfZKvZ5CoJ0vnCU+6SWscoy3mZaYiS3pkX
	 lQI47/y6it/IUOC5ovoFsdd+JZFX+BoOiSxdhklKXrTkUrJnHFxdc8glBW58hU4k8v
	 3jhO9y8Z98Ia65QzOWQzsSY8ILvDhgnH6A6qMwZn/E8KqxF5o9aQLD/+X+gUXHMvAQ
	 aATPRFwcPbYK1PWlH+2FhakoZ9Gu3+sPEmvpSzK+1fk2miGRKAScw1WydE0KnY9mg7
	 TCiNqaSO8gPpw==
Message-ID: <sashiko-outbox-230160@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvme-pci: Add IGNORE_DEV_SUBNQN quirk for Phison E19
To: "Paul Menzel" <pmenzel@molgen.mpg.de>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261123224020.134113-1-pmenzel@molgen.mpg.de>
References: <20261123224020.134113-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 22:52:13 +0000
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
- [Medium] nvme-pci: NVME_QUIRK_IGNORE_DEV_SUBNQN on 1987:5019 drops
  valid subnqn
--

commit 33a2a53ded342ddae773b6729c39a64a9a776cbe
Author: Paul Menzel <pmenzel@molgen.mpg.de>

nvme-pci: Add IGNORE_DEV_SUBNQN quirk for Phison E19

This commit adds NVME_QUIRK_IGNORE_DEV_SUBNQN to the Phison E19 PCI ID entry
(0x1987:0x5019) in nvme_id_table to silence the missing SUBNQN warning on a
Dell OEM SSD.

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 076603df01abb..ba5b1cdbb95e1 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -4398,7 +4398,8 @@ static const struct pci_device_id nvme_id_table[] =
=3D {
>  		.driver_data =3D NVME_QUIRK_IGNORE_DEV_SUBNQN |
>  				NVME_QUIRK_BOGUS_NID, },
>  	{ PCI_DEVICE(0x1987, 0x5019),  /* phison E19 */
> -		.driver_data =3D NVME_QUIRK_DISABLE_WRITE_ZEROES, },
> +		.driver_data =3D NVME_QUIRK_IGNORE_DEV_SUBNQN |
> +				NVME_QUIRK_DISABLE_WRITE_ZEROES, },

[Severity: Medium]
Does setting NVME_QUIRK_IGNORE_DEV_SUBNQN on the generic Phison E19 PCI ID
(0x1987:0x5019) cause nvme_init_subnqn() to discard valid id->subnqn values=
 on
other SSD models and firmware revisions using this controller?

When id->subnqn is empty, nvme_init_subnqn() already warns for NVMe >=3D 1.=
2.1
and falls back to generating a unique NQN from the device serial and model
numbers:

drivers/nvme/host/core.c:nvme_init_subnqn() {
	if(!(ctrl->quirks & NVME_QUIRK_IGNORE_DEV_SUBNQN)) {
		nqnlen =3D strnlen(id->subnqn, NVMF_NQN_SIZE);
		if (nqnlen > 0 && nqnlen < NVMF_NQN_SIZE) {
			strscpy(subsys->subnqn, id->subnqn, NVMF_NQN_SIZE);
			return;
		}

		if (ctrl->vs >=3D NVME_VS(1, 2, 1))
			dev_warn(ctrl->device, "missing or invalid SUBNQN field.\n");
	}
	...
}

NVME_QUIRK_IGNORE_DEV_SUBNQN is intended for firmware that reports a non-em=
pty
duplicate SUBNQN across distinct physical drives, and commit 40df2172853f
("Revert "nvme: add quirk NVME_QUIRK_IGNORE_DEV_SUBNQN for 144d:a808"")
rejected adding this quirk to nvme_id_table just to suppress the warning fo=
r an
empty SUBNQN field.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123224020.1341=
13-1-pmenzel@molgen.mpg.de?part=3D1

