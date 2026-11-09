Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD587606D803
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BKAkAugY;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BW0uuf8c
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wikEh2wNcmpWRSkH73zoMOztDUfCBsFhYmukmcMkDAo=; b=BKAkAugYTWVs5vw28NMxCDHMd0
	A2EYV4LdHfwKaOeH43V0MNoWZk5wf9xmBHqfaYq0p2FwaoNhbU+ZYdOwHAkXHvFqPp0BBbzH4JJU8
	Y87TjVkH2d8bjBARGl2N3ScGiddA38QFhBIRmgp8LEtM06lx6yH51eCvj0GY2hPSPkSz2F4m6Bu28
	ZKxvYGTNOEPfqyPqrPVlsAAgIMwuaIkaVrRsw/qckibtjiZ30Q7DcjFD/Upk2zdhCuPggK0+tltg6
	Ti+dFrqxs9N3fh28dxGI807kc0sHw/WlfIYqOpZ9iJ/XPfQ6l/fNYngWpKHFcEfB/hF6eFaMD1J9i
	Kn4Cqu4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQOBg-00000000dDt-3Fra;
	Mon, 09 Nov 2026 12:09:24 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQOBZ-00000000dAT-3ASx
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 12:09:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 26A68631B7;
	Mon,  9 Nov 2026 12:09:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB60D1F008BD;
	Mon,  9 Nov 2026 12:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794226156;
	bh=wikEh2wNcmpWRSkH73zoMOztDUfCBsFhYmukmcMkDAo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BW0uuf8cJcee/ALlBcj7pl1em3AZqFFaSHWEX8+yxUP2Eehm6AVx8gkOh5ixAx3oW
	 abX4sWb7BwpyUofziQGglq+S0FIVOmxwzrKTUlPvJrYUjM8P4Ml+o4RgJL4QKopqZb
	 jcfWqIE0u1uPcui1cQT8YgAJpyT+bjJZo6O+Gvfl+T+2nPOLTYWOMI6QUqWNoGboSE
	 9wxYFvvtViR5zpsiK3mF9K4nT1Y7f8L5WVEbBCSEXeBE7rn1KhuzPDobgx8reZa/H0
	 IyYM+VTsK9TCk+npEybRbGbs09vFvJIEzVYcBGmWIqY8LCnmn2h9SAdUYOgrR0N7qt
	 S4LvcbPIU2asA==
Message-ID: <sashiko-outbox-204916@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] nvme: define the SMART / Health Status async event
 bit
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261109120207.1352165-2-kanie@linux.alibaba.com>
References: <20261109120207.1352165-1-kanie@linux.alibaba.com>
 <20261109120207.1352165-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 12:09:16 +0000
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
- [Medium] nvme: NVME_AEN_BIT_SMART and NVME_AEN_CFG_SMART use wrong
  OAES/CFG bit
--

commit be7079eb32755ede896d21f96ed7d1785a179279
Author: Guixin Liu <kanie@linux.alibaba.com>

nvme: define the SMART / Health Status async event bit

This commit adds NVME_AEN_BIT_SMART and NVME_AEN_CFG_SMART definitions to
include/linux/nvme.h.

> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 6248711784b37..2b4f8e269d12d 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -867,6 +867,7 @@ enum {
>  };
> =20
>  enum {
> +	NVME_AEN_BIT_SMART		=3D 1,
>  	NVME_AEN_BIT_NS_ATTR		=3D 8,
>  	NVME_AEN_BIT_FW_ACT		=3D 9,
>  	NVME_AEN_BIT_ANA_CHANGE		=3D 11,
> @@ -874,6 +875,7 @@ enum {
>  };
> =20
>  enum {
> +	NVME_AEN_CFG_SMART		=3D 1 << NVME_AEN_BIT_SMART,
>  	NVME_AEN_CFG_NS_ATTR		=3D 1 << NVME_AEN_BIT_NS_ATTR,
>  	NVME_AEN_CFG_FW_ACT		=3D 1 << NVME_AEN_BIT_FW_ACT,
>  	NVME_AEN_CFG_ANA_CHANGE		=3D 1 << NVME_AEN_BIT_ANA_CHANGE,

[Severity: Medium]
Do NVME_AEN_BIT_SMART and NVME_AEN_CFG_SMART match the NVMe specification
for Identify Controller OAES and NVME_FEAT_ASYNC_EVENT?

The value 1 is the Asynchronous Event Type (NVME_AER_SMART =3D 1) reported
in CQE DW0 bits 2:0, not an OAES or Asynchronous Event Configuration bit.
In the NVMe Base Specification, SMART / Health Critical Warning events are
mandatory, so bits 7:0 of OAES are reserved and zero on compliant
controllers. Checking ctrl->oaes & NVME_AEN_CFG_SMART will therefore find
the bit cleared and never subscribe to the event.

In the NVME_FEAT_ASYNC_EVENT feature (CDW11), bits 7:0 are individual
Critical Warning bitmasks corresponding to byte 0 of struct nvme_smart_log,
already defined right above in include/linux/nvme.h as
NVME_SMART_CRIT_SPARE through NVME_SMART_CRIT_VOLATILE_MEMORY (and used by
NVMET_AEN_CFG_ALL in drivers/nvme/target/nvmet.h). Passing 1 << 1 to Set
Features only enables NVME_SMART_CRIT_TEMPERATURE and leaves spare,
reliability, media, and volatile memory warnings disabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109120207.1352=
165-1-kanie@linux.alibaba.com?part=3D1

