Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BE1EB64D7
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jun 2023 14:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RIyF6AA2QMhSuMMTArcCEd7nMUC94nZNJIUxvOBepWs=; b=3a4Wi01GX1MG9JEm8bnWRpeHru
	fZtOQUPG8VdfCUD19J1DVlVGZGG53pmoRVJWRJZBUZuKXBUTdi73KyPMEJybeyFCIpBLslxc3eDuX
	lCN2/fm6jR3UJUvjufEV9woeouBPpG5ibKWDFSP/d0rh7SMJWTWFlzVzSAlJG0Tm3s+dhQBnf8pTR
	idMRlJwUbxzAoBmiyuvL6GDvuLGj/PCg7rI6OEb0SyqIVj6fKmbagyZbcltiluZGZBt6mWi0WbyT4
	tlkQk+t1snGNGHpzIydTDW1/c+4pNlmkL13ahR0SJPk/Obnwl/m/4d/xJ73Eanb7OkMz1nuy9wOQB
	NMH1d1Cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEWcm-00FunC-0G;
	Wed, 28 Jun 2023 14:58:28 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEWcj-00FumM-13
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jun 2023 14:58:26 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SABpub009326
	for <linux-nvme@lists.infradead.org>; Wed, 28 Jun 2023 07:58:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=RIyF6AA2QMhSuMMTArcCEd7nMUC94nZNJIUxvOBepWs=;
 b=Vw3tQb9Aj4+AqA/TSjGbjYoTLnft0AW4yLnSA+fOGroSTOnvCEE+S57qzWXAdX0JyZW+
 8YzeY3cZJTpnkpC8QAm9VwqXa/mu7+dSYCSbOWVxVcSU8TMGT28WYh1fu05VYTfYfcgN
 eZhKPjk6hEUaVP9BOohgidUzhn/7DEOAC8gVv2P808J4j1Wlke/f46bFTew5pT4YhVsH
 tbcTrdnlzmyU0U8x/pTgs+rbS80kF9icOKR5x8xWEgA/7XBval7mbL05Qi2gO/1rrGcS
 lzjftdORJatTAgKp2v5wuIXZEsf8cNAEFigeWLlkAcrBs29Vm7ABezunXHppzTEirpuS nQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rgart59fq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 28 Jun 2023 07:58:23 -0700
Received: from twshared8006.02.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 28 Jun 2023 07:58:22 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 8C9AD1AC9AB3C; Wed, 28 Jun 2023 07:58:14 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>,
        <ming.lei@redhat.com>
CC: <brookxu.cn@gmail.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/3] nvme: sync timeout work on failed reset
Date: Wed, 28 Jun 2023 07:58:13 -0700
Message-ID: <20230628145814.1068653-2-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628145814.1068653-1-kbusch@meta.com>
References: <20230628145814.1068653-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VXtE8nuaoQ-7yfcw6FBjoNST5Okg1e1r
X-Proofpoint-GUID: VXtE8nuaoQ-7yfcw6FBjoNST5Okg1e1r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_10,2023-06-27_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_075825_448870_A2C574D5 
X-CRM114-Status: GOOD (  14.35  )
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

Timeouts during reset will set the controller for failure, preventing
the state change to LIVE. Ensure all timeout work is synced after the
controller disabling completes so we don't have any other tasks messing
with any namespace request_queues.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8eaa954aa6ed4..bfeadecf9e15b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2777,6 +2777,7 @@ static void nvme_reset_work(struct work_struct *wor=
k)
 		 result);
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 	nvme_dev_disable(dev, true);
+	nvme_sync_queues(&dev->ctrl);
 	nvme_mark_namespaces_dead(&dev->ctrl);
 	nvme_unquiesce_io_queues(&dev->ctrl);
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
--=20
2.34.1


