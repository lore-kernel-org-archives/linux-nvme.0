Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DECC04A68
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jul 2022 22:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dgJfQiIHM7F2wYXUE6RA1/2nyGInxkzQnpJSxn9sVYU=; b=FAKfj+fy2lWgMROIPtxZfJ0ZL9
	uMfopVBAq0tqClpP/n2O+sNwAYEzcnQycuwfnh4B07kaWZKr8g9IY4SnmBFJ5clIf9KgN6AO8rdCB
	hye1sucGa0K09luGsn/BeiMQLhCoaNsm/sBpz26x+G2pqm/5tglNCzdSOe0B9sOH0ChO6aAbuFl/r
	k1nPS5bnMll36snk7Mnl5FM3TWfy1pm0LnUpHgAGST1cG0iL9CHT6V52HphS1GdbgqGw5KEyDTaBn
	Lix+WM28D6WQvkv+VOIvRuF+rwOqu1RHVMgoJ7Ax5eYADC0MVZs3LVHbt2I0nP67nbX9BlGXk4laj
	Zx8ZTV6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHBjl-00FI4Y-Fj; Thu, 28 Jul 2022 22:12:09 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHBjj-00FI28-Ak
	for linux-nvme@lists.infradead.org; Thu, 28 Jul 2022 22:12:08 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26SL3qNB009348
	for <linux-nvme@lists.infradead.org>; Thu, 28 Jul 2022 15:12:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=dgJfQiIHM7F2wYXUE6RA1/2nyGInxkzQnpJSxn9sVYU=;
 b=TDelyKO98R1JN8aMGBMWM+5VnskRXlnLO7JZeBiH7JMMEJgK+d9gqaPD/cwG4y2dU7hk
 sj/1wTx0a/ZXq3kutWXdb2fwWGyrDbmzDghDY1HIW7Mv+UWd52Ztkg9jSNPBOjFwjs39
 l1KkSVT4g3xC6rDmeBKgcPVxGs7eIwEnzSk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 3hkjkmxgsp-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 28 Jul 2022 15:12:02 -0700
Received: from twshared6324.05.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 28 Jul 2022 15:12:00 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id D3DA86B202B2; Thu, 28 Jul 2022 15:11:52 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 5/5] nvme-pci: move iod dma_len to better pack
Date: Thu, 28 Jul 2022 15:11:51 -0700
Message-ID: <20220728221152.538648-6-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220728221152.538648-1-kbusch@fb.com>
References: <20220728221152.538648-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: LTE_Kslk6Koql56Zo2ImPQOh8BUeXIMm
X-Proofpoint-ORIG-GUID: LTE_Kslk6Koql56Zo2ImPQOh8BUeXIMm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220728_151207_508858_A763E693 
X-CRM114-Status: GOOD (  17.14  )
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

The 32-bit 'dma_len' field packs in the iod struct above the dma_addr_t
without creating a gap.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 546de3c2000b..66f7204ab905 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -230,8 +230,8 @@ struct nvme_iod {
 	bool aborted;
 	s8 npages;		/* In the PRP list. 0 means small pool in use */
 	s8 nents;		/* Used in scatterlist */
-	dma_addr_t first_dma;
 	unsigned int dma_len;	/* length of single DMA segment mapping */
+	dma_addr_t first_dma;
 	dma_addr_t meta_dma;
 	struct scatterlist *sg;
 };
--=20
2.30.2


