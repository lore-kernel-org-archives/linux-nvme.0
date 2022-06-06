Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29ECCC433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jun 2022 16:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pu1b0NmDjHWl49y9hGDbVsaDW/iCqZCOl7663Zxexqo=; b=gJzq/JT6vynex7nTGk+RPDMY1u
	xf15d9YqJH0kUNP/5DreJhWmelbBLUJhVEEKlRfFaa5BzNOCs4cw1dOBzeQh7RpG2QEiAsy0mGjX1
	YkxgaLGTmRh3dSxMZNvUEx11Wz8wbBJ14/6FfoGviZZ6qHsn/zzKErPJtgIwNCGTRjbAskHDZI+Qh
	C+wF6wyVEy1jLUjQrrOCKnSuK3Lc4EnczcnUeP3F/Q/Od2qDEn1CyX1g8FweaLvdrV6I+7/japoh/
	1v9AJCZKSCcobNVJLe8XJGfDUYLhhFnXsmrR0VS7b9Y7XFg6nduHjU3LiQePoc+7XZGNZ/V72fwgX
	gqGaN/lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyFyw-0029J1-Vp; Mon, 06 Jun 2022 16:53:34 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyFyu-0029Hm-GA
	for linux-nvme@lists.infradead.org; Mon, 06 Jun 2022 16:53:33 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 256GhKQE030627
	for <linux-nvme@lists.infradead.org>; Mon, 6 Jun 2022 09:53:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=pu1b0NmDjHWl49y9hGDbVsaDW/iCqZCOl7663Zxexqo=;
 b=fSsqdLOEzvJLOrFXU86UBVStGBfmTbArsIc3sCOAZLrjcU5cU5hR4tv2M8r701bXzTwA
 7yWzXE4xz7wOquKIJgjx5M5cQMGb8pxK8WJFFcu+v+j4RfTGAkTHjaTq5AMSXpSqixXA
 vjZWFwWHs33C7c5Pu/rDXHVM1c9KMkDWTF4= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3gg2w79n8u-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 06 Jun 2022 09:53:31 -0700
Received: from twshared8508.05.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 6 Jun 2022 09:53:29 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id EBE334C645D8; Mon,  6 Jun 2022 09:53:18 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-pci: add trouble shooting steps for timeouts
Date: Mon, 6 Jun 2022 09:53:17 -0700
Message-ID: <20220606165317.2633782-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 8EXj_f4rg3X4NY3GJajH8p6BVhcViohx
X-Proofpoint-ORIG-GUID: 8EXj_f4rg3X4NY3GJajH8p6BVhcViohx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-06_05,2022-06-03_01,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220606_095332_699726_A7555743 
X-CRM114-Status: GOOD (  14.26  )
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

Many users have encountered IO timeouts with a CSTS value of 0xffffffff,
which indicates a failure to read the register. While there are various
potential causes for this observation, faulty NVMe APST has been the
culprit quite frequently. Add the recommended troubleshooting steps in
the error output when this condition occurs.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 48f4f6eb877b..9d963f6cdbae 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1334,6 +1334,14 @@ static void nvme_warn_reset(struct nvme_dev *dev, =
u32 csts)
 		dev_warn(dev->ctrl.device,
 			 "controller is down; will reset: CSTS=3D0x%x, PCI_STATUS read failed=
 (%d)\n",
 			 csts, result);
+
+	if (csts !=3D ~0)
+		return;
+
+	dev_warn(dev->ctrl.device,
+		 "Does your device have a faulty power saving mode enabled?\n");
+	dev_warn(dev->ctrl.device,
+		 "Try \"nvme_core.default_ps_max_latency_us=3D0 pcie_aspm=3Doff\" and =
report a bug\n");
 }
=20
 static enum blk_eh_timer_return nvme_timeout(struct request *req, bool r=
eserved)
--=20
2.30.2


