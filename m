Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BEE606EE90
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HJEiy24B;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=K6algS6u
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:From:MIME-Version
	:Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Unsubscribe-Post:
	List-Owner; bh=A8EZ3OU0UVfWzD1uWBSCfyFrSnKJqMWb2HCXP5L6FJo=; b=HJEiy24BB39xX3
	Tk0nRmP+ynGHoBTLcyPHaOlQaoRK48YS2s1PFFhIkkBR0wA+GWA12oq4Ft6uBICO9uD+BlBwkyjNW
	TV/pd86jLcr9J3uJuNf7voLDlonYtWi1+Kq2wlYdxuMPHmCGjHqJ3YsXz+6hmSEyA6v2ZVH0AMcNx
	ACgGpP8qMNSQ8hrsPRH9XPbyHoOv/366GyG2DfbD4EGfribPuXQ4cuwQLnpfGuFQbwff0Ev0yE/UQ
	Tzkk9YaI5idF575XdDDoc8Tdw2m7ByJACtZQ9106N0o+BZa9sH+SWFz7Oz56NpWRpknRbswyaom+v
	utIqc3V0pbHtX9uYNbIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQSnF-00000001IAE-29Ta;
	Mon, 09 Nov 2026 17:04:29 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQN7o-00000000ThP-3Puj
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 11:01:22 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261109110115euoutp026f381f052f2ed519050519fb3bc92390~mW3i5-qUR0746507465euoutp02I;
	Mon,  9 Nov 2026 11:01:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261109110115euoutp026f381f052f2ed519050519fb3bc92390~mW3i5-qUR0746507465euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794222075;
	bh=A8EZ3OU0UVfWzD1uWBSCfyFrSnKJqMWb2HCXP5L6FJo=;
	h=To:CC:Subject:Date:From:References:From;
	b=K6algS6uiywTmIudth06CyiWxaoRXYl/xU5CCJqhvo1al4CMZbkCVV1qYk8p3WFHE
	 cmJpVfEsC6ZbApDFtdVwff18N9flu6NrQsZZFyGLbzpPhKxZI6TqUlZvO13zwK30/X
	 MJUyWKpxz4LIQQubusn0E5uP7AcBCgYfcPcL8FLQ=
Received: from eusmtxp2.samsung.com (unknown [203.254.199.147]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20261109110115eucas1p177180db97fcd9f7f80dbadc510c93a8f~mW3iucHk30536805368eucas1p1V;
	Mon,  9 Nov 2026 11:01:15 +0000 (GMT)
Received: from euex1p3.knox.samsung.com (unknown [182.198.248.187]) by
	eusmtxp2.samsung.com (KnoxPortal) with ESMTP id
	20261109110115eusmtxp2fa22bb95dc6167851e5317d5eb7c6f1f~mW3iuGuJ72428724287eusmtxp2U;
	Mon,  9 Nov 2026 11:01:15 +0000 (GMT)
Received: from euex1p2.knox.samsung.com (182.198.248.186) by
	euex1p3.knox.samsung.com (182.198.248.187) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.2.1748.10; Mon, 9 Nov 2026 11:01:15 +0000
Received: from euex1p2.knox.samsung.com ([fe80::795f:7bac:2d7:a24b]) by
	euex1p2.knox.samsung.com ([fe80::795f:7bac:2d7:a24b%12]) with mapi id
	15.02.1748.010; Mon, 9 Nov 2026 11:01:15 +0000
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Karl Bonde Torp <k.torp@samsung.com>, "os@safl.dk" <os@safl.dk>
Subject: NVMe Target implementation question
Thread-Topic: NVMe Target implementation question
Thread-Index: Ad1wOZBwA8cwqn2tTsqHF3H+tAfTcg==
Date: Mon, 9 Nov 2026 11:01:15 +0000
Message-ID: <d5526bf8ab18484e9646fda8aa765aa6@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: James Swaro <j.swaro@samsung.com>
X-CMS-MailID: 20261109110115exchanged5526bf8ab18484e9646fda8aa765aa6
X-CMS-RootMailID: 20261109110115exchanged5526bf8ab18484e9646fda8aa765aa6
References: <CGME20261109110115exchanged5526bf8ab18484e9646fda8aa765aa6@eucas1p1.samsung.com>
X-Bad-Reply: References but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_030120_989088_20DF6257 
X-CRM114-Status: GOOD (  11.05  )
X-Spam-Score: -2.8 (--)
X-Mailman-Approved-At: Mon, 09 Nov 2026 09:04:24 -0800
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi everyone,

I'm writing an NVMe initiator implementation and noticed an oddity in the k=
ernel target implementation. When initializing a request structure in the t=
arget for a received message (drivers/nvme/target/core.c:966), the driver i=
s checking whether the flags are set to SGL_METABUF and returning an error =
if it isn't set to SGL_METABUF. This seems to be incorrect according to the=
 specification, so I wanted to get clarification here first.=20

According to the NVMe 2.4 Base Specification, section 6.5 & 6.6 (Property s=
emantics), byte 1 containing the PDST/flags is supposed to be cleared to 0h=
. When clearing that byte on the initiator, this causes the target to retur=
n with an invalid command and DNR=3D1. Is this a case of legacy behavior be=
ing preserved from older specifications? Is there some part of the specific=
ation which contradicts this that I missed?

Kind regards,
James Swaro
Samsung SDS


