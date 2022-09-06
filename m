Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FCEECAAA1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 16:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jTg8IIgmIYcGcw6c2vW2kL5VbPC979c39TgsLEplVnQ=; b=DA4Ziq6/3YhXLwF5wWvN0BobQ4
	bwopZz1uJOFnSDFximv+AKg88spTuepVM3XkspkaC56yQp/XPsxRnWvnjbz9lNT7Vqwo8ADQHJInX
	lqq+/E76QBlQrG+5R8t7iN5uIB9Dri/CTYsZn98i/IPyUTpZJpjRpXBqIRC3dfQY5qFzE8UsQ8/ef
	q/wr3oDRBJfzXjbRccpPwAF8WlgCAMZDDPEIRCrGvIcR81Bq3zojyf3QaHGN6064CyV99Mf5xOcgk
	LMeN139vBlfRjTlSbTvFbF9fycNo0qsrdD0S7I6fNOE3Y+kpQL0aFCCC6ZDqzeGKtnqsWNnNA17DC
	tRbT36LA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVbS1-00FQKv-TZ; Tue, 06 Sep 2022 16:29:25 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVbA4-00FEhX-Jm
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 16:10:54 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286F37fF026622
	for <linux-nvme@lists.infradead.org>; Tue, 6 Sep 2022 09:10:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=jTg8IIgmIYcGcw6c2vW2kL5VbPC979c39TgsLEplVnQ=;
 b=EclRyOM+kbnFYSDtgD7LVxfJl5KyCyHvCxp0ytJSPvMenUzMHkVTIHCcqCOqqOXDdRYO
 9H+GD1WOsYr7lucHaueYe5VZNqUHrb4vge669eAT3Zl+phi6C3w+rtenTHbkHH/ksfHW
 67tSYenqCnu7tsYNDry8pnMshFrqF1IjnF0= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3je87ggp71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 06 Sep 2022 09:10:51 -0700
Received: from twshared14074.07.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 09:10:50 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 2814C847D5BB; Tue,  6 Sep 2022 09:07:43 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCHv3 2/4] nvme-pci: iod's 'aborted' is a bool
Date: Tue, 6 Sep 2022 09:07:36 -0700
Message-ID: <20220906160738.2289621-3-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220906160738.2289621-1-kbusch@fb.com>
References: <20220906160738.2289621-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: LR82JMg3ZsnK7K-ep1tYYIhfT0v0oWOI
X-Proofpoint-GUID: LR82JMg3ZsnK7K-ep1tYYIhfT0v0oWOI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_091052_749603_E7ED9CF3 
X-CRM114-Status: GOOD (  17.12  )
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
index 403876ad3234..045ebdd8e8f3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -227,7 +227,7 @@ struct nvme_iod {
 	struct nvme_request req;
 	struct nvme_command cmd;
 	bool use_sgl;
-	int aborted;
+	bool aborted;
 	int npages;		/* In the PRP list. 0 means small pool in use */
 	dma_addr_t first_dma;
 	unsigned int dma_len;	/* length of single DMA segment mapping */
@@ -891,7 +891,7 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev=
, struct request *req)
 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
 	blk_status_t ret;
=20
-	iod->aborted =3D 0;
+	iod->aborted =3D false;
 	iod->npages =3D -1;
 	iod->sgt.nents =3D 0;
=20
@@ -1412,7 +1412,7 @@ static enum blk_eh_timer_return nvme_timeout(struct=
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


