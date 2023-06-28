Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C58EB64DA
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jun 2023 14:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=h7EPJZtcH3Wb3Q96jwWe0xv3BdyES9EadVSxl+qh2c8=; b=r4XOhTgeFWpjeSG/TPv9TXSfJ6
	yhzkoyTH4SLVnxj21CBnfeCZVr/UJYde2H0jz+TLGUq09YWVBqQv7BMbfr99kXp4/JpYeQXyDkFdQ
	bcquqXcQ3NXzq7eY+VmNqDfPyELo0kw7uo644e2zCj+CStwMEUqEnjGihzvcunEC5phASQHxZc6B2
	Zug51SV3O85jUpaqY5mUhOyvwLCy6HL3Eg1k0Y0p3P6NizvisXwRkOCJJNXgN5TWs9AUauU3GBjRt
	Tr4EqNwwiwpVOI48ZiyBi/kkJMFlvxekbwjYKNWqEyrHHPcyUq3h8gRxSFzRWXVKR9mUmoqKOK6yn
	45CccNYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEWco-00FuoP-3C;
	Wed, 28 Jun 2023 14:58:30 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEWcm-00Fun3-0S
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jun 2023 14:58:29 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SA6oxO031484
	for <linux-nvme@lists.infradead.org>; Wed, 28 Jun 2023 07:58:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=h7EPJZtcH3Wb3Q96jwWe0xv3BdyES9EadVSxl+qh2c8=;
 b=SNTTq8o0tUrxO9JRTk+LoXsQgwGQoBK4HAM6RYyjxmU/aPcSjfsbuYe3f1ki3/See4v4
 jMiywIQkDnkP+/H7xDSqk4PgQF7bhJAbD9AJmdXDgippPrLitapvRBLEXhO0ws1eWaZ7
 MLVTKLmwc9lMbmFxSvV5i1CxmyV8hRWJi6tmEJf4UnOxjiOFaB53qRePKYhtYET9Yc25
 7v3PPcJu37Awc7asRmndVmrRNh3R3ueQQnNvmsiGtS9deiFZx/jtaydPvQ0tMILi9vAV
 ggqvfu8q7GwswGq2Yu9nmMkDKa+Jb80lvVWEn/JU+s2W/B/EkMyhHfBnuvA9ou31frjD mQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rfnm1q5rn-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 28 Jun 2023 07:58:26 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 28 Jun 2023 07:58:25 -0700
Received: from twshared25760.37.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 28 Jun 2023 07:58:24 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 846EE1AC9AB3A; Wed, 28 Jun 2023 07:58:14 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>,
        <ming.lei@redhat.com>
CC: <brookxu.cn@gmail.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/3] nvme: ensure unquiesce on teardown
Date: Wed, 28 Jun 2023 07:58:12 -0700
Message-ID: <20230628145814.1068653-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: elNErZFNVbAsF6qIa3_Zo7kdqmaCLyM9
X-Proofpoint-ORIG-GUID: elNErZFNVbAsF6qIa3_Zo7kdqmaCLyM9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_10,2023-06-27_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_075828_304465_2AC2D219 
X-CRM114-Status: GOOD (  14.29  )
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

The reset work is called on quiesced IO queues, so ensure these are
unquiesced after a failed reset to flush out any pending requests.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b027e5e3f4acb..8eaa954aa6ed4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2778,6 +2778,7 @@ static void nvme_reset_work(struct work_struct *wor=
k)
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 	nvme_dev_disable(dev, true);
 	nvme_mark_namespaces_dead(&dev->ctrl);
+	nvme_unquiesce_io_queues(&dev->ctrl);
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
 }
=20
--=20
2.34.1


