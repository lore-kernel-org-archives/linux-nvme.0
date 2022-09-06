Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93145C6FA86
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 16:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gyz9d1HrWdFO+2pqmRExeEVGRl6O7FRvxuRj9brVutA=; b=Ky/LfIwc2Ix9dsAPqeMbKe5/QR
	CTjFBI+wjK7m35ZXorfU/jdyZ4v/vtTW40jrGxbkyvItn7MWQ+AXY/2aK4Ek2cCiSQxQ3xP83Y0aH
	+ecuH3AXKLLu9eAumdUWIoO5SFoOIj2cWZoaCRK/0ocHyga7ItD1qgWHIHqFfecM8c75IYbLzbh6K
	d9YKu4L0oCN4CEoZVwKuJ4smzTr+UxSLp/WP4EjBffXpZgZTqRVuK8tzNsBfs0mbQPYXUKJu2kMhi
	bwoAVz7E8R4ALEryE8YfG0ZqQGnaR9mSr5jJfbSnuYW6l07VEovqC821XH39BimXoFs3kBGAyY58l
	VYkNei/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVbOJ-00FOEA-DN; Tue, 06 Sep 2022 16:25:35 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVb7I-00FCor-HF
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 16:08:02 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 286F2lkA004313
	for <linux-nvme@lists.infradead.org>; Tue, 6 Sep 2022 09:07:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=gyz9d1HrWdFO+2pqmRExeEVGRl6O7FRvxuRj9brVutA=;
 b=BInMHEHA7LoUjoHgRL/UOQJTV0vF+q+Wu0CVDfWlFPda7BtwpzARkZfExCkRgcCB35+h
 wornZjf66cm9BZmdWxMGuG2/v8Cqi+EOTm7CMUO8LnJ3I0+FPJBIWi+J68rAjuHZr2xA
 xrsUIah3CCyIEeiXiMNZyueazU8Pzjm13Mw= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3je3j3tb1y-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 06 Sep 2022 09:07:59 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub104.TheFacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 09:07:57 -0700
Received: from twshared14074.07.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 09:07:57 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id CAE05847D5BF; Tue,  6 Sep 2022 09:07:43 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCHv3 4/4] nvme-pci: move iod dma_len fill gaps
Date: Tue, 6 Sep 2022 09:07:38 -0700
Message-ID: <20220906160738.2289621-5-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220906160738.2289621-1-kbusch@fb.com>
References: <20220906160738.2289621-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: AxquMwqK0fsbHcF9RZt1_YIUH-KEmFB8
X-Proofpoint-GUID: AxquMwqK0fsbHcF9RZt1_YIUH-KEmFB8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_090800_759057_0908EFA1 
X-CRM114-Status: GOOD (  17.00  )
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
index 7339efc4cb86..4652df0fbaa9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -229,8 +229,8 @@ struct nvme_iod {
 	bool use_sgl;
 	bool aborted;
 	s8 nr_allocations;	/* PRP list pool allocations. 0 means small pool in =
use */
-	dma_addr_t first_dma;
 	unsigned int dma_len;	/* length of single DMA segment mapping */
+	dma_addr_t first_dma;
 	dma_addr_t meta_dma;
 	struct sg_table sgt;
 };
--=20
2.30.2


