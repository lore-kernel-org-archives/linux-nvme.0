Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B9BC04A68
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jul 2022 22:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5pFxfYTxk71JPjlwfjz1aPOZfw/9Fl5mx9q9U7AUy6w=; b=wxW+sJDQ/tHyvvAgBXjQiabKeq
	lSjmjSFigHXrsGO3EJsBSW9h9uq4shn5bbDkUOuVYSNctUYlPNT2oAXHX0t6yvVCiyAdVkNWkDyFX
	wm9lodGkCd7RDYEZkyerOuuYrmojbU8c3F29O0BfePQfKvqsraer7/msbvI9jtCjwauKqEl4Ak6/+
	S7C65X7vDEgLH3U9kYsBjsBDE0aN+hm5wP/v59VxxyXk5QLDY1mqp4c8AWBkSa3291EGje3O0EBwQ
	8FAKfoUOxLF1q2n5WxIL8atdts4IZdgrcsUIFkavDHBaHPUHgg8XjAkGXTADl5aWYl8Hg06yNU7yA
	HOU0KYKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHBk2-00FI9g-OC; Thu, 28 Jul 2022 22:12:26 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHBjk-00FI2b-El
	for linux-nvme@lists.infradead.org; Thu, 28 Jul 2022 22:12:10 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26SILoxH032703
	for <linux-nvme@lists.infradead.org>; Thu, 28 Jul 2022 15:12:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=5pFxfYTxk71JPjlwfjz1aPOZfw/9Fl5mx9q9U7AUy6w=;
 b=BlMr5HdTAM1uznZOMrJM1NRNWQAmICt5FGqBF4qDlipPMHZYjYu5FNxCl9G9eFA0W8O/
 +DUCCiu8t0CzUaCzvYMf1H5UjdgYPUM5UdE8NiyyvTDLcQQ1eIOWLqgiQ5GTv79jeCi2
 Ao6T/BzL2ihujAIOHO6lD7ODDqvkfyCZGSM= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3hkpemdmxb-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 28 Jul 2022 15:12:05 -0700
Received: from twshared25107.07.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 28 Jul 2022 15:12:02 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id A509D6B202AC; Thu, 28 Jul 2022 15:11:52 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/5] nvme-pci: iod's 'aborted' is a bool
Date: Thu, 28 Jul 2022 15:11:48 -0700
Message-ID: <20220728221152.538648-3-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220728221152.538648-1-kbusch@fb.com>
References: <20220728221152.538648-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7DJeT5w-t2BA9LnOcpRBNbZXupOriJZn
X-Proofpoint-GUID: 7DJeT5w-t2BA9LnOcpRBNbZXupOriJZn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220728_151208_671228_B153EBCE 
X-CRM114-Status: GOOD (  16.93  )
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


