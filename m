Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A78CD4847
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2024 18:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ct0GcGSEvuTfHBLo2IYaHyxsQDhjTKUdgcUxeWag31Y=; b=42u7TJrMfYPi21qLHvXrtXeIrv
	+tHOnJVhISlfiGBkuftelqZnYPv64L3Hm57RCgzPHtP9b1EH0l13mOHk113JBc4kxhictlfxqXMAF
	3oQm/ghcOhAFWA5hulxGYzBIMgBU4j22F2chQbxwd1djP33r+OrA6KT61WGYyEQV7LQva0XC/rwG+
	FkTJO3z3sE2dzU7UuAsy7WM5TcyRvU/HKkst+A64hQ9aIbEQd3/tS5GKWIhOlaUgKkCauhhLepesB
	7dFdIQn0FcrL5XMEapp6jktn3Rpsxx0/3Nk4Mnsr1+Aiy+myk/hkkM0b9+VsF7BeMxIc/7UWRfahi
	YM8bq8Kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sluu1-00000005des-2WXl;
	Wed, 04 Sep 2024 18:38:49 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sluts-00000005dVj-1Rta
	for linux-nvme@lists.infradead.org;
	Wed, 04 Sep 2024 18:38:43 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 484D6iUp021402
	for <linux-nvme@lists.infradead.org>; Wed, 4 Sep 2024 11:38:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=ct0GcGSEvuTfHBLo2IYaHyxsQDhjTKUdgcUxeWag31Y=; b=
	dBGat40oav0vgdNw4G09vvXvzxtSCjh+DMcZQbNi4l3aDb/q0cS6kl3MKzNHFqSp
	4u7fAlarb9PN91eDprvzHFHe7qt5EwIdBDxS7siQ59ijb3ogMNqEUp1vfalzFOmx
	04rVg1Iz7UAZCqIbI9EQoK6CMVeqQC1fdhYzSnlyzIiPAMJzx3k1pJlqqGONIjN4
	Vhk0Va9+Ef4/rTw2nHcPL7Eqp1qfFRelmRzC0Jx+SVwGyVsAnmihFc4VHec0idFq
	UQI4+2FBqfwk9IgL9pYqfL6TfPWmMfbkEz+1GttUBI605QFLSR9FiD+/sBF09ZUe
	ogqmWlnlw1SRhp+gTEKkyg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 41e4wvs0af-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 04 Sep 2024 11:38:39 -0700 (PDT)
Received: from twshared1273.02.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 4 Sep 2024 18:38:34 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id CB6E712A1F0A1; Wed,  4 Sep 2024 11:38:19 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH-part-2 7/9] nvme-pci: provide a sgl mapping helper
Date: Wed, 4 Sep 2024 11:38:15 -0700
Message-ID: <20240904183818.713941-8-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240904183818.713941-1-kbusch@meta.com>
References: <20240904183818.713941-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: TpX436fX4ODGMNG_ta938CuIz7yVHHbx
X-Proofpoint-ORIG-GUID: TpX436fX4ODGMNG_ta938CuIz7yVHHbx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_16,2024-09-04_01,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_113840_621150_EFEBC255 
X-CRM114-Status: GOOD (  12.41  )
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

We're about to add another sgl user, so create helper for the generic
list creation code.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4980dde804a0e..db0144a6bc5db 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -706,15 +706,26 @@ static void nvme_pci_sgl_set_seg(struct nvme_sgl_de=
sc *sge,
 	sge->type =3D NVME_SGL_FMT_LAST_SEG_DESC << 4;
 }
=20
+static void nvme_pci_sgl_set_list(struct nvme_sgl_desc *sg_list,
+				  struct nvme_sgl_desc *seg,
+				  struct scatterlist *sgl, int nents,
+				  dma_addr_t dma)
+{
+	struct scatterlist *sg;
+	int i;
+
+	nvme_pci_sgl_set_seg(seg, dma, nents);
+	for_each_sg(sgl, sg, nents, i)
+		nvme_pci_sgl_set_data(&sg_list[i], sg);
+}
+
 static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
 		struct request *req)
 {
 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
-	struct nvme_sgl_desc *sg_list;
 	struct nvme_rw_command *cmd =3D &iod->cmd.rw;
 	struct scatterlist *sg =3D iod->sgt.sgl;
 	unsigned int entries =3D iod->sgt.nents;
-	int i =3D 0;
=20
 	/* setting the transfer type as SGL */
 	cmd->flags =3D NVME_CMD_SGL_METABUF;
@@ -728,13 +739,8 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_=
dev *dev,
 				 iod))
 		return BLK_STS_RESOURCE;
=20
-	sg_list =3D iod->list[0].sg_list;
-	nvme_pci_sgl_set_seg(&cmd->dptr.sgl, iod->first_dma, entries);
-	do {
-		nvme_pci_sgl_set_data(&sg_list[i++], sg);
-		sg =3D sg_next(sg);
-	} while (--entries > 0);
-
+	nvme_pci_sgl_set_list(iod->list[0].sg_list, &cmd->dptr.sgl, sg, entries=
,
+			      iod->first_dma);
 	return BLK_STS_OK;
 }
=20
--=20
2.43.5


