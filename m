Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69912C04A94
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Aug 2023 07:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/RLnxGM6+CIysdMXiYRH09arI3UcGTmgOc5/fXZBsPE=; b=dF5j4tuXn/QuC8Br2H/9rixFl2
	T3FG0XEbiTQgUj1Z8w436arJQhTahWE257Xb8nao8kECqTgfIo+hn5epdza4wtkma6FqpnUQaMIPm
	g2sLvRX+8Z2l4SH+GKmrssKxls6J3kPBqSVwgLT1UjXb36MEXSS9C4GTaKfVoHSpLCdTlyw7HzDki
	ltiRqWBLtCvR/yAhcnq6LQkyq3fPmFE+1Pkk5Nwb8E2Bf3B35QZWxlau8dRjLwJP5GL2NoN6BnOMf
	4rAwVFxgDmBLVmKBzeY7jL/YL1UrcJ0ARsNLnIyJ6O8krNc8fneapaMVplekX/9oHHR6YMaqQKj6L
	yB4gNpkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVReN-00GKJk-16;
	Mon, 14 Aug 2023 07:06:03 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVReL-00GKHw-08
	for linux-nvme@lists.infradead.org;
	Mon, 14 Aug 2023 07:06:02 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230814070554epoutp03477ce86eb0a0f562da8cbf6c6b92e590~7LhV_g3p13182831828epoutp037
	for <linux-nvme@lists.infradead.org>; Mon, 14 Aug 2023 07:05:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230814070554epoutp03477ce86eb0a0f562da8cbf6c6b92e590~7LhV_g3p13182831828epoutp037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1691996754;
	bh=/RLnxGM6+CIysdMXiYRH09arI3UcGTmgOc5/fXZBsPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DH9fs3pppVi7s0AUU/LY7YhO6M6nfWklV7jZTpgs6z28QaraBKEcg4tAFwLGHSKrc
	 jYKwZLYcKUV7cDKSfpHmB79dwBpN9cfAFampjBjf6sFfApZLnWDWEId2eD6+9ROqtZ
	 i2l6ttBarRDq3Jh4y8PgKr9OF7TojW0CjJUURIWI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20230814070554epcas5p13c716a7877240453f826fc082bcda4a3~7LhVfHnXk1005910059epcas5p1h;
	Mon, 14 Aug 2023 07:05:54 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4RPQR436Ttz4x9Ps; Mon, 14 Aug
	2023 07:05:52 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D1.EB.57354.052D9D46; Mon, 14 Aug 2023 16:05:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20230814070552epcas5p2940c7b3fef64f7e405dcd18855c240b0~7LhTaryIW2539025390epcas5p2l;
	Mon, 14 Aug 2023 07:05:52 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230814070552epsmtrp1b10bfdedc58b0de7e0dd488a4af529e1~7LhTZ7pPN0093400934epsmtrp1C;
	Mon, 14 Aug 2023 07:05:52 +0000 (GMT)
X-AuditID: b6c32a44-269fb7000001e00a-19-64d9d2509939
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	39.B8.64355.F42D9D46; Mon, 14 Aug 2023 16:05:51 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230814070550epsmtip2cddfc5ad2dcc8f2a96ce9de7f0fe68fc~7LhRz0s-92323723237epsmtip2_;
	Mon, 14 Aug 2023 07:05:50 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, vincentfu@gmail.com,
	ankit.kumar@samsung.com, joshiiitr@gmail.com, gost.dev@samsung.com, Kanchan
	Joshi <joshi.k@samsung.com>
Subject: [PATCH v2 2/2] nvme: avoid memory corruption for sync passthrough
Date: Mon, 14 Aug 2023 12:32:13 +0530
Message-Id: <20230814070213.161033-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814070213.161033-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmum7ApZspBpM6xCzWXPnNbrH6bj+b
	xc0DO5ksVq4+ymRx9P9bNovzbw8zWUw6dI3RYv6yp+wW616/Z7HY0CbowOWxc9Zddo/z9zay
	eFw+W+qxaVUnm8fmJfUeu282sHn0bVnFGMAelW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pm
	YKhraGlhrqSQl5ibaqvk4hOg65aZA3SdkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUg
	JafApECvODG3uDQvXS8vtcTK0MDAyBSoMCE748Mt2YLVnBUTf/xla2B8wt7FyMkhIWAicX7F
	fJYuRi4OIYHdjBKzPtyFcj4xSiy8MJkJzrm7/y0TTMvnbR/AbCGBnYwSF66mQxR9ZpR4f64Z
	qJ2Dg01AU+LC5FKQGhEBF4mGf28YQWqYBZYwSsx/t4QZJCEs4CUx/f47VhCbRUBV4v++V2BD
	eQUsJabvec8KsUxeYual72C3cgpYSTxZspUFokZQ4uTMJ2A2M1BN89bZzCALJAQaOSQmHX8D
	1ewicWrvNqirhSVeHd8C9bSUxMv+Nig7WeLSzHNQNSUSj/cchLLtJVpP9TODPMMM9Mz6XfoQ
	u/gken8/YQIJSwjwSnS0CUFUK0rcm/QUaqu4xMMZS6BsD4kvj+ewQ8Knl1Hi+eKVjBMY5Wch
	eWEWkhdmIWxbwMi8ilEytaA4Nz012bTAMC+1HB6vyfm5mxjBaVTLZQfjjfn/9A4xMnEwHmKU
	4GBWEuG95X4tRYg3JbGyKrUoP76oNCe1+BCjKTCMJzJLiSbnAxN5Xkm8oYmlgYmZmZmJpbGZ
	oZI47+vWuSlCAumJJanZqakFqUUwfUwcnFINTFl8DV7LNRJf9fSZ2N+ebP/B+v6X3c3HAg9n
	z7t7K1tyoWGwuMUT92zhIMOA009Srqj7LZi+Nv353VCDNxyLpz/nean4YULllOmRFZ9X2F1p
	Ud+31GPNQtedC58rW0S9e3aGrfXWysVzZMxbDgbvWLjK78d1w619z8o5p06NnPTorq/Wf4nH
	sr5qv3dL3QrT6X8dlyESPYPbU+SVRdg9hSOTipmnvHyWPfOCWPC29Xxn//3Nm7L5S+zDiJr1
	iWl2wvci5izZuqb77YXy9ZdWr28ocLUTET8uLXCiWWXpkVkui53s5/AuXmKwIsmOO2JfUdya
	LSb3A1csmZaczbQnpKpC3OhUT8WPc8FzvzF3zLdQYinOSDTUYi4qTgQAmnLl7iwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsWy7bCSvK7/pZspBqu/WVusufKb3WL13X42
	i5sHdjJZrFx9lMni6P+3bBbn3x5msph06BqjxfxlT9kt1r1+z2KxoU3Qgctj56y77B7n721k
	8bh8ttRj06pONo/NS+o9dt9sYPPo27KKMYA9issmJTUnsyy1SN8ugSvjwy3ZgtWcFRN//GVr
	YHzC3sXIySEhYCLxedsHpi5GLg4hge2MEkuOL2CDSIhLNF/7AVUkLLHy33N2iKKPjBJ/9x1m
	7GLk4GAT0JS4MLkUpEZEwEti3uwFLCA2s8AqoJrPeiC2MFB8+v13rCA2i4CqxP99r5hAbF4B
	S4npe96zQsyXl5h56TvYLk4BK4knS7aCzRECqlm/7Q0jRL2gxMmZT6Dmy0s0b53NPIFRYBaS
	1CwkqQWMTKsYRVMLinPTc5MLDPWKE3OLS/PS9ZLzczcxggNfK2gH47L1f/UOMTJxMB5ilOBg
	VhLhveV+LUWINyWxsiq1KD++qDQntfgQozQHi5I4r3JOZ4qQQHpiSWp2ampBahFMlomDU6qB
	aZNeR7xrliTvLpk9wZumJj/fmiW9Xit77ieznX96/fzrphzIit3248a8+NhqGyszruWcwcZB
	u+xdNEPa/S946F5ienzuwpfpK6a7n605qsJkuOT242b5tP0VEWr2O+8aTV946HtPg5z3DttL
	tXNMC1887+WcX/Wc9S47U7Oi9yb14pc32v+4THAt3Tx3a5WC17GN71sWXvOSKFCJ2bVxf+2y
	3Z/qzpspteXscJ137tRzA5b0xzVO3gcu5j260HHFOprZz1/ReV7Ih13nLJi11U3OPZuSvjv9
	7OVw2Y3cR+2ndLnPTpatlZdYFbn0C0tSQeC85Z8M1O6Kz7occfGpicsSs+URN1/wrf6Wvk+l
	QYmlOCPRUIu5qDgRAFD2niXrAgAA
X-CMS-MailID: 20230814070552epcas5p2940c7b3fef64f7e405dcd18855c240b0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230814070552epcas5p2940c7b3fef64f7e405dcd18855c240b0
References: <20230814070213.161033-1-joshi.k@samsung.com>
	<CGME20230814070552epcas5p2940c7b3fef64f7e405dcd18855c240b0@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230814_000601_408429_991583A2 
X-CRM114-Status: GOOD (  13.29  )
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

Sync passthrough metadata handling also needs to avoid the situation of
device writing into unrelated kernel memory.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/ioctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 717c7effaf8a..d97657fb6e39 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -393,6 +393,10 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
 	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
 
+	if (!nvme_validate_passthru_meta(ctrl, ns, &c, cmd.metadata,
+					 cmd.metadata_len))
+		return -EINVAL;
+
 	if (!nvme_cmd_allowed(ns, &c, 0, open_for_write))
 		return -EACCES;
 
@@ -440,6 +444,10 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
 	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
 
+	if (!nvme_validate_passthru_meta(ctrl, ns, &c, cmd.metadata,
+					 cmd.metadata_len))
+		return -EINVAL;
+
 	if (!nvme_cmd_allowed(ns, &c, flags, open_for_write))
 		return -EACCES;
 
-- 
2.25.1


