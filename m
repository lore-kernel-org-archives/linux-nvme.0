Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065FEC00144
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jul 2022 16:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qQCE+11/j+8eEeM77Jmm7pcEQNV+Q67QFPEeMVEamDU=; b=hkxaAyopMoNX3cwWIl66+NsDWA
	DJJjHI0SCJw0HD9jLOE5ZA/UZujhHFZv8JbD3qfUCpCO7qOvrjP5Wol/FKZ7f8E9i1P7449RIQ15P
	jaA/CcFZQ7gd/JvmNFY27UslVk44db+HcdGs/IkxNtQQCZbiCIShNXkF++JxlNSk+QfctB2vh/CUD
	BqbMztR0or+MFCqyIUGmbKD49YKS3YoZ8mB18t/7gUoeUAHUUbpflG8MxuPeVkiOj6zZTGtx4AruI
	s5e8P/TqwLWAw03wFelqswEcjj26n+f6od4ZCk2tul/HLhMtQi/itA0ED1InAhsvtYUpLyHSy2pOV
	nhRSYPXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHSrY-006Nk7-GQ; Fri, 29 Jul 2022 16:29:20 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHSrO-006NZq-By
	for linux-nvme@lists.infradead.org; Fri, 29 Jul 2022 16:29:11 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26TERljG012715
	for <linux-nvme@lists.infradead.org>; Fri, 29 Jul 2022 09:29:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=qQCE+11/j+8eEeM77Jmm7pcEQNV+Q67QFPEeMVEamDU=;
 b=WRL9PSWkNNdCjsn+aQFkN87J9h8EvRFSkUK6VS7N34wA0xCLh3k/ohYCHKFIbPbuVVpS
 8x91VaUy8yIVUh2opJRKLEXgCd1nj1EdOfajXYHMDoN7frP7lPoYwuLediK3B0Zr5iHY
 uRj287lLyd9XkLc9vxQH8QiG2QjLxlOGQ1s= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hmhb2gxm2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 29 Jul 2022 09:29:07 -0700
Received: from twshared8442.02.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 29 Jul 2022 09:29:05 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id C9C456BA33E7; Fri, 29 Jul 2022 09:28:53 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCHv2 5/5] nvme-pci: move iod dma_len fill gaps
Date: Fri, 29 Jul 2022 09:28:51 -0700
Message-ID: <20220729162851.1574210-6-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220729162851.1574210-1-kbusch@fb.com>
References: <20220729162851.1574210-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 69MHx8PzNzwB3H93VptRrG-p99zU78zm
X-Proofpoint-ORIG-GUID: 69MHx8PzNzwB3H93VptRrG-p99zU78zm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-29_17,2022-07-28_02,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220729_092910_560902_1BDCD7F0 
X-CRM114-Status: GOOD (  16.26  )
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

The 32-bit field, dma_len, packs better in the iod struct above the
dma_addr_t on 64-bit systems.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6d491a27ed73..06b7ec0d5558 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -230,8 +230,8 @@ struct nvme_iod {
 	bool aborted;
 	s8 nr_allocations;	/* PRP list pool allocations. 0 means small pool in =
use */
 	u8 nents;		/* Used in scatterlist */
-	dma_addr_t first_dma;
 	unsigned int dma_len;	/* length of single DMA segment mapping */
+	dma_addr_t first_dma;
 	dma_addr_t meta_dma;
 	struct scatterlist *sg;
 };
--=20
2.30.2


