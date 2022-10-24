Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA4AECAAA1
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Oct 2022 18:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=c9JwElTAnQXCG+yXcJP+4cB3qgGWlgHuFSF8jivmkpM=; b=LWLzSIrJLGJdq30DQzFs7kXYJQ
	CCeuvDxJKMNZCuLUXNuqfxh81gz+csBl+DTbh22+zNzy0JBqGrpj3wkpyApkHpp7oWYTFIBpCDndP
	mEXEW+KxffEyR0Yjv//FhWDfB0RnvlD5gVSr25EeqpYoWVSrM2nHpUnW9qZCkDy6yZGLpLjT6UMMV
	KizG1hspkcKjFD4g9s9J9Ruc7k7dpqihu0RDmyFDxDqydRvB+SUXHn/rm+Y1BPmymk81FZ+AKrSMk
	3KbP75/otplFXbd8paTeHlh9KF0iGTQmUXwH5JvHeU48W6NHpNPr9gpvFpWEmiscrPR0+eXFMKX3K
	v/YCpjNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1on2e6-002iv1-Ea; Mon, 24 Oct 2022 18:57:58 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1on2e3-002iuL-Oi
	for linux-nvme@lists.infradead.org; Mon, 24 Oct 2022 18:57:57 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OG6Hn5027611
	for <linux-nvme@lists.infradead.org>; Mon, 24 Oct 2022 11:57:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=c9JwElTAnQXCG+yXcJP+4cB3qgGWlgHuFSF8jivmkpM=;
 b=FbWJ4LGmuPcAEf3C20EJFWrGWU4qv2M7262aqAmqbrnSwvSq/lgPkVACKTIWZW1oMO8L
 9Ou502Ohv+7xIxs1FB2bC4bZiEAt5eNzYEYzlBENDfO5FzM0Rbm/1+/8ASUUGgKbqQfO
 b/EDqSn/KRn9MdnNWP1nikoLDFvVqVonlNt8qLlwjk5NwDMfYJV4OhtOZUNxTvosqiXK
 tKQfAOUKX9gC/wa3YaZTPY0vcREHt4PJGUhi0BXKimYdeJIJN17xDlDiVm8Hlzf8a3Xw
 L9DKDSR1ysAUl5Ujrf7JlKb17jyKxU2N+5c9+mZbWQ8lspauL0ciqf9mJlQo9pSiBPVR dQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kcfu5w93d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 24 Oct 2022 11:57:52 -0700
Received: from twshared9088.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 11:57:50 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id F2B24A35B27B; Mon, 24 Oct 2022 11:57:45 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-multipath: set queue dma alignment to 3
Date: Mon, 24 Oct 2022 11:57:45 -0700
Message-ID: <20221024185745.3164002-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 2u-zAt8dutv09b7zuSUmqDGi-qarJ2FO
X-Proofpoint-ORIG-GUID: 2u-zAt8dutv09b7zuSUmqDGi-qarJ2FO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_06,2022-10-21_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221024_115755_845008_B4F31870 
X-CRM114-Status: GOOD (  14.22  )
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

NVMe spec requires all transports support dword aligned addresses, which
is already set in the namespace request_queue. Set the same limit in the
multipath device's request_queue as well.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/multipath.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.=
c
index 0ea7e441e080..93e2138a8b42 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -516,6 +516,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, str=
uct nvme_ns_head *head)
 	/* set to a default value of 512 until the disk is validated */
 	blk_queue_logical_block_size(head->disk->queue, 512);
 	blk_set_stacking_limits(&head->disk->queue->limits);
+	blk_queue_dma_alignment(head->disk->queue, 3);
=20
 	/* we need to propagate up the VMC settings */
 	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
--=20
2.30.2


