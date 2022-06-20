Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20AF4C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jun 2022 12:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=mkEFySNLV0JtHqI8HaKvCsaTK+0y9ZFR4XXs8ow9J5E=; b=qrhA1k5tkoKrp4D++PyUzfGDXp
	EixinfiUF70QbQ8qjZanyvYgd15aT6OFnpPywoBlooi9v0THmMy1k1z3BLUi6KI/xjveKRBOeshje
	pn2xYQDFZFY6WP5mNjPEyVkK5myYlSXYGtTCqeUqLXWuCzPiOLYMMNVD2hjUJ1FZcTP9jt5o36vCy
	bX5A7zvs9jaHAca8Ga2AUd3GsdfcuuoaQjRpKvass0ZPPHeRUaIyqyjLVKe+jn/OUlew8sCYVpY6b
	EkDe4kX96yImssS0gx76EDzJ01cQrxs3XR9gwc3MQjXDRT/v9qFMs6QB7B+fbwkxrx9X8zmQ5Suy6
	NV8zVpwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3GKB-000KtO-Ob; Mon, 20 Jun 2022 12:16:11 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3GFQ-000IaU-Fj
	for linux-nvme@lists.infradead.org; Mon, 20 Jun 2022 12:11:18 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220620121113euoutp0235a6148692866157c523a079e9482f1c~6UwBRtmPx2694326943euoutp02c
	for <linux-nvme@lists.infradead.org>; Mon, 20 Jun 2022 12:11:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220620121113euoutp0235a6148692866157c523a079e9482f1c~6UwBRtmPx2694326943euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1655727073;
	bh=mkEFySNLV0JtHqI8HaKvCsaTK+0y9ZFR4XXs8ow9J5E=;
	h=From:To:CC:Subject:Date:References:From;
	b=I4ost6nXs2VAKkRTfjvUh+u2auNDfsvOJCkq8TSByTAW5fbUo3M2BuiBHjn+jjq1x
	 ShL6ymHNrdk7w5JFyun7E3RS3ODyjeeNYdA08UWFsexCOIQS0VrIG11Pi3L0stPSud
	 L+PcsfEjRzXPrm5IeYek6WR72uv5ctH2v7n9JOT0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220620121113eucas1p2cda44ef540de248bbcf8069c25523747~6UwBBASA11999919999eucas1p26;
	Mon, 20 Jun 2022 12:11:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id BF.0D.10067.1E360B26; Mon, 20
	Jun 2022 13:11:13 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20220620121113eucas1p1905756d7a2c84f82b215eaa87544d644~6UwAlVfbP2876928769eucas1p1H;
	Mon, 20 Jun 2022 12:11:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220620121113eusmtrp1e0a193580cfcd230e515b2bde19a6b71~6UwAkrXKe0057200572eusmtrp1U;
	Mon, 20 Jun 2022 12:11:13 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-3f-62b063e1ac4c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 2E.37.09095.0E360B26; Mon, 20
	Jun 2022 13:11:12 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220620121112eusmtip2b7f2c1c47d16fecdb79e9c8d8b63ce34~6UwAaSk5r2504225042eusmtip2T;
	Mon, 20 Jun 2022 12:11:12 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 20 Jun 2022 13:11:12 +0100
From: Joel Granados <j.granados@samsung.com>
To: <hch@lst.de>, <kbusch@kernel.org>
CC: <linux-nvme@lists.infradead.org>, <joshi.k@samsung.com>,
	<gost.dev@samsung.com>, Joel Granados <j.granados@samsung.com>
Subject: [PATCH v2] nvme: Fix CRMS masks for TP4084 - Time-to-ready
Date: Mon, 20 Jun 2022 14:08:42 +0200
Message-ID: <20220620120842.829292-1-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsWy7djP87oPkzckGUzaJmexcvVRJotJh64x
	Wsxf9pTdgdlj06pONo/NS+o9dt9sYAtgjuKySUnNySxLLdK3S+DKONX1m6Wgia3i+HmnBsYf
	LF2MnBwSAiYSd+ZvBLK5OIQEVjBKPF4xiw3C+cIocfPWDCjnM6PEvhmPmWFabh7YzQqRWM4o
	cbj7DjNc1ZWP55ggnM2MErceb2YFaWET0JE4/wakioNDREBVYl+LLUiYWaBWYvat00wgYWEB
	Z4muLlmQMAtQxcrbLWD38QrYSDScPwp1q7xE2/XpjBBxQYmTM5+wQIyRl2jeOpsZwpaQOPji
	BdShihJb5nxnhbBrJfY2H2AHOU1CYCGHxL4fL6CGukgsmnCVDcIWlnh1fAs7hC0jcXpyD1RN
	tsTOKbughhZIzDo5lQ3kZgkBa4m+MzkQpqPEuQ/5ECafxI23ghDX8ElM2jadGSLMK9HRJgQx
	Q01iR9NWxgmMyrOQ/DILyS+zkPyygJF5FaN4amlxbnpqsVFearlecWJucWleul5yfu4mRmCq
	OP3v+JcdjMtffdQ7xMjEwXiIUYKDWUmE14Z7Q5IQb0piZVVqUX58UWlOavEhRmkOFiVx3uTM
	DYlCAumJJanZqakFqUUwWSYOTqkGJiXHRWavWD8yr9lRvGFBYNPts/y2UTvE7k4LNE3ec/it
	1z/R+CMzy058N99VUvTwt3FG9iuD83dff7Nq1rR26c+1Pb3k+4VDikY6or7Mc1x/B6960XJl
	7/WWUG3N2wv9Li1zPibPJDcvtu4Kj8e27ZwXn3M841o5o8S6qdq5dtfabiP9C9nSrzrbOJI5
	UngknvxT/XMsQtcz5kOAseJNp6xok3T1D0Ze3xL1LGOm8gQKWl55wrN25vNNv5dwaV7QYjrU
	KhFpLrsqXqtRdoGHVJxSEk84z/a3mUcObne9v/qtyh+TT2djHr7qsymwmPvV6Ojr381yDw4Z
	7wla4L2hviZKOyw+rMRg8kSpHIdQJZbijERDLeai4kQAlQtSnoQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42I5/e/4Pd0HyRuSDG6/s7FYufook8WkQ9cY
	LeYve8ruwOyxaVUnm8fmJfUeu282sAUwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hka
	m8daGZkq6dvZpKTmZJalFunbJehlnOr6zVLQxFZx/LxTA+MPli5GTg4JAROJmwd2s3YxcnEI
	CSxllDh/8TsbREJG4tOVj+wQtrDEn2tdbBBFHxkl+tduYIRwNjNKbD72BayDTUBH4vybO8xd
	jBwcIgKqEvtabEHCzAK1ErNvnWYCCQsLOEt0dcmChFmAKlbebgE7glfARqLh/FGog+Ql2q5P
	Z4SIC0qcnPmEBWKMvETz1tnMELaExMEXL5gh6hUltsz5zgph10p0vjrNNoFRaBaS9llI2mch
	aV/AyLyKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMDq2Hfu5eQfjvFcf9Q4xMnEwHmKU4GBW
	EuG14d6QJMSbklhZlVqUH19UmpNafIjRFOificxSosn5wPjMK4k3NDMwNTQxszQwtTQzVhLn
	9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpgsrWfsTlEenF34im3Q0uMzsk+Dr4lJqvuutw2+OXC
	I+m5jvfi42YW5LzdtNDp+90286hr2VWNqzy1593ddWpvnKz7sll51tMOtdzU3WCzN1mqJT4m
	flbswvbTp295SDWk8XllpT4KVG/pUJzhknN+u+CSee8FbG6d+e0hsX9DWLlArqLblqJH5gqN
	DCV37RXuPk45YJicaxi/r143fI/wVIX5dqwVYi2z+Oz7lRUD40xY0u/FbDy03+51y1yfw7fP
	Rdbkci2/l6X27XH5oWvbtbz279Ras0uR60bvt6NG7JVslf3bHDeEHt8+3enLAccS0898mjz6
	dVb2bj4e7jdm8vuesWm+xeO9+H+n9h0lluKMREMt5qLiRAASO80tFwMAAA==
X-CMS-MailID: 20220620121113eucas1p1905756d7a2c84f82b215eaa87544d644
X-Msg-Generator: CA
X-RootMTR: 20220620121113eucas1p1905756d7a2c84f82b215eaa87544d644
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220620121113eucas1p1905756d7a2c84f82b215eaa87544d644
References: <CGME20220620121113eucas1p1905756d7a2c84f82b215eaa87544d644@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220620_051116_985258_D4F5A2B6 
X-CRM114-Status: GOOD (  12.74  )
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

Adjust the values of NVME_CAP_CRMS_CRIMS and NVME_CAP_CRMS_CRWMS masks as
they are different from the ones in TP4084 - Time-to-ready.

Fixes: 354201c53e61 ("nvme: add support for TP4084 - Time-to-Ready Enhancements").

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 include/linux/nvme.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 29ec3e3481ff..bbe8b03e7452 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -233,8 +233,8 @@ enum {
 };
 
 enum {
-	NVME_CAP_CRMS_CRIMS	= 1ULL << 59,
-	NVME_CAP_CRMS_CRWMS	= 1ULL << 60,
+	NVME_CAP_CRMS_CRIMS	= 1ULL << 60,
+	NVME_CAP_CRMS_CRWMS	= 1ULL << 59,
 };
 
 struct nvme_id_power_state {
-- 
2.30.2


