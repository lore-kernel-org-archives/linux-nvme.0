Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDB8C0218A
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 15:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wbaAL0It0bbVPPnRkfLwoBwS3rvgbeDuNp3PzjPDJAU=; b=Wa7ge3YGeQEaPbo1fx3PFSEuhq
	9SfKfgFvNQGDlGH+JdIgRG1vvnqFv7QodZYIyZqPgHXTBTQpYTMrlxEh1jrwcntYy+FV69iTWFqTh
	4hkYDoewLvhVSp1Da8n57lWYoQA3UptPC3NSKBfHcvA86BznG0cQqrTT5ZEYC31weSZUFymVFFL7t
	tuAg3GFTVVDxpyPmTpUuVXuiyfIaq8M1Dj0pj/BqaU0OXbbDyxENmr23saClbKbmDcNEgcNz4KnPq
	yR80U8bWjYwVH10WQl54m+esBmQV6RnQhdQnRlrA35II4qoubdcwz4GNMpMYrxEW97cQIrF5R+AvW
	TqBYHb4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcnT8-000000058Lq-39Dy;
	Tue, 28 Jan 2025 15:25:38 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcnT5-000000058LH-3pdc
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 15:25:37 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SEMr0O006417
	for <linux-nvme@lists.infradead.org>; Tue, 28 Jan 2025 07:25:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=wbaAL0It0bbVPPnRkf
	LwoBwS3rvgbeDuNp3PzjPDJAU=; b=K3C1k/WQ4XTQ4L5MHzUQ3/cjUACeyxLhvy
	lqN185FpxH0QqKlHDIS9PqP93QbBjIIubGcM1ALcpPdqpqWvw9S/qd5MkRzU/+la
	NO9raQPTZHuYv/F04W9BMSd7EGX9lTxbcD46iwKKaztVZCBjAKk8jcRiumP9gHcc
	BxE1lBqNM9UBEBBg57pa4UG5dbcnrwVmvb2G3aQb5m+ivaaN6XhlxAPdrtIke2bj
	9fEk1aSP5Q6KapJcNk6+hjLEs46QLXVQc8MkfCRz4UdldvtLTZGOkpKDrgXxbBCW
	wjmZaMExVVJbGlTHWqqxr0UtydbnCSS7lkki4l55UakmN6T6HiTA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 44ex30sd91-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 28 Jan 2025 07:25:33 -0800 (PST)
Received: from twshared40462.17.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 28 Jan 2025 15:25:32 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 203B217627B57; Tue, 28 Jan 2025 07:25:15 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <hare@suse.de>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH] nvme: make nvme_tls_attrs_group static
Date: Tue, 28 Jan 2025 07:25:12 -0800
Message-ID: <20250128152512.771115-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: MY8ZHxQIvMIL2o8isiTK0W_KLT8nehjq
X-Proofpoint-GUID: MY8ZHxQIvMIL2o8isiTK0W_KLT8nehjq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_072535_962249_12D16614 
X-CRM114-Status: GOOD (  10.34  )
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

To suppress the compiler "warning: symbol 'nvme_tls_attrs_group' was not
declared. Should it be static?"

Fixes:
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index b68a9e5f1ea39..3a41b9ab0f13c 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -792,7 +792,7 @@ static umode_t nvme_tls_attrs_are_visible(struct kobj=
ect *kobj,
 	return a->mode;
 }
=20
-const struct attribute_group nvme_tls_attrs_group =3D {
+static const struct attribute_group nvme_tls_attrs_group =3D {
 	.attrs		=3D nvme_tls_attrs,
 	.is_visible	=3D nvme_tls_attrs_are_visible,
 };
--=20
2.43.5


