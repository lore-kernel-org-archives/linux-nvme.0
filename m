Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BC0C3ABBF
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 23:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=NsBo0nfnZrMtN89r+UT1Umgoojr2ADECglFNS7LMLeE=; b=JIlDFAKpcA8wHLC2nkaVtjxeN5
	dclCp0SEGJYsTyW+mQTG6s9JyLIatE6alEhus465D+RgK3U2S7BtCMiOhScaGsR60CVDtzbCu0TrV
	MAvxZk2Xer+nA0MaLYeY2j7hwq+K4EXaaaycov0e0Saisrf954UjsKKft6fjn/yUZ/FMbQONYKhhP
	ckBb0By/q3jJQNAf2xzBuZgssuCtbzKaijDU8UiqTq19W2JB8RSreEbNrVHpBMdgGVXbPrlpMVKRa
	V8j7A3tBZAKWcwGofBQLRanZwObalmtpyclX5b7AoZYkgZp/QBVvEsXxjM59UMyOZMkoKmltIPIoD
	SNjv3dog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCRpM-0000000DftZ-47R0;
	Tue, 06 May 2025 23:35:56 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCMg4-0000000Cw5Z-0iFZ
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 18:06:02 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250506180548epoutp03a510ed8ff7f2fd09084686a493f898ed~9Ako7VCGW3199431994epoutp03n
	for <linux-nvme@lists.infradead.org>; Tue,  6 May 2025 18:05:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250506180548epoutp03a510ed8ff7f2fd09084686a493f898ed~9Ako7VCGW3199431994epoutp03n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1746554748;
	bh=NsBo0nfnZrMtN89r+UT1Umgoojr2ADECglFNS7LMLeE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=QyGGluY8U1crMpDkheE5q2ts1ufjtMqdQVc+8G0gC5BYIVREf3EE4Wq6Siq5CS6Xa
	 8m7Y+hyN8LnR3Igc5NE1LH9YX6xSp+uAIoVr0gScuNAhKQCKgkO6nNrfQfLQwJUZwU
	 R8/UA97h0sbOehZ1RHhziGU1jFQP+HLnv4GgcvV4=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250506180548epcas5p2876c949448ecdf161738693107f6ca59~9AkopIpga2572025720epcas5p2t;
	Tue,  6 May 2025 18:05:48 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.179]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4ZsRCG5lKvz6B9m5; Tue,  6 May
	2025 18:05:46 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250506180545epcas5p34d4857f38b838532678728db22df6067~9AkmcqVa41399313993epcas5p3X;
	Tue,  6 May 2025 18:05:45 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250506180545epsmtrp10479f8d6c74e49eebb0bb02ab6969c3f~9AkmcHUcT2964129641epsmtrp1X;
	Tue,  6 May 2025 18:05:45 +0000 (GMT)
X-AuditID: b6c32a2a-d57fe70000002265-fc-681a4f794526
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	95.5A.08805.97F4A186; Wed,  7 May 2025 03:05:45 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250506180544epsmtip11609bd34dc14687e3ad4d65778b2647b~9AklkrdjZ0802308023epsmtip1R;
	Tue,  6 May 2025 18:05:44 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, linux-nvme@lists.infradead.org
Cc: csander@purestorage.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH] nvme: fix incorrect sizeof
Date: Tue,  6 May 2025 23:26:56 +0530
Message-Id: <20250506175656.23151-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrELMWRmVeSWpSXmKPExsWy7bCSnG6lv1SGQV+rksXqu/1sFv8XzmW1
	OPr/LZvFpEPXGC3mL3vK7sDqcflsqcemVZ1sHpuX1Htse9jL7tG3ZRVjAGsUl01Kak5mWWqR
	vl0CV8bkviOMBVvYKra/mcPWwLiOtYuRk0NCwETi0uxbTF2MXBxCArsZJV4+aGKESIhLNF/7
	wQ5hC0us/PecHaLoI6NE+5dTQEUcHGwCmhIXJpeC1IgIeEk0XzrCDGIzCzhJzLnYwgJiCwto
	S/x6OxVsGYuAqsSppj1grbwCFhLH/ptAjJeXmHnpO9gqXgFBiZMzn7BAjJGXaN46m3kCI98s
	JKlZSFILGJlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIEB6OW1g7GPas+6B1iZOJg
	PMQowcGsJMJ7/75khhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeb697U4QE0hNLUrNTUwtSi2Cy
	TBycUg1MW2o+bNS7tXPSGcOIU17m7Ma9XbPKn38varGPcGVLtLsu+LTmyITfK6IYzW0V1G9O
	s5Di6FzhZb0x9/D9GNsdfAZT+p/N2L30nkGog96J09cObPL6oFhkz1k6vTTT9Sn/V4Z9F5xu
	fbKc3+J2aNqjn2/bhQVfbNlyMzg1a+oBs1OdZnOMizq14hav8O04ILPlyE6BB0v1JXT5kj6Y
	uvDO1tS5ZX1X8c4UhflfEq5q120+7VBZm3rMJ28a0++zsY/i0nu7y3cFMPI3HNu5viHuzPVK
	F+6/k7Rikn78rMz19Py48O6+/ZO1vA0svsstn555eIaG9mKTCWy/Q82sJGZHvOpa9WTL5ozT
	6079jrDaqsRSnJFoqMVcVJwIADCwIGS1AgAA
X-CMS-MailID: 20250506180545epcas5p34d4857f38b838532678728db22df6067
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250506180545epcas5p34d4857f38b838532678728db22df6067
References: <CGME20250506180545epcas5p34d4857f38b838532678728db22df6067@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_110600_827868_2A9D1850 
X-CRM114-Status: GOOD (  13.96  )
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

Use the sizeof(*head->plids) in kcalloc so that we don't allocate extra.

Fixes: 38e8397dde63 ("nvme: use fdp streams if write stream is provided")
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 52331a14bce1..7c1b9f2bf0ae 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2296,7 +2296,7 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 	if (!head->nr_plids)
 		goto free;
 
-	head->plids = kcalloc(head->nr_plids, sizeof(head->plids),
+	head->plids = kcalloc(head->nr_plids, sizeof(*head->plids),
 			      GFP_KERNEL);
 	if (!head->plids) {
 		dev_warn(ctrl->device,
-- 
2.25.1


