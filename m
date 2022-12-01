Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B15C43217
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Dec 2022 12:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=DpHrgwcMMAV3ulVmpJjsbotWy9lQy+77KDiaOpg1Ncg=; b=XX7PcGPRw8Tkm8tNZa2Mbbzb5Q
	JwNo2kOSMlWiGaQk67dtkNzJR2VAVlw3CDwIDCWx1PhgR5m1u+Oukl83XNtX19RnbNxRV6t0M3Srm
	FbMwuKIhe0r35yyuOoQU0lHkIPAZUxtxVfpABJNpFXzI+YQICAEC7vjZCaqPUW4AiZLilgG+rZTs9
	VdtktFx3lNHoZEu18vFEmBxS5/RUN8Axwl6N+vlcrv27eSbmC/yNBrppWChjrjYarLLq+rTh2ItDK
	R4+fdaKvDL8RAuFIJNwI+Y2pknd8JuqDs0Lt9giJINGsEePFft+NkDHGZ3Z80X0vK5+qIM2VtUjYY
	DXxbkNbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0j5J-007Ogm-DW; Thu, 01 Dec 2022 12:54:37 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0j57-007OcZ-LK
	for linux-nvme@lists.infradead.org; Thu, 01 Dec 2022 12:54:30 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221201125413euoutp016d5ad075edee81205a4c3be9b69d48c9~srIX1okq00889008890euoutp01x
	for <linux-nvme@lists.infradead.org>; Thu,  1 Dec 2022 12:54:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221201125413euoutp016d5ad075edee81205a4c3be9b69d48c9~srIX1okq00889008890euoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1669899253;
	bh=DpHrgwcMMAV3ulVmpJjsbotWy9lQy+77KDiaOpg1Ncg=;
	h=From:To:CC:Subject:Date:References:From;
	b=gNq2jlnn3DbMkYIVCJN3uGTevViFmcegaNNwFWZZpyItcsEfLzmwz78mF1qq1vYUe
	 68ERrabPS3GsnC/zwamM2AzSTgMtFvNgxk3SeZTHxB7V2amw9J6Ujgp+a1wXRCeA/1
	 pzLInvy+8QVBIATgVAlCJNXp0uaaFX58aDEr+/I4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20221201125412eucas1p22a4abb4f38de6b28cd073fa8b3bb6ad7~srIXn9yn02127221272eucas1p2P;
	Thu,  1 Dec 2022 12:54:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id D7.3E.10112.4F3A8836; Thu,  1
	Dec 2022 12:54:12 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20221201125412eucas1p17da85d566e9786dba7d76230f396eb57~srIXWmQEx1169911699eucas1p1M;
	Thu,  1 Dec 2022 12:54:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221201125412eusmtrp2383779b64a04106dd5f51384a0514af7~srIXV1YyA1070410704eusmtrp25;
	Thu,  1 Dec 2022 12:54:12 +0000 (GMT)
X-AuditID: cbfec7f4-cf3ff70000002780-2d-6388a3f406cb
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id BC.59.08916.4F3A8836; Thu,  1
	Dec 2022 12:54:12 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20221201125412eusmtip1c7b32a5a2bed5e42da4e48361d3c1eeb~srIXHzsEX0130701307eusmtip1Q;
	Thu,  1 Dec 2022 12:54:12 +0000 (GMT)
Received: from localhost (106.110.32.100) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 1 Dec 2022 12:54:11 +0000
From: Pankaj Raghav <p.raghav@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
	<gost.dev@samsung.com>, Monish Kumar <monish.kumar.r@intel.com>, "Pankaj
 Raghav" <p.raghav@samsung.com>
Subject: [PATCH] nvme:core: initialize core quirks before calling
 nvme_init_subsystem()
Date: Thu, 1 Dec 2022 13:52:34 +0100
Message-ID: <20221201125233.41094-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.100]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZduzned0vizuSDaY8NbdYufook8WkQ9cY
	LeYve8pu0Xor1GLd6/csDqwe5+9tZPFYvOclk8emVZ1sHpuX1HvsvtnAFsAaxWWTkpqTWZZa
	pG+XwJWxYdFstoJtfBWHVjxnaWB8yN3FyMkhIWAi0X71CGsXIxeHkMAKRomej61MEM4XRol1
	578wQjifGSW+X7zDAtPy/MUOdojEckaJfz8+scBV7bnyFmrYZkaJA9+3A2U4ONgEtCQaO9lB
	ukUEnCX+9p4H28EMUnNt90NmkISwQKTEwTfL2EBsFgEViS2r94Ot4xWwlHi0+BYbxGp5iZmX
	vrNDxAUlTs58AlbDDBRv3jqbGcKWkDj44gUzRL2SxIR596F6ayVObbkFtlhC4ACHxOU9r6AS
	LhIfpzxkh7CFJV4d3wJly0j83zmfCcKulnh64zczRHMLo0T/zvVsIJ9JCFhL9J3JgTAdJX6c
	tYEw+SRuvBWEOIdPYtK26cwQYV6JjjYhiIFqEjuatjJOYFSeheSZWUiemYXkmQWMzKsYxVNL
	i3PTU4uN8lLL9YoTc4tL89L1kvNzNzECE8vpf8e/7GBc/uqj3iFGJg7GQ4wSHMxKIrzvejuS
	hXhTEiurUovy44tKc1KLDzFKc7AoifOumAKUEkhPLEnNTk0tSC2CyTJxcEo1MBncSl7f2n3Q
	6OXsu7sDXyeIfGJzmsFckq7bXOP74eeFa425G1oOHfuz8vzVfQ33runO1Z9Q4nVfJkWMXyM4
	eNKTtD1vy0K2PG3p/iLqJd7k+eyv6mLVpzNtRNSD8hnk/rOqb7j4rzZWaKKMaZy9DPMml5Mr
	uOIn9tvOrxO2M90589WPOew7fLViFAKPXfkxfc1Si6p380rU+8uYPxzZmTRNfvpjld/vDiSf
	eaUVNOO2RdvbwHXrjOdU2tkx5ilN9W1VPrPNuq7hd/P8VVIG8U8Unm8ocCxTDartuz1b80nI
	j0nOp43ZzO59P+PJ4iNy5xH74n8HxbYrMaXPK8mNPCW20DWiSmK+tmD5Tc6nt5RYijMSDbWY
	i4oTAUB7/tKbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xu7pfFnckG3StVLBYufook8WkQ9cY
	LeYve8pu0Xor1GLd6/csDqwe5+9tZPFYvOclk8emVZ1sHpuX1HvsvtnAFsAapWdTlF9akqqQ
	kV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJexYdFstoJtfBWHVjxn
	aWB8yN3FyMkhIWAi8fzFDvYuRi4OIYGljBIvp6xghEjISHy68pEdwhaW+HOtiw2i6COjxM8Z
	Z5ggnM2MElMnfwKq4uBgE9CSaOwEaxARcJb423serIYZpOba7ofMIAlhgXCJlmsnWEBsFgEV
	iS2r94PZvAKWEo8W32KD2CYvMfPSd3aIuKDEyZlPwGqYgeLNW2czQ9gSEgdfvGCGqFeSmDDv
	PlRvrcTnv88YJzAKzULSPgtJ+ywk7QsYmVcxiqSWFuem5xYb6hUn5haX5qXrJefnbmIERtK2
	Yz8372Cc9+qj3iFGJg7GQ4wSHMxKIrzvejuShXhTEiurUovy44tKc1KLDzGaAv0zkVlKNDkf
	GMt5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1MMXwnWqL22haq
	exp6833dwn+jSVDG9NUEd8VzCwRZw32EjZyVf2/VDPnx/b2JSWhIgETz78Mi5hNexhzf32S9
	inHiiYu/f241dqtTZ3brFHy4+N9thxmdV9IN2RmbnHN3VHNcqE6IzNDdoX5y2SwWh/nnPna/
	6j9w4IhONt//v5JXvrW3bom88Ep8m2ph1un6LTHuSVHq/rq75uguFD7yM06I4f7sp+c5hBcJ
	HO0t2FGhV6W094fVB9EtWdOi9t6YZO2qmTh5fryAx3EPuZbdx40mVl8/tF5TT8N81tcDkpf8
	Zmxj3y2md37NfOaC7Y27VymsOeB/77hQ3qbNK5xmTFyp4X9J8e48QVvFCosoJZbijERDLeai
	4kQA6nIA1C0DAAA=
X-CMS-MailID: 20221201125412eucas1p17da85d566e9786dba7d76230f396eb57
X-Msg-Generator: CA
X-RootMTR: 20221201125412eucas1p17da85d566e9786dba7d76230f396eb57
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221201125412eucas1p17da85d566e9786dba7d76230f396eb57
References: <CGME20221201125412eucas1p17da85d566e9786dba7d76230f396eb57@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221201_045428_023894_EE8AF449 
X-CRM114-Status: GOOD (  14.24  )
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

A device might have a core quirk for NVME_QUIRK_IGNORE_DEV_SUBNQN(such as
Samsung X5) but it would still give a warning "missing or invalid
SUBNQN field" as core quirks are filled after calling nvme_init_subnqn().

Fill ctrl->quirks from struct core_quirks before calling
nvme_init_subsystem().

Tested it on a Samsung X5:

Before patch:
nvme nvme1: pci function 0000:3e:00.0
nvme 0000:3e:00.0: enabling device (0000 -> 0002)
nvme nvme1: missing or invalid SUBNQN field.
nvme nvme1: Shutdown timeout set to 8 seconds
nvme nvme1: 8/0/0 default/read/poll queues

After Patch:
nvme nvme1: pci function 0000:3e:00.0
nvme 0000:3e:00.0: enabling device (0000 -> 0002)
nvme nvme1: Shutdown timeout set to 8 seconds
nvme nvme1: 8/0/0 default/read/poll queues

Fixes: ab9e00cc72fa ("nvme: track subsystems")
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/nvme/host/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e68b98daf38a..0ac37a4afc20 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3123,10 +3123,6 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 	if (!ctrl->identified) {
 		unsigned int i;
 
-		ret = nvme_init_subsystem(ctrl, id);
-		if (ret)
-			goto out_free;
-
 		/*
 		 * Check for quirks.  Quirk can depend on firmware version,
 		 * so, in principle, the set of quirks present can change
@@ -3139,6 +3135,10 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 			if (quirk_matches(id, &core_quirks[i]))
 				ctrl->quirks |= core_quirks[i].quirks;
 		}
+
+		ret = nvme_init_subsystem(ctrl, id);
+		if (ret)
+			goto out_free;
 	}
 	memcpy(ctrl->subsys->firmware_rev, id->fr,
 	       sizeof(ctrl->subsys->firmware_rev));
-- 
2.35.1


