Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E13606A32D
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wdivV6Em;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gYpeo5w5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=oVTE3weS0vhGDg+O1CdntIM01MfPebQOmQXP514e+cI=; b=wdivV6EmFl1lJIkflt3jzW1i4h
	/7bQ4gRszwatDEd0JfqrkCim/qcKyLGHwPhsK0reNqrek2gz87s8S15TdhoGz9vDK9knIVkOPMN85
	ZIq4cnhnYWId6t4w6KnGkWYopm2BJqv5G3f9a7uzYV3GU8aeH7wT4kdwOYKBGYdqwPxkgGGEHFZnS
	xmrlWgutQZONmKmSxGmf2ix7a4K4f3PkS60qbqoUnzRMIsWoxt9M1GO+iK7w50nZOawD9DAnhHShC
	0RcubvRiF2gyvMDcdyUbER+Gv4+uoSIh1hocyuYahY+U5IKPT73N3/yS/FCJTVVdjUZG8GILxPnOY
	I7hvTQzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSHgz-0000000GYNh-0ttc;
	Sat, 14 Nov 2026 17:37:33 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSHgw-0000000GYNZ-3zIP
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 17:37:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6CD3D401D7;
	Sat, 14 Nov 2026 17:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275591F000C4;
	Sat, 14 Nov 2026 17:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794677850;
	bh=oVTE3weS0vhGDg+O1CdntIM01MfPebQOmQXP514e+cI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=gYpeo5w5k7cP6jHmKKlnIOjR4kqRF0dBBKi4r1mzzYXJTABMvZJsOZtnaxEc2q6LI
	 AKoTQDiA9f8twOscr/TPfbocxtlfBB4/fH/P50ZoQ9toXsJSIDarVGPhVcfhHAuEqz
	 Z+NUdROYZmfGs70rR5yrmhfUxRRAfmhAeakB5jTCfeLoalsVy3n9tQITM45weIOhsM
	 eHRqumw7kcM4dcv/S66sBw7C+tRyS+H5oQWUpJo+5m8X+P8Fz9scSCiXa3eas4E+Al
	 M8GdSQ+8+zYjc3/vNR8+Zr3kYRCR/cLCify/epixytI1lQbUAWlta/SWK9C3w5mbUV
	 YBB56nQCH0xew==
Message-ID: <sashiko-outbox-214846@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] nvme: decode the FDP Get Features result as a dword
To: shao.mingyin@zte.com.cn, linux-nvme@lists.infradead.org
In-Reply-To: <202611150127572887TC7vHzVUFLZ6nyW1NuhU@zte.com.cn>
References: <202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn>
 <202611150127572887TC7vHzVUFLZ6nyW1NuhU@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 17:37:29 +0000
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
- [Medium] nvme: uninitialized stack memory use in
  nvme_query_fdp_granularity() [1]
--

commit 37e4c911db178216572cd8ee6fd19cfc2f58c7f0
Author: Shao Mingyin <shao.mingyin@zte.com.cn>

nvme: decode the FDP Get Features result as a dword

This commit changes nvme_query_fdp_info() to read the NVME_FEAT_FDP Get
Features result as a u32 and decode the flags and FDP configuration index
manually so that FDP probing works on big-endian hosts.

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a7a4d09644c13..45feafa003257 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2339,8 +2339,8 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, =
struct nvme_ns_info *info)
>  	struct nvme_ns_head *head =3D ns->head;
>  	struct nvme_ctrl *ctrl =3D ns->ctrl;
>  	struct nvme_fdp_ruh_status *ruhs;
> -	struct nvme_fdp_config fdp;
>  	struct nvme_command c =3D {};
> +	u32 fdp;
>  	size_t size;
>  	int i, ret;
> =20
> @@ -2351,10 +2351,10 @@ static int nvme_query_fdp_info(struct nvme_ns *ns=
, struct nvme_ns_info *info)
>  		return ret;
>  	}
> =20
> -	if (!(fdp.flags & FDPCFG_FDPE))
> +	if (!(fdp & FDPCFG_FDPE))
>  		return 0;
> =20
> -	ret =3D nvme_query_fdp_granularity(ctrl, info, fdp.fdpcidx);
> +	ret =3D nvme_query_fdp_granularity(ctrl, info, (fdp >> 8) & 0xff);

[Severity: Medium]
This problem wasn't introduced by this patch, but can
nvme_query_fdp_granularity() read uninitialized stack memory from hdr.sze
[1]?

drivers/nvme/host/core.c:nvme_query_fdp_granularity() {
	struct nvme_fdp_config_log hdr, *h;
	...
	ret =3D nvme_get_log_lsi(ctrl, 0, NVME_LOG_FDP_CONFIGS, 0,
			       NVME_CSI_NVM, &hdr, size, 0, info->endgid);
	if (ret) {
		...
		return ret;
	}

	size =3D le32_to_cpu(hdr.sze);
	...
	h =3D kvzalloc(size, GFP_KERNEL);
}

hdr is allocated on the stack without zero-initialization.  If the
controller completes the log page command with a short data transfer,
hdr.sze remains uninitialized and is passed as the allocation size to
kvzalloc().

[1] https://sashiko.dev/#/bug/linux-1cda5d44-a6cc-40a9-bd2b-cbed1b364093

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/202611150127512368B=
GQ07ZNIRAIwClkam-8u@zte.com.cn?part=3D4

