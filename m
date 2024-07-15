Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B35C3DA45
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jul 2024 06:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=6qyr6lSFH9RlT36XFAKhu2S2p1s9+91F/Ss4vJ53JgY=; b=FTtcTGmwMOy7kLqUUEpslv2GYH
	JrJrGFWgh7ccCVbrJCHhkT3W+XjwX09D1XzlU8TLoHPo/GdLuwUBw52OLyHL0fnV4Kwrsdbo+Tfly
	KiVAvAgzJANoGkIu/i5Epm0y57qQlm3hxRFLe5dG/Jf/qgZPtZ0Ud9LQ9yis4je9eukjR/RAy1QeP
	zu6ODvkFxYYr3tKrg1DYTBrOIQy81ji3m+0cIpg9gtfFSK319sKvxN6HXUL/eDnt9TfgjC3c5irLm
	+NMFuGwLEuReLWHjYr/Z/kHcSmzr4N8CvFq0pEq42ptgL5T3+VHC/lKVWi2spqIet8xsvXqk3PpiG
	MyoRvpfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTFYP-000000065Et-2SeK;
	Mon, 15 Jul 2024 06:51:21 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTFYI-000000065DW-35cK
	for linux-nvme@lists.infradead.org;
	Mon, 15 Jul 2024 06:51:17 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240715065107epoutp01cc2b32bf380a822fce1ef827c1dcd889~iUEWhgnBL2019120191epoutp01G
	for <linux-nvme@lists.infradead.org>; Mon, 15 Jul 2024 06:51:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240715065107epoutp01cc2b32bf380a822fce1ef827c1dcd889~iUEWhgnBL2019120191epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721026267;
	bh=6qyr6lSFH9RlT36XFAKhu2S2p1s9+91F/Ss4vJ53JgY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=f6gnX52RsG2DmDZD8JNK7CDnAIlPmknyDFiiN4C6jRsPnKpjzvV9mhcdMezVcESdG
	 SRtq/6d0CffYoIYcMkw0jLhsuoMwAB00uwlv9xLv6wSfHD7NO6X4Swi1ZO4mT+p+ZG
	 CBp4k1X8LtXv6ehaVk6cMR5IMX8lQnGWCwMew7Yg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240715065107epcas5p4ad3459309ea8f0a2042ebebf5ba88c73~iUEWE4OAd3185431854epcas5p4t;
	Mon, 15 Jul 2024 06:51:07 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4WMtBx5y6wz4x9Pv; Mon, 15 Jul
	2024 06:51:05 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B5.06.19174.8D6C4966; Mon, 15 Jul 2024 15:51:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240715063116epcas5p1d5653ed4b1f71c1a4542f9315a62b6db~iTzBjCrLD1087110871epcas5p1a;
	Mon, 15 Jul 2024 06:31:16 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240715063116epsmtrp18cdac57a2cb3e22da21c869d8f2a924f~iTzBh7TfO1916119161epsmtrp1P;
	Mon, 15 Jul 2024 06:31:16 +0000 (GMT)
X-AuditID: b6c32a50-87fff70000004ae6-eb-6694c6d81daf
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	37.8B.07412.432C4966; Mon, 15 Jul 2024 15:31:16 +0900 (KST)
Received: from localhost.sa.corp.samsungelectronics.net (unknown
	[107.99.41.223]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240715063115epsmtip10d175b868571809107921356838fddd8~iTy-_4bzi0123301233epsmtip1U;
	Mon, 15 Jul 2024 06:31:15 +0000 (GMT)
From: francis.p@samsung.com
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, anshul@samsung.com,
	jg123.choi@samsung.com, prakash.bv@samsung.com, d.palani@samsung.com,
	sathya.m@samsung.com, Francis Pravin <francis.p@samsung.com>
Subject: [PATCH] nvme-core: choose PIF from QPIF if QPIFS supports and PIF
 is QTYPE
Date: Mon, 15 Jul 2024 06:31:57 +0530
Message-ID: <20240715010157.2909958-1-francis.p@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmhu6NY1PSDFZ1K1n8nj6F1eL/nmNs
	Fm+/PmCzOLZoC7PFytVHmSyWzte3mHToGqPF/GVP2S3uzehit1j3+j2LxdbLC9gduD0mNr9j
	9zh/byOLx6ZVnWwem5fUe+y+2cDm0bdlFWMAW1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7yp
	mYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QeUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XU
	gpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7Iw1JzpYCu4IV3R+Pc3WwLhNoIuRk0NCwETi
	wI1W5i5GLg4hgT2MEj2beqGcT4wSt68dYoVwvjFKnDn3gg2m5dXLx4wQib2MEr/2vmWDcNqY
	JN4/u84MUsUmIC2xaclnsA4RAUeJVyuegxUxC+xjlDi07TlYQlggVGLJrotgDSwCqhJ3H38C
	i/MK2Ej8+7SJEWKdvMTiHcuZIeKCEidnPmEBsZmB4s1bZ4MdKyHwk13i5bmVzBANLhJzX59m
	h7CFJV4d3wJlS0m87G+DsvMlXu1+zgRhV0hs33UbyraXuLjnL5DNAbRAU2L9Ln2IsKzE1FPr
	mCD28kn0/n4CVc4rsWMejK0ssenJelYIW1KiufEO1CoPidN998BuFhKIldjw8wfzBEb5WUje
	mYXknVkImxcwMq9ilEotKM5NT002LTDUzUsth8dtcn7uJkZwQtUK2MG4esNfvUOMTByMhxgl
	OJiVRHhXskxME+JNSaysSi3Kjy8qzUktPsRoCgzkicxSosn5wJSeVxJvaGJpYGJmZmZiaWxm
	qCTO+7p1boqQQHpiSWp2ampBahFMHxMHp1QDk+7XbPUvTDsPOTLtMnl5vjC0V/nzElM/xqum
	UqlFNtvUNVr+pOWJljdeb1srvMxB7tRUE7vNpStD+8pMNXcuN1WPMpFlXbRL+29svllGhXhH
	/PHzOYvfuRW2i5+dbtqbE9kRlTFl1ldGQ6e4cGbVKIEXGi9CNS8unCR5+mWll3jS5tRO/uSJ
	810OfxArLpKpmiL5yOvN4xnPTF64Gpv4iwlIX7ZX3bv7Ts9C+zfffF4KKy3pkFOUbZfUWLEq
	RPCbf+LzAL+/SkzGbvvfZgS4myjmHJKctfr53pq3U28nHTRhSdorWnj554zXzN+NTm89NWez
	oMD/z/PPVC5cODHl6Mr3XklzM31nnT501G+FEktxRqKhFnNRcSIAaoCKiTEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWy7bCSnK7JoSlpBlOf6lr8nj6F1eL/nmNs
	Fm+/PmCzOLZoC7PFytVHmSyWzte3mHToGqPF/GVP2S3uzehit1j3+j2LxdbLC9gduD0mNr9j
	9zh/byOLx6ZVnWwem5fUe+y+2cDm0bdlFWMAWxSXTUpqTmZZapG+XQJXxpoTHSwFd4QrOr+e
	Zmtg3CbQxcjJISFgIvHq5WPGLkYuDiGB3YwSXz4dY4ZISEocm7aIHcIWllj57zk7RFELk8Sa
	hwcYQRJsAtISm5Z8ZgOxRQTcJY6+bGACKWIWOMYosXbNSSaQhLBAsMSyFXPAGlgEVCXuPv4E
	1sArYCPx79MmRogN8hKLdyxnhogLSpyc+YQFxGYGijdvnc08gZFvFpLULCSpBYxMqxglUwuK
	c9Nzkw0LDPNSy/WKE3OLS/PS9ZLzczcxggNbS2MH4735//QOMTJxMB5ilOBgVhLhXckyMU2I
	NyWxsiq1KD++qDQntfgQozQHi5I4r+GM2SlCAumJJanZqakFqUUwWSYOTqkGpnj5gvOFTZvn
	XTvOW/Nv4q60jJgeOf0D7XZlG1c931PyffMvl+N5YhtC+7kfVzZ9llh+YsvfR/bx9Y52D/UX
	2qVtPzlHKvR76ctIu11Xl/x0kn7zUqNsRuXR7yze33f8zv/+eduTu+mxC6wKzvz9sUtG/bPP
	9rlzJ0Tv4dH5saf8wfM+1h2Pd13m/aLQ+O/kd+eZ2TIHnkXyvMs+vyClYHvI+87Ano92zxbJ
	Pf4YLR2Vs+XC0yZv882rA0+/c58xNf/g/On/+bNuxzvbBWWX2tw3Zd7bvUnMU3SXDpfxFLUp
	u0Q5cr/3fXjzSZzz2Yp7pXX/xf7L9jUIyM75vIbndtyy7TxePJznJq4w/Gkz72+rEktxRqKh
	FnNRcSIAilH0x9sCAAA=
X-CMS-MailID: 20240715063116epcas5p1d5653ed4b1f71c1a4542f9315a62b6db
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240715063116epcas5p1d5653ed4b1f71c1a4542f9315a62b6db
References: <CGME20240715063116epcas5p1d5653ed4b1f71c1a4542f9315a62b6db@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240714_235116_263181_1CFDD635 
X-CRM114-Status: GOOD (  19.81  )
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

From: Francis Pravin <francis.p@samsung.com>

As per TP4141a:
"If the Qualified Protection Information Format Support(QPIFS) bit is
set to 1 and the Protection Information Format(PIF) field is set to 11b
(i.e., Qualified Type), then the pif is as defined in the Qualified
Protection Information Format (QPIF) field."
So, choose PIF from QPIF if QPIFS supports and PIF is QTYPE.

Signed-off-by: Francis Pravin <francis.p@samsung.com>
---
 drivers/nvme/host/core.c | 8 +++++++-
 include/linux/nvme.h     | 9 +++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 782090ce0bc1..205174d45fac 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1844,12 +1844,18 @@ static void nvme_configure_pi_elbas(struct nvme_ns_head *head,
 		struct nvme_id_ns *id, struct nvme_id_ns_nvm *nvm)
 {
 	u32 elbaf = le32_to_cpu(nvm->elbaf[nvme_lbaf_index(id->flbas)]);
+	u8 guard_type;
 
 	/* no support for storage tag formats right now */
 	if (nvme_elbaf_sts(elbaf))
 		return;
 
-	head->guard_type = nvme_elbaf_guard_type(elbaf);
+	guard_type = nvme_elbaf_guard_type(elbaf);
+	if ((nvm->pic & NVME_ID_NS_NVM_QPIFS) &&
+	     guard_type == NVME_NVM_NS_QTYPE_GUARD)
+		guard_type = nvme_elbaf_qualified_guard_type(elbaf);
+
+	head->guard_type = guard_type;
 	switch (head->guard_type) {
 	case NVME_NVM_NS_64B_GUARD:
 		head->pi_size = sizeof(struct crc64_pi_tuple);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index c693ac344ec0..857fde303c36 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -482,6 +482,9 @@ enum {
 	NVME_ID_NS_NVM_STS_MASK		= 0x7f,
 	NVME_ID_NS_NVM_GUARD_SHIFT	= 7,
 	NVME_ID_NS_NVM_GUARD_MASK	= 0x3,
+	NVME_ID_NS_NVM_QPIF_SHIFT	= 9,
+	NVME_ID_NS_NVM_QPIF_MASK	= 0xf,
+	NVME_ID_NS_NVM_QPIFS		= 1 << 3,
 };
 
 static inline __u8 nvme_elbaf_sts(__u32 elbaf)
@@ -494,6 +497,11 @@ static inline __u8 nvme_elbaf_guard_type(__u32 elbaf)
 	return (elbaf >> NVME_ID_NS_NVM_GUARD_SHIFT) & NVME_ID_NS_NVM_GUARD_MASK;
 }
 
+static inline __u8 nvme_elbaf_qualified_guard_type(__u32 elbaf)
+{
+	return (elbaf >> NVME_ID_NS_NVM_QPIF_SHIFT) & NVME_ID_NS_NVM_QPIF_MASK;
+}
+
 struct nvme_id_ctrl_nvm {
 	__u8	vsl;
 	__u8	wzsl;
@@ -573,6 +581,7 @@ enum {
 	NVME_NVM_NS_16B_GUARD	= 0,
 	NVME_NVM_NS_32B_GUARD	= 1,
 	NVME_NVM_NS_64B_GUARD	= 2,
+	NVME_NVM_NS_QTYPE_GUARD	= 3,
 };
 
 static inline __u8 nvme_lbaf_index(__u8 flbas)
-- 
2.43.5


