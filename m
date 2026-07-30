Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D503C55162
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 16:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5xrq7Q5IMG63TWih9qulPB2avnaMZqdALcydznvMNd4=; b=1LN6po3WazwX1v7ddqUYljMZ2T
	AFgKZAyMljew5spdOXeSILEfCpauTMi/grjccFsEIUoSdM3d9nonjJLKfHz15/9yQYZ1YADmMAENk
	A5+TGGpd7bGGVePGZdMVe4M6GJr9Txb7R80jA2PsNz5lfnBqKp3jOo+EZJzfhYIBMz3QwfNRDaGUb
	0RhwErSiptnRkxkk8l+juIDi2S85oRgTv3M0G/25V6aziHyZYDOmiH9oPECsacW+dTroioCTNFyEq
	/FcFetGC1kgRpN4UekZmD1Wl7liHWONO8OQ8p8T+6cwNHHmfqF2vHrMSc4IZGxoUBhJ7tyc839KPP
	rMdIuPUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpTWH-0000000Az9c-1qSk;
	Thu, 30 Jul 2026 16:22:05 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpTWE-0000000Az8h-2dSE
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 16:22:04 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFRTaH2387023
	for <linux-nvme@lists.infradead.org>; Thu, 30 Jul 2026 09:22:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=5xrq7Q5IMG63TWih9q
	ulPB2avnaMZqdALcydznvMNd4=; b=oS73TXNkjdG+8DWoJlkQqE0eHSN1wRrEjx
	1zLcnW2ixyfxv8ioogZK5BIbzg9qppz0kn58a70FTfm1OxYp6CpQxHutDAt9eXEs
	ZZY5a9AavP0lRdPYVc87WCNUNzU+vA89LBrhEm1ngA7TgzN+F1Z5jkI65OMZBN9R
	3+WkfW/baXvO+RgMv/tzxKVOvg2YV4z7Ohiw9DuWpfmBfOKfUrQEUHB+bQxutV83
	AnWyY1bRztGyA6OZwvmvQjV5uE6lkQAVoljU13X0ENMwXbyTLx1r1O6iTmrMWtof
	EL1ZELRoSl5g/lfeg2vPKl+wSeJWtPTDmD2HqDefsHatUTAUFd5g==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fqrj2egjf-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 30 Jul 2026 09:21:57 -0700 (PDT)
Received: from twshared14178.03.snb1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Thu, 30 Jul 2026 16:21:27 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 41BF6267750D4; Thu, 30 Jul 2026 09:21:05 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <tglx@linutronix.de>, Keith Busch <kbusch@kernel.org>,
        santhosh kumar <santhu.linux@gmail.com>
Subject: [PATCH] nvme-pci: introduce parameter to clamp io queues
Date: Thu, 30 Jul 2026 09:20:55 -0700
Message-ID: <20260730162056.1421564-1-kbusch@meta.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: qgfYeTu30hn0q61DB5qhrwea9yPv1ta5
X-Authority-Analysis: v=2.4 cv=QuhuG1yd c=1 sm=1 tr=0 ts=6a6b7a27 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=8elwO82fXORLTBIkMd32:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=H-tqxiQy7GsINJaAqF8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfX1qMLPNH2lJ1x
 kyeAjDp/+TsLYkcn9r/7HLMTK0jBQXD8Ixoxv+J5MmrnUiNc8j/Rp4FjowZnTbtyzSK43ufQtPt
 zFIKOivsjYDi+4W+96lgrL+PBcZ5qTZrzhqtdLW3iN3mErMEguVLdMqfNxaViC0qoTXAHUU75Px
 0UG1mVDFAjbdDqWDKe1GNIVGxJUHQpwMz2oI4OPqmyvCRbc3v4tky436QKEzcX4z7J8KySqyP7A
 Qw9rXxAVTvfP80A5tNXIfLo1fpldbv9npmK+IqbCSMc01IKkCOCY0qnzE26FDyqjxK3pzZ0u1AY
 P0Ar52KS3TzyU/jRMXxnQgOgCSOgViGHpqvpd8yPpHYiY+GXyYHuVfJ7abE70bTzKTDzFQUFOG2
 mFo1BRN57bYcmIo2KgGi+iX/S/uB0OxdowZRk0h/XJ5Rzq2LQRePM2DGgmXfYaGxSpKGlsscXB1
 mJKmG2/ChtoafwfokdA==
X-Proofpoint-GUID: qgfYeTu30hn0q61DB5qhrwea9yPv1ta5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfX/AziloLiSrN2
 rqwH+7mIN8QIJ4y62RvOYmSUu9KwUxazSe+L255z0pzIny4KI6HqETau9T6WrpSSO27ndjGPfzF
 GcyRvPOagfutsY4NeGHo63G0/RyJQoY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_092202_775774_2C992BB2 
X-CRM114-Status: GOOD (  11.92  )
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

Large deployments can have the nvme driver's resource requests easily
exceed the platform's interrupt capabilities leading to an unbalanced
allocation. The driver doesn't know what devices it may see, so it can
not determine reasonable limits for itself. Provide a user settable
module parameter to limit the number of IO queues the driver may
request.

Link: https://lore.kernel.org/lkml/CAKudn=3DrGv-xwAwTis8wpg31mxekyE4YH-E8=
CQoDTYovsPrENnQ@mail.gmail.com/
Reported-by: santhosh kumar <santhu.linux@gmail.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 375e7a1fc91dc..cb80f0c73562f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -109,6 +109,11 @@ static unsigned int io_queue_depth =3D 1024;
 module_param_cb(io_queue_depth, &io_queue_depth_ops, &io_queue_depth, 06=
44);
 MODULE_PARM_DESC(io_queue_depth, "set io queue depth, should >=3D 2 and =
< 4096");
=20
+static unsigned short max_io_queues;
+module_param(max_io_queues, ushort, 0644);
+MODULE_PARM_DESC(max_io_queues,
+		 "max io queues to ask for (default 0 means no limit)");
+
 static struct quirk_entry *nvme_pci_quirk_list;
 static unsigned int nvme_pci_quirk_count;
=20
@@ -2953,8 +2958,8 @@ static unsigned int nvme_max_io_queues(struct nvme_=
dev *dev)
 	 */
 	if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)
 		return 1;
-	return blk_mq_num_possible_queues(0) + dev->nr_write_queues +
-		dev->nr_poll_queues;
+	return min_not_zero(max_io_queues, blk_mq_num_possible_queues(0) +
+				dev->nr_write_queues + dev->nr_poll_queues);
 }
=20
 static int nvme_setup_io_queues(struct nvme_dev *dev)
--=20
2.53.0-Meta


