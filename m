Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC677FD8FF9
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 18:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iAHNpzgGAf+/eFeLiU8g6bMoZfusdXV/adrgjPyBVeY=; b=hHvZBv8s+TrQHMIwiwXL75H//A
	gSDQhvXUD32mi9cVyXiFIxlAyk4gKNa1LpkOq9X7YLuPOhWIK+Kd3iW5LTSuVraqo0YeCyCnCQ72j
	nmURrMarBdA+2FVyN2sw+256ZwV2QtN1To0jFR/LM7CefjWN7HHdb/s8qM6jqqLhqbtSOOv++nX9e
	1b+oNqNAH5fz1Kws3Xdkde4YAG8CxNqTLoJSE/7qmI/qMWhKKm7rp6cKcNPsWcpYJz2EZW6Zq63AO
	6mcyooAlJnPlPjyV8/I2gvD111ripuMb6ScP/BN//26qi++t0tTI0gD0ZpKdrzZGtCrsJxNAT/Za7
	V4u5E4wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvgA9-00000006yHy-1D9f;
	Thu, 26 Feb 2026 18:32:37 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvgA6-00000006yGq-21LB
	for linux-nvme@bombadil.infradead.org;
	Thu, 26 Feb 2026 18:32:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=iAHNpzgGAf+/eFeLiU8g6bMoZfusdXV/adrgjPyBVeY=; b=BwmpA+PuXOHRskH4PS7Rj9xEQT
	xf8jltRA6FY5bRiagqu5Vfbio9502lQNH/dytZQZZp2bXAX494BVkZwIvviexiERJE6PQAmHOZqhz
	bvtHrorF1GW1ZZZ8Y8nhBsCxnUNY0/7FdRGBSpyKu3b0HgZlEnKLNCQMKhg+ED2c4ye7Vj/7mUvll
	G8sxRj9Is83vyK6S8u4OyEugb8xFsp8+Ty/g7onOhMbMLUfqz70eLSmdUwPMw0Y42EGnROCEIAw/X
	1EmxjaihfSVPlO0KGrOMqQjSb5XwMMVk4HEVLfuN6XQqJ7rleZV11P7H2jCTEjdDQe0p/uLsIbrpm
	Sg2cZCZw==;
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvgA3-0000000Bo2W-1Gp2
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 18:32:33 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QGgoev609228
	for <linux-nvme@lists.infradead.org>; Thu, 26 Feb 2026 10:32:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=iAHNpzgGAf+/eFeLiU
	8g6bMoZfusdXV/adrgjPyBVeY=; b=Xb/tiCwiaUeAtJzH5d/MpxxcnV3HI0DTk4
	ZCy3oZGDkeXAMzgeMgvPbzqZtLEKdwhAJPlt8DCQ0acuAARH4Detd8C7xzqUGrxp
	0akD38D977TtCobpPjVpF66VV1cu2qvCHJxV4HYnwnouR1nn0AVWnAPcAAGT/kbk
	KmMvhhQQf0oTo+B0YQp3ABqm6k8hVpvbEOayxsW9XFQgKLiKsr6N8ICYFoqKTIgg
	wQqRLSBdHJvhPskxHSya32j+A+ybmvP2/25wrchrpPP1dBaed3yscyMVVy8br1W3
	yF81bDPKJInaXSuGhsLPbrQl7dHyrVopqVjvPPXh/h1u2zxJKjog==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cjsxgharh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 26 Feb 2026 10:32:26 -0800 (PST)
Received: from twshared23938.03.snb2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 26 Feb 2026 18:32:26 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id C66E890B693D; Thu, 26 Feb 2026 10:32:16 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <nilay@linux.ibm.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/3] nvme: multi-path scan races fixes
Date: Thu, 26 Feb 2026 10:32:13 -0800
Message-ID: <20260226183216.2098584-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: WltKnVjzwAeSJWC2_HRTokJVKfVHCHmC
X-Authority-Analysis: v=2.4 cv=dLmrWeZb c=1 sm=1 tr=0 ts=69a091ba cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=P7DUUoSIE_BILViZ3RYA:9
X-Proofpoint-GUID: WltKnVjzwAeSJWC2_HRTokJVKfVHCHmC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE2OSBTYWx0ZWRfX9CuzpcorPt34
 xcC2cn6CJWz10N/FXJUeWL912JREhuCczhphNtJ9Zprb3c14HAwTDtj3sCN7PhDYSseJshOff5Z
 uWZYgEvkir2QV9akwl86eLmF3H5wsU03R8U85YW61D13D5rPCKUrHES9sc8/9GSLIJVc0jKGm1v
 wAMgslbjv8CbtAVsxm76gnpxTMMpRxwJWcGLmLdXUwj0QxSAFzcUyEV0dRD/b/ZTOnYUQkwRkZd
 l4pGb7xFJCKS+2c7ztKbe2IduLRcLJ7z7PZOusbXB3RSBlNuQrJ3n5tZ1pOCwSfSXrv4kWHMcrT
 c2fNtZID5fKIdd7BiND7I+o+//FogxDoBDjLonS0lnWBdV2ISSRsG9Ej29Q078xPI1fEOF3TG6/
 k6ZtD+LZclaJjIrww3LNuOOBCPMsig6ZYVQy7z8i0TnGrKTKljzEeRbEw1Gy+P4LRWsd3B5JKa2
 Nn4jYpSRL20WXpvRHVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_183231_837021_A75259E0 
X-CRM114-Status: UNSURE (   8.17  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Keith Busch <kbusch@kernel.org>

Changes from v1:

 * Added reviews and Fixes tags to patch 1

 * Redid the logic in patch 2 to match Christoph's suggestions

 * Also fixed a compile bug for CONFIG_NVME_MULTIPATH=3Dn

 * Added a new patch 3 to fix a dependency race between multiple
   controller's scan_work

Keith Busch (3):
  nvme-multipath: fix leak on try_module_get failure
  nvme-multipath: rescan siblings on last path removal
  nvme: fix unmatched id's under delayed path deletion

 drivers/nvme/host/core.c      | 37 ++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/multipath.c | 12 +++++-------
 drivers/nvme/host/nvme.h      |  9 +++++++++
 3 files changed, 50 insertions(+), 8 deletions(-)

--=20
2.47.3


