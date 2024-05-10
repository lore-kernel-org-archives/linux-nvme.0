Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FA2C41513
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 14:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pJiOW9sE/PxdcId7oxzz3zrqGCgVWqbLvPZXlyFVYsk=; b=Tskx1toO1NQQ4uAx2CNngrygzC
	KUf/clZ3z+b2VSjBKdYdbscEJyDw8DbbfZnqwLHJ1TApkCDP0aD/xOf4/E9e2D+bBUShuvryqhDgw
	C7XfEVghLJNg3sAKehWpJ289kZLBjZrudSAT9ZVsRFTxX50WO621Wgpjra713ZczgDNZH5tX0BmjW
	5q1shr0hueoWKcOrKvusfTQ7Z+vei+WnXAZhG1GAKAdXd0Tb4t0jMvENbU2H1kPKJzF9K1X2g3m3z
	XX2rNgUOgga/TrrRGtQ1M58gcRuI9zigC6ZoqhBtcSxn3tBgHEnf4MEAfFebv1FIv7L5e4OKwTNVF
	ZKvbYV7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5R28-00000005WMZ-1rRT;
	Fri, 10 May 2024 14:15:36 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5R20-00000005WHO-36Js
	for linux-nvme@lists.infradead.org;
	Fri, 10 May 2024 14:15:34 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44A0PrmT000493
	for <linux-nvme@lists.infradead.org>; Fri, 10 May 2024 07:15:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=pJiOW9sE/PxdcId7oxzz3zrqGCgVWqbLvPZXlyFVYsk=;
 b=ZZwFCyJVSVrD2aR2quQHmmPAwgEWW0b524hLtu6Tt2VbokYnsqwbYO8Nb0MT6r8k8R6a
 GEYLQJFDdEo/jk/5lvPSKt01sUBenVEQ9N7rgJ4Nk78shtW2sIc/RhmEd2AsI66cjj0q
 1lkCJVNTAPZ7t9YBslQuRu4nQitSpAmjxuLTq9+r3Rc7XoH/i0wFjXM3ZKOkCzwwtJs9
 PEBeIZQfPi40NA+bcm2T7TVTr3UMKGI1EB2jhxkuAMzIGVli/IXs/W4/17Pr6QGt6y8j
 uKwv8hWQ7obg6jgxHpheq7IVXsLQ1Od10kgfnP5qvzeQDdmuiddgQ61RU/3ZboexRMAx VA== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3y16pqbjev-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 10 May 2024 07:15:21 -0700
Received: from twshared19845.02.ash8.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 07:15:09 -0700
Received: by devbig032.nao3.facebook.com (Postfix, from userid 544533)
	id 7BF682633F51; Fri, 10 May 2024 07:15:06 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <hch@lst.de>, <tglx@linutronix.de>, <ming.lei@redhat.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH 1/2] genirq/affinity: remove rsvd check against minvec
Date: Fri, 10 May 2024 07:14:58 -0700
Message-ID: <20240510141459.3207725-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: xZgj6SYZAo1dAXU-z73ZLH1-xfm-Cr72
X-Proofpoint-ORIG-GUID: xZgj6SYZAo1dAXU-z73ZLH1-xfm-Cr72
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_10,2024-05-10_02,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_071529_112858_575AFC26 
X-CRM114-Status: GOOD (  14.69  )
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

The reserved vectors are just the desired vectors that don't need to be
managed.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 kernel/irq/affinity.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 44a4eba80315c..74b7cccb51a16 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -113,9 +113,6 @@ unsigned int irq_calc_affinity_vectors(unsigned int m=
invec, unsigned int maxvec,
 	unsigned int resv =3D affd->pre_vectors + affd->post_vectors;
 	unsigned int set_vecs;
=20
-	if (resv > minvec)
-		return 0;
-
 	if (affd->calc_sets) {
 		set_vecs =3D maxvec - resv;
 	} else {
--=20
2.43.0


