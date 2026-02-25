Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B54FD45EE
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Feb 2026 20:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=E9ks5KZvJBpSppbbHU4im/80CdGcO+Dg2DsnbhT1c7s=; b=yWsUpRZ6F6KD5OwcWalfDB9+CU
	Ri+f3KnSpXQHXZ1sCEsmU6GGeNYwOB5nPNdASc57p+pn0PPj6nQP8nTZJz7cqvzRpdLvLKNWabNuh
	xoQFPTqQYS0cuOxUCIBCIuWCMnpBJDmgSCd/Wg+0ASZWOf1+rNzoCFBHTxvRUQOnx4DiicHRqgEqd
	AeXOdW9EcDMbg1w+Eml1Nq7CRKybfAECQnuRZmkBy8PxfxkD7ffvbKMXAHK1jHrTVfkMgNvd9Kufb
	B1EXkskr/L8s+NRqFMhxT+Z0AarW4y0QqUVWonnLt8pEsYDPKHQ9VZV3+NmBorw67Uby91eNMxeu6
	TXWWKyEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvLNn-00000004qL4-3a7Z;
	Wed, 25 Feb 2026 20:21:19 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvLNl-00000004qKL-3Cje
	for linux-nvme@lists.infradead.org;
	Wed, 25 Feb 2026 20:21:19 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PIowVa1806568
	for <linux-nvme@lists.infradead.org>; Wed, 25 Feb 2026 12:21:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=E9ks5KZvJBpSppbbHU
	4im/80CdGcO+Dg2DsnbhT1c7s=; b=jgQqxXfXQJgmNIRt4hdMtigHt9TgQHKECW
	9j/VYgDT/5n2fS/SntdEvI1GxvAo7lPteMJ0f8V+bTL28O9GgTtncX8ETW2vP3cp
	uSMtNx9a7yw8li9nrzSkxYfh/gdqCd5I+rq1K7LSjJh+G3pTSqzYr0/iH0Q8I4o5
	dlZuCPNGL1TaypzPOwq92QMXUxyyQ+QPx5xl6hsJi8aAnjCnwb6F2FwpY9lvtEkL
	P190BBXIq8CVr5JsD6xbj0MEfxS0LiTe8umnq0sb5/uWJJNDplQn4T57ZI9rUTA8
	YoSuWx/HMzcOSgVS0tgag0EnaaB3U4UAZT8fUxkbg8R+8Uyi7wHQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cj6qhs1f3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 25 Feb 2026 12:21:15 -0800 (PST)
Received: from twshared26368.04.snb1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 25 Feb 2026 20:21:14 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 68D468F4135A; Wed, 25 Feb 2026 12:21:10 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <nilay@linux.ibm.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/2] nvme-multipath: fix leak on try_module_get failure
Date: Wed, 25 Feb 2026 12:21:08 -0800
Message-ID: <20260225202109.447144-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: RLXkeaoCeUwfgmcYDiIBP_p6Ny6kC2pn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE5NCBTYWx0ZWRfXzMoP4Pf5jYis
 8uV5TJKcf2smL6cfutqbLmX7BcY6Kfo8iAo+aZcbwi9MCX/n+QA0fmVIo1UcYz4v3P/Afb8/HBQ
 rsSLYUbKyU8ENKdFBYzwElhDnxho7FSrZGfzBv/+4R7C91ENy35LuU9M3rgWhAD9WPd20E4c1NF
 WRS2a00rFfHY+GueaPxZ5XYuKynqpf3iWNq1elWoYZmKya+L0pu2I+o4bghUxy1XPdoCHx2Xj4S
 neztA+2PpQuiwVByeXXCSQFyOA8/xiX3ASxu8qKeB7kikY6Ib0vCuTmd8n0UXC4w6qi/pukLxgd
 gqO63omQ6/hwEPVo46qngleMOIGl9MPpNoG2RUFBMcqo1mlGE23HGq4zqqtQZeC0AXpZg7GpMBA
 5pqDINYyDim3yyFT8NEJm83dtPyqb8CS2a6wSOVbP/pMR7w6wvW7rhkitUZV+NbnQErvE5/8/ZQ
 hSwYa9pbX0GguBK8BfQ==
X-Authority-Analysis: v=2.4 cv=edMwvrEH c=1 sm=1 tr=0 ts=699f59bb cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=z37yyg1j4Q0jIBrKCm0A:9
X-Proofpoint-GUID: RLXkeaoCeUwfgmcYDiIBP_p6Ny6kC2pn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_03,2026-02-25_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_122117_877535_E11DB94B 
X-CRM114-Status: GOOD (  14.01  )
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

We need to fall back to the synchronous removal if we can't get a
reference on the module needed for the deferred removal.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/multipath.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.=
c
index bfcc5904e6a26..fc6800a9f7f94 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1310,13 +1310,11 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *=
head)
 	if (!list_empty(&head->list))
 		goto out;
=20
-	if (head->delayed_removal_secs) {
-		/*
-		 * Ensure that no one could remove this module while the head
-		 * remove work is pending.
-		 */
-		if (!try_module_get(THIS_MODULE))
-			goto out;
+	/*
+	 * Ensure that no one could remove this module while the head
+	 * remove work is pending.
+	 */
+	if (head->delayed_removal_secs && try_module_get(THIS_MODULE)) {
 		mod_delayed_work(nvme_wq, &head->remove_work,
 				head->delayed_removal_secs * HZ);
 	} else {
--=20
2.47.3


