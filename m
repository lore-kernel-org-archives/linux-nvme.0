Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB7DCEE352
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2024 21:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/9T3prEw2eg3FZXji49EKOE/0P0DewDB8bXWLmJtdII=; b=YeLUdyjKx1uEa6NbwrQGvfaPgG
	mGUxB/tARwmthf4H9/NLzenO1JygqEkKJfMXbklSuyA5sUV4JDHe7QyoN43OcbF6ukxSH2wocErnu
	XdWaWhaUWiScv6rus2KtgFYcK0l9Y4hKnr4fGtTvQwuttJQWQ70D1S3HB2Gcxoj+b6GnMuEuHKMAq
	hxCr6P9qkFLxbkKttl4ENHBQ8I+mAEUqmEPkiPY0aqJlDfPoVL8oBLmjNxNnypZ+YRttB1YeuJH1y
	kp4OaY7Y50uV5ZupcHHmIHEiOs7/w+qE7N0Jp6Jj9i5xmykdACsIwoKuBi77rtCapRGS04pEJoPIj
	b/ME+qbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syeQR-0000000AoUY-1Bwc;
	Wed, 09 Oct 2024 21:40:55 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syeQO-0000000AoSx-2Mvc
	for linux-nvme@lists.infradead.org;
	Wed, 09 Oct 2024 21:40:53 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499KbZpL017430
	for <linux-nvme@lists.infradead.org>; Wed, 9 Oct 2024 14:40:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=/9T3prEw2eg3FZXji4
	9EKOE/0P0DewDB8bXWLmJtdII=; b=YVS7LLePsfq9fTmZNhmRu89dAOCILDUq8R
	H4UnW7IAIN1jj9imLiIUwMkPuBNP36fX0AyKvUnWusYEYmKrZNhbYOsT/n1IyPnu
	nWy/qHmz/Co+8b2C2+OwHHSCPELBeOPaw49dbFv9IsXtaZ5U4Z/SKtL5BV9s5kkd
	o91c48uHAdJ7Ev6BSeooVCaDdwi+4zmGUSUA1XUwNg2rHpNxNBLipX1snHrZJFkY
	7wAh4OyTzyCDqKAzHSHMmoIb9NAALLbe1F0nf8AZ7+cofDiceXIDiJal6/BGnbE6
	oceg3faHMCi5cE0oDPCWBMrJGSlwkuY/6go7eWjxifUrYnVz/8kQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4232yxbcnm-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 09 Oct 2024 14:40:49 -0700 (PDT)
Received: from twshared8421.02.ash9.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 9 Oct 2024 21:40:43 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 39B2213FCD3D4; Wed,  9 Oct 2024 14:40:36 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: fix cns check
Date: Wed, 9 Oct 2024 14:40:35 -0700
Message-ID: <20241009214035.3851406-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: __uqxNAIiyp30d22lozMkdfgtceW-opS
X-Proofpoint-ORIG-GUID: __uqxNAIiyp30d22lozMkdfgtceW-opS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_144052_748106_9DB93A1C 
X-CRM114-Status: GOOD (  11.90  )
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

The 1.1 spec defined two bits for the Identify CNS field, so such an
implementation wouldn't be expected to check the full byte for a
decoding it. Provide a different helper function to make these
decisions as the existing check only separates the single-bit from the
two-bit spec versions.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 10eca7660ca7c..0f7ff5f417f17 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1412,6 +1412,11 @@ static bool nvme_ctrl_limited_cns(struct nvme_ctrl=
 *ctrl)
 	return ctrl->vs < NVME_VS(1, 1, 0);
 }
=20
+static bool nvme_ctrl_byte_cns(struct nvme_ctrl *ctrl)
+{
+	return ctrl->vs >=3D NVME_VS(1, 2, 0);
+}
+
 static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl=
 **id)
 {
 	struct nvme_command c =3D { };
@@ -3113,7 +3118,7 @@ static int nvme_init_non_mdts_limits(struct nvme_ct=
rl *ctrl)
 		ctrl->max_zeroes_sectors =3D 0;
=20
 	if (ctrl->subsys->subtype !=3D NVME_NQN_NVME ||
-	    nvme_ctrl_limited_cns(ctrl) ||
+	    !nvme_ctrl_byte_cns(ctrl) ||
 	    test_bit(NVME_CTRL_SKIP_ID_CNS_CS, &ctrl->flags))
 		return 0;
=20
--=20
2.43.5


