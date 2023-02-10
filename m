Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47A7C05027
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Feb 2023 18:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IKUyxFjzV7yMTN/R4ukw94PjxTHqB1WH6eW+XyggdHc=; b=NoEhfpg/TIcd5VUl1tOk0hd2pG
	73IT4ZDDuHJRRJv8DuKlvdSoV9CfIUYbTg9QjKlZ/1P85lcLGryPGTD3fm11A0/1lANVrdMMuA4tt
	7XcubL0LeHozTIZ1uTzSc3xLOqccFvFycWy0kzYPd3KHTBxQrrVZPNV3o7cxGlCuLt+RxFE3mC23X
	ba8e0sHq8WfVQMyC6KxyvWOmviMooBZCqaT9jMFDbtEXvV0BA9YRM5DyptXVM9fnS15TT2bjzMHvP
	3406kXBAGvot6LQYfh78dIHc+MiScALtXAtKkJQMSF1CxVs3p0IaYQN9GjE89vPGAdvw65FifQj29
	VRJXei2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQXkk-006oyY-Kd; Fri, 10 Feb 2023 18:04:06 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQXkh-006ovp-IB
	for linux-nvme@lists.infradead.org; Fri, 10 Feb 2023 18:04:05 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AEYYdI001332
	for <linux-nvme@lists.infradead.org>; Fri, 10 Feb 2023 10:04:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=IKUyxFjzV7yMTN/R4ukw94PjxTHqB1WH6eW+XyggdHc=;
 b=Xbw0eW6fIQ3pNp6N0Gd/gcGrUnV8F495pxORWfP/VRnLWp4AN5aJ160qxDgUU7eBe7Ie
 37O6xSZd5UgslCilFN6l15oDM7IllzPBpKjB30KdOxADNnq+QEOKuJdhB0vJpY3MofEu
 mfxuCTtMTt9OVq4WvvALuRI25k449I2UJIF7WjoxyYvnQFcDc3v0PTR/lD4cdiabQxwO
 7r5raZC6IS2j2xoMSIrutmS19Y9IZ5VmGzlGnZrLyDGop7ND05A8e0sjWBYBfeLIFSTz
 8xzmV6ckr1iSV7OZ18wOHfxeHHyu95oAt0fpB7fiTDzWjw5EfHYxZP0FkHlLhJzNzSN+ PQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nms9scxqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 10 Feb 2023 10:04:01 -0800
Received: from twshared6017.02.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 10 Feb 2023 10:04:00 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id E92B611097D1B; Fri, 10 Feb 2023 10:03:49 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <schnelle@linux.ibm.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/2] nvme-pci: fix freeing single sgl
Date: Fri, 10 Feb 2023 10:03:46 -0800
Message-ID: <20230210180347.3613573-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: RdbWquTDijuhvIP0uNdyhREgRXhOBgsO
X-Proofpoint-GUID: RdbWquTDijuhvIP0uNdyhREgRXhOBgsO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_13,2023-02-09_03,2023-02-09_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230210_100403_656914_697F000D 
X-CRM114-Status: GOOD (  17.96  )
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

There may only be a single DMA mapped entry from multiple physical
segments, which means we don't allocate a separte SGL list. Check the
number of allocations prior to know if we need to free something.

Freeing a single list allocation is the same for both PRP and SGL
usages, so we don't need to check the use_sgl flag anymore.

Fixes: 01df742d8c5c0 ("nvme-pci: remove SGL segment descriptors")
Reported-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
Niklas,
This is a little different than the one you tested, so I didn't include
your "Tested-by". I'm confident this is patch still fixes the issue,
though.

 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a331fbfa9a667..47d6b0023e3a8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -556,7 +556,7 @@ static void nvme_unmap_data(struct nvme_dev *dev, str=
uct request *req)
 	if (iod->nr_allocations =3D=3D 0)
 		dma_pool_free(dev->prp_small_pool, iod->list[0].sg_list,
 			      iod->first_dma);
-	else if (iod->use_sgl)
+	else if (iod->nr_allocations =3D=3D 1)
 		dma_pool_free(dev->prp_page_pool, iod->list[0].sg_list,
 			      iod->first_dma);
 	else
--=20
2.30.2


