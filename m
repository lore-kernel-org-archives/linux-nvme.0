Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08853CD342C
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2026 13:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MXAFXLpub4Ios579vCna30mD+3oUTadeDnGvgFJZ4dA=; b=gUVwgbTbVgGZRluDx11zn3Zi67
	YjC2TA1t55ZHkoXwlvDpi/d5U1Qu1ON+zDxGUXPMCJsn6/nLkRP1mFIEYoXL4rQYmGB0tiRfT4g/R
	8NrvpmzRqTwDyDb0g80LlYm1/1+CWf33lecKA4Dkf31/ABYvOP55wB9CVzQCKv1Vkvzv6/nMIHoP3
	r8n7cKaYNODS5oVsno8FxgI9IV7SNXRdpwqlJXsARI2sKul3xvgK8pdkq8bPUhwvjnJ0Bj0k9BowA
	QxobBj9D9I5c5TzV4INm6AK936P6WhTy7tnRFk52974RjPncUq+4k8f4aSxtpTrAhnpu2I8Yj53B3
	IMSFOAUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKc9b-00000000s7v-1hDa;
	Wed, 06 May 2026 13:19:07 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKc9V-00000000s7I-2qHM
	for linux-nvme@lists.infradead.org;
	Wed, 06 May 2026 13:19:01 +0000
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6466SZCp1884765
	for <linux-nvme@lists.infradead.org>; Wed, 6 May 2026 06:19:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=MXAFXLpub4Ios579vC
	na30mD+3oUTadeDnGvgFJZ4dA=; b=b1ZP1jA2QH9K96k+2Q3qyyKiB6lgV6HfhI
	5TQEmZYvZEm+5q7xGy0PLFrIwEU8V0vcEk9L43S0LZqgyknJdCtz1JmNc04qe3Td
	EZtq+kG/KIw+RmlQoNv77MfaxznHG0ccIUmsz6JEGfgiUU4/izzP4HXehU/zJBxS
	mjBPIqiSSEbdx6wWP/ArvmUUQ5BjLLNJW3b3qw5SqBB60sndk/r6VrtancgQ59Se
	szr1CU8vBkfsQS0d7ny/t9mDX0A6A+hCDPvCXca0O9IVBTcxrnOF8UAO4goGfq3O
	2OT1+EI7A4yfNmuyyy/Zqsm1rKmVwWji27XBhpezTfl5JnE95c5g==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e00d91xu5-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 06 May 2026 06:19:00 -0700 (PDT)
Received: from twshared5087.02.snb2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Wed, 6 May 2026 13:18:59 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 5814116D00081; Wed,  6 May 2026 06:18:41 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <me@alancui.cc>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: make prp passthrough usage less scary
Date: Wed, 6 May 2026 06:18:39 -0700
Message-ID: <20260506131839.2364791-1-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ydYp72NsPu5BfCCfN9Leb1GXF01Dx0fd
X-Proofpoint-GUID: ydYp72NsPu5BfCCfN9Leb1GXF01Dx0fd
X-Authority-Analysis: v=2.4 cv=G+4s1dk5 c=1 sm=1 tr=0 ts=69fb3fc4 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=4h92JMTCafKA-fb_NiOh:22 a=VwQbUJbxAAAA:8 a=9OkeFd18GadU2AKlsWcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEzMSBTYWx0ZWRfX16wXo1JSMc2Y
 1R5EjCjYZSXngIePCZ5EZ9iZZnHHfkfFfljvJVTUk66awqqC0uedJ6eC27jrmtktL4gxZSl4o0c
 GNtrKrLZGv3B9ZCjFkjIrYuG6fRj6fMGOMnZ/tyxuxx35x98hO3nThP/zQFJhp1r4N+R8pcls0Q
 v4XjQ1vOC2lyc7TAGryU2MF7ouyAghPFn47eS2Ab2Wtv4CUhaJdCcuY54Aa6A0KzQaupz3QmtqT
 EyKCdO85gvitQEojVyYtGCt28rLXtwFtX+ibCs1uOC/hu45wf2tQsndPB2ZMTz9+ecvh9lDFqFK
 qpOtD5wCarT931BdjBFbaPCKR6gS34bczdGbe2pPN2Ibf5+qi2R4r5hoLLXwptV7ItI/u6fTSK3
 9iPBobuBVME8hrx3mkBTuWLI54FysDX3o+4ubok5+nXOEQIoZ9L0eVHBvf2iUx5nMYk0OTqElLT
 yzpFWbepWN/yc7l+ovQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_061901_816988_651C6256 
X-CRM114-Status: GOOD (  12.70  )
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

The warning is a bit alarming, and it only prints for the very first
non-sgl capable device that receives a passthrough command. Just log an
informational message on initial discovery for every device.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c  |  4 ++++
 drivers/nvme/host/ioctl.c | 12 ++----------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dc388e24caade..1e7e42b43aa3f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3749,6 +3749,10 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, =
bool was_suspended)
 		ret =3D nvme_hwmon_init(ctrl);
 		if (ret =3D=3D -EINTR)
 			return ret;
+
+		if (!nvme_ctrl_sgl_supported(ctrl))
+			dev_info(ctrl->device,
+				"passthrough uses implicit buffer lengths\n");
 	}
=20
 	clear_bit(NVME_CTRL_DIRTY_CAPABILITY, &ctrl->flags);
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 9597a87cf05dc..39d6e69cbbe72 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -125,16 +125,8 @@ static int nvme_map_user_request(struct request *req=
, u64 ubuffer,
 	struct bio *bio =3D NULL;
 	int ret;
=20
-	if (!nvme_ctrl_sgl_supported(ctrl))
-		dev_warn_once(ctrl->device, "using unchecked data buffer\n");
-	if (has_metadata) {
-		if (!supports_metadata)
-			return -EINVAL;
-
-		if (!nvme_ctrl_meta_sgl_supported(ctrl))
-			dev_warn_once(ctrl->device,
-				      "using unchecked metadata buffer\n");
-	}
+	if (has_metadata && !supports_metadata)
+		return -EINVAL;
=20
 	if (iter)
 		ret =3D blk_rq_map_user_iov(q, req, NULL, iter, GFP_KERNEL);
--=20
2.52.0


