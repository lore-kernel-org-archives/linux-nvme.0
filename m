Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41295C00144
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jul 2022 16:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xLNCjsqht9dRxiuiypc1diSD7gSpeQZAnKA8kTFApIc=; b=qUjNo0hS333JVHy0nxRggEKTeB
	B1go/g2d5/KcdL5gBq3xz1T1f3quSbYwfvYvhKt26LFZtA4UnNL8lffEPpbNAl9iK8Fa7A3gFJ6wW
	84NeVc+69Kciyyu+y1LNY56GaASXQI2feM6c9noDQZBp1OuUpS9tJ/+o3VCY3Swq5rCsYXkkA55pv
	cypsgKZwqffZjnSUyICHnwWxzLuyWTYAG3tSMkAdkB5KT5gic65h7gIlc3uAeQoVtHumPXlUcI2ve
	STbn2p4lgho2d3H4gp9D04VJYxUJ4jsK3WyI3F7CvfaUn71BNMsY/WTw5grE0umTu4P1CxBQkq5qI
	6Dne6qRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHSrS-006Ne8-AA; Fri, 29 Jul 2022 16:29:14 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHSrN-006NXR-Ta
	for linux-nvme@lists.infradead.org; Fri, 29 Jul 2022 16:29:11 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26T9kDSg009216
	for <linux-nvme@lists.infradead.org>; Fri, 29 Jul 2022 09:29:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=xLNCjsqht9dRxiuiypc1diSD7gSpeQZAnKA8kTFApIc=;
 b=BjC593jIIfNhZIEy3n5t2mzmTLbiJwUzUyrwzhRFYTgLRMoOQmvbz0f4TrHbOYUNMKBX
 ljY8zj270bd1aWWQXy06hAXdKQG8hQpIZw4sPeQgrtl9+fkmVmfUiix5yNrx2A1bqUeT
 JDl1NsE3aVHCR9TW3pptduYespFZB2iTviA= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3hkjkn3s1k-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 29 Jul 2022 09:29:03 -0700
Received: from twshared33626.07.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 29 Jul 2022 09:29:02 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 848766BA33E4; Fri, 29 Jul 2022 09:28:53 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 4/5] nvme-pci: iod nents fits in u8
Date: Fri, 29 Jul 2022 09:28:50 -0700
Message-ID: <20220729162851.1574210-5-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220729162851.1574210-1-kbusch@fb.com>
References: <20220729162851.1574210-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: bZpt3ImQfSjSW5f7e3Zv80dtKKUS82hI
X-Proofpoint-ORIG-GUID: bZpt3ImQfSjSW5f7e3Zv80dtKKUS82hI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-29_17,2022-07-28_02,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220729_092910_131847_5234AD08 
X-CRM114-Status: GOOD (  17.58  )
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

The maximum number of 'nents' is 127, set by the queue limit, and is
only >=3D 0, so it fits in an 'u8' type. Set to that type to save some
space in this highly allocated struct, and ensure we don't accidently
let nents exceed this type in the future.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:
  Added BUILD_BUG_ON (Christoph)

  Made this a u8 instead of s8

 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e5b8e1c277b2..6d491a27ed73 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -229,7 +229,7 @@ struct nvme_iod {
 	bool use_sgl;
 	bool aborted;
 	s8 nr_allocations;	/* PRP list pool allocations. 0 means small pool in =
use */
-	int nents;		/* Used in scatterlist */
+	u8 nents;		/* Used in scatterlist */
 	dma_addr_t first_dma;
 	unsigned int dma_len;	/* length of single DMA segment mapping */
 	dma_addr_t meta_dma;
@@ -3562,6 +3562,7 @@ static int __init nvme_init(void)
 	BUILD_BUG_ON(sizeof(struct nvme_create_sq) !=3D 64);
 	BUILD_BUG_ON(sizeof(struct nvme_delete_queue) !=3D 64);
 	BUILD_BUG_ON(IRQ_AFFINITY_MAX_SETS < 2);
+	BUILD_BUG_ON(NVME_MAX_SEGS > U8_MAX);
 	BUILD_BUG_ON(DIV_ROUND_UP(nvme_pci_npages_prp(), NVME_CTRL_PAGE_SIZE) >
 		     S8_MAX);
=20
--=20
2.30.2


