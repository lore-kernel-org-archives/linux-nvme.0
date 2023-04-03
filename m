Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D60C761AF
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 20:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Q8bps30hV3EMik+lxj4h4encW3Fy9GOLEkji6FWpF9A=; b=4dKo+ILqt+61sR1oloVjhb7k4/
	UWNjoJ56U0V8FaONqWvIuY6iKVOVeH91GR/HW1TbrgJ9x7vksykyDbp7ATfBH1XOg1lBDaYFnHeqr
	9t5rqtpwejJsiF3UemLddiUuDhJTlXpCYSd6GJ3MbGhuHkUl3/BIFi2aGiSFXHxfJSxV+qMo3zVe7
	mFttqJAGTgWFrzxsXPuOa2a1/p5+AlwTcvWnY+V+TmXPHB8xZlUMiu4PdcpRxsq+Bm//E1XZS/d8H
	sE2TGT1T4lyRHqtIyMewOozpu0ujq1aHn9uQUVq0hFGluQVhO4HJDzFhfAFiV7ZUXPONwP2FkHb3p
	wiFTU2mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjQVM-00GYVL-30;
	Mon, 03 Apr 2023 20:10:16 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjQVJ-00GYUl-1a
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 20:10:14 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333HKtDt021632
	for <linux-nvme@lists.infradead.org>; Mon, 3 Apr 2023 13:10:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=Q8bps30hV3EMik+lxj4h4encW3Fy9GOLEkji6FWpF9A=;
 b=RbWtrltvRtPGvh98IL88mJxSGkPOgJbGFdBeVlhrxUI5XTpnc/x64lDaC9gMaZIoNgKN
 BLOOxCRWGqfjzRuwa57ZdDtmbgowZ2TPx4+9Quha6ZH5NytdpMQoP9Vg+/Z0CUWSA2wK
 p+kCytFTWHD1lpFz8zJl58Ls9RtyMbLaxcQjKfKB/vJvJRv414Yh2gN/DYnBBT5djI7A
 KXACaDLP6ggzlOMHYVfo1gWpNYLsnsfLWBwHbwbfeo26Q3KIBdjONzfjfOvzYoXq7h+B
 ZedIyPoZsXqgJhWu7iEmvmw6ZFBkGL7OiTfG2BKyU2VUW3+U6xOuKC0lnplE/Pl+yeD8 ug== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pqws73d9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 03 Apr 2023 13:10:11 -0700
Received: from twshared7147.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 3 Apr 2023 13:10:10 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id A93AE152767E1; Mon,  3 Apr 2023 13:09:26 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Tom Yan
	<tom.ty89@gmail.com>, Laurence Oberman <loberman@redhat.com>
Subject: [PATCH] nvme: fix discard support without oncs
Date: Mon, 3 Apr 2023 13:09:25 -0700
Message-ID: <20230403200925.1641963-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: PRraOsF2SDO0QKDKowBQ6gTQ3Brhjt8R
X-Proofpoint-ORIG-GUID: PRraOsF2SDO0QKDKowBQ6gTQ3Brhjt8R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_15,2023-04-03_03,2023-02-09_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_131013_542193_54F195D7 
X-CRM114-Status: GOOD (  18.25  )
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

The device can report discard support without setting the ONCS DSM bit.
When not set, the driver clears max_discard_size expecting it to be set
later. We don't know the size until we have the namespace format,
though, so setting it is deferred until configuring one, but the driver
was abandoning the discard settings due to that initial clearing.

Move the max_discard_size calculation above the check for a '0' discard
size.

Fixes: 1a86924e4f46475 ("nvme: fix interpretation of DMRSL")
Cc: Tom Yan <tom.ty89@gmail.com>
Reported-by: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 53ef028596c61..d6a9bac91a4cd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1674,6 +1674,9 @@ static void nvme_config_discard(struct gendisk *dis=
k, struct nvme_ns *ns)
 	struct request_queue *queue =3D disk->queue;
 	u32 size =3D queue_logical_block_size(queue);
=20
+	if (ctrl->dmrsl && ctrl->dmrsl <=3D nvme_sect_to_lba(ns, UINT_MAX))
+		ctrl->max_discard_sectors =3D nvme_lba_to_sect(ns, ctrl->dmrsl);
+
 	if (ctrl->max_discard_sectors =3D=3D 0) {
 		blk_queue_max_discard_sectors(queue, 0);
 		return;
@@ -1688,9 +1691,6 @@ static void nvme_config_discard(struct gendisk *dis=
k, struct nvme_ns *ns)
 	if (queue->limits.max_discard_sectors)
 		return;
=20
-	if (ctrl->dmrsl && ctrl->dmrsl <=3D nvme_sect_to_lba(ns, UINT_MAX))
-		ctrl->max_discard_sectors =3D nvme_lba_to_sect(ns, ctrl->dmrsl);
-
 	blk_queue_max_discard_sectors(queue, ctrl->max_discard_sectors);
 	blk_queue_max_discard_segments(queue, ctrl->max_discard_segments);
=20
--=20
2.34.1


