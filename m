Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E2CC00144
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jul 2022 16:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wgY54bfhj2vhNHmb+9JB7+P77JfI4WzymH5jBzJlsU4=; b=QjlYgy6SK3fRZop01UJKhWBkhn
	p36Iw/N/vLkFWsqftt6OLWog4+iYrvWYDDIGpHICSnKIHtcrAEy5ZaTD1IDKfLHFsFfQpjVVecGVd
	kUsAlmeUoBII0vm76rsG6+9kN7hLhp4cF6/ZQUK4LlpZp0q+dfksru/oUeCH/okIb0A8A94Xj1f0/
	L1C3VpK/dCBOYW0VVkG+49zRCn3Xnms2eDVE3qSUFN8ZqaGs8QFg99fOACttO+xWZQrxJkXbhlH6T
	LbronUBBAgWzhciOZFDJqK2Z6Fbvi0uwh7HjcXLlrd4bTzTOoVltpeoGkjaUst3of9wPsujJj6Ug+
	AhWvlByQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHSrh-006Npu-OE; Fri, 29 Jul 2022 16:29:29 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHSrP-006NZC-Cf
	for linux-nvme@lists.infradead.org; Fri, 29 Jul 2022 16:29:13 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26T8XYf5001777
	for <linux-nvme@lists.infradead.org>; Fri, 29 Jul 2022 09:29:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=wgY54bfhj2vhNHmb+9JB7+P77JfI4WzymH5jBzJlsU4=;
 b=O8mwlUZLv9vNiP5nmfV/M3Yuxj+G6qq1kWgoO5e49KZwSudmiBTKRVyCFpR2dOopxHop
 mBqnGILCLOEUhO5Z0eo1TiO8o7vHLLO7ai2sGuVtcQHyNWx3jss222jUeqfJy6hNnyAu
 KuKxiwO7p5JjGktL95fVPTVsiJrfePevn+o= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hmc55ak8v-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 29 Jul 2022 09:29:07 -0700
Received: from twshared7556.02.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 29 Jul 2022 09:29:05 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id E42326BA33DC; Fri, 29 Jul 2022 09:28:52 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCHv2 2/5] nvme-pci: iod's 'aborted' is a bool
Date: Fri, 29 Jul 2022 09:28:48 -0700
Message-ID: <20220729162851.1574210-3-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220729162851.1574210-1-kbusch@fb.com>
References: <20220729162851.1574210-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 2YGQ_Pch6q2pnNowCN9OdGgOMrbZgo_r
X-Proofpoint-GUID: 2YGQ_Pch6q2pnNowCN9OdGgOMrbZgo_r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-29_17,2022-07-28_02,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220729_092911_468457_B0707436 
X-CRM114-Status: GOOD (  16.52  )
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

It's only true or false, so make this a bool to reflect that and save
some space in nvme_iod.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 138d408f7306..a8ae043e33de 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -227,7 +227,7 @@ struct nvme_iod {
 	struct nvme_request req;
 	struct nvme_command cmd;
 	bool use_sgl;
-	int aborted;
+	bool aborted;
 	int npages;		/* In the PRP list. 0 means small pool in use */
 	int nents;		/* Used in scatterlist */
 	dma_addr_t first_dma;
@@ -904,7 +904,7 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev=
, struct request *req)
 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
 	blk_status_t ret;
=20
-	iod->aborted =3D 0;
+	iod->aborted =3D false;
 	iod->npages =3D -1;
 	iod->nents =3D 0;
=20
@@ -1425,7 +1425,7 @@ static enum blk_eh_timer_return nvme_timeout(struct=
 request *req)
 		atomic_inc(&dev->ctrl.abort_limit);
 		return BLK_EH_RESET_TIMER;
 	}
-	iod->aborted =3D 1;
+	iod->aborted =3D true;
=20
 	cmd.abort.opcode =3D nvme_admin_abort_cmd;
 	cmd.abort.cid =3D nvme_cid(req);
--=20
2.30.2


