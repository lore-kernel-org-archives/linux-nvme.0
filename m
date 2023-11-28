Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3992C07E97
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Nov 2023 17:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mMFNtpsJ8g0kioMxtrMnaoPQwShcK0lV/BhKuNs6194=; b=qqyKpvj2wOzCqtzeN87V9aTuJd
	spQuMgkbXsPgAgpCTqHd2ZIG3zQMcy1W7+VPMaa5PnlkTMI28xj5U1bsLwWqmts6D/Az0ZX0UFXJP
	Pt3ZEndAU9NwETQ93a0562DYnoIgGh+bhJFvsIkvh2tWoa+6OeguPZShM2B7mxp+kkmV1VCX6CzsU
	yEECK5GKTAu27IGaggpUHcrddGWyL0sEvpy7EBpn+2ZK1kU8Qls9+9wTmVQ1kwAecV29ReoNxybpm
	h8nLEhY6mftklz9YWUXeBxQ0sseU1QKsDvtGc90l35V3dYPsw28zuLj9fPMF+Onnho3Qs5CGJofPG
	Pot8SpOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r824I-005ydn-1l;
	Tue, 28 Nov 2023 17:40:18 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r824F-005ycU-2z
	for linux-nvme@lists.infradead.org;
	Tue, 28 Nov 2023 17:40:17 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASHGnQs023742
	for <linux-nvme@lists.infradead.org>; Tue, 28 Nov 2023 09:40:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=mMFNtpsJ8g0kioMxtrMnaoPQwShcK0lV/BhKuNs6194=;
 b=ZAGseM8N3+S48O8FvUr19f8j7b/iPifbXUQ9bF33IGpRLaM3P+aaHv79TVo8wjbjsm7a
 hIyGwiiQ/F3Qi8bInYHNHGOiT2rOETU+khhnG+ZXnYG81WEDXlZoxJvwBx5ARWXDvnlR
 E7uN/K8NZX6Qvg/YEINi5PLAkwmF1LJkthaCEgkWaqqkF0v+iz+PHBmvlZh9/sAeHE0e
 FlQCo3SkMJaj7tQTo/S70/qFLTbdeX4Fg6OPZDXvG9CshueU+AoKmBV4hy4XB8RwtGHJ
 Ympfk98k5Fd3BpOUyXPtBD+qx+aH6Ugv9pVtqqcHAJer6ki5GGHsvVxp4x/Ii2D7/9o8 dw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3umxpmgq84-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 28 Nov 2023 09:40:10 -0800
Received: from twshared6086.02.ash9.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 09:40:07 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id B5B33224FEE31; Tue, 28 Nov 2023 09:39:56 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-core: check for too small lba shift
Date: Tue, 28 Nov 2023 09:39:55 -0800
Message-ID: <20231128173955.339941-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 20Zb0m3XkF2h0-RaP-NO4EQ0TmD1n6ii
X-Proofpoint-ORIG-GUID: 20Zb0m3XkF2h0-RaP-NO4EQ0TmD1n6ii
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_19,2023-11-27_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_094016_307576_C093C289 
X-CRM114-Status: GOOD (  16.64  )
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

The block layer doesn't support logical block sizes smaller than 512
bytes. The nvme spec doesn't support that small either, but the driver
isn't checking to make sure the device responded with usable data.
Failing to catch this will result in a kernel bug, either from a
division by zero when stacking, or a zero length bio.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a55c2a774b9c4..1be1ce5228965 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1901,9 +1901,10 @@ static void nvme_update_disk_info(struct gendisk *=
disk,
=20
 	/*
 	 * The block layer can't support LBA sizes larger than the page size
-	 * yet, so catch this early and don't allow block I/O.
+	 * or smaller than a sector size yet, so catch this early and don't
+	 * allow block I/O.
 	 */
-	if (ns->lba_shift > PAGE_SHIFT) {
+	if (ns->lba_shift > PAGE_SHIFT || ns->lba_shift < SECTOR_SHIFT) {
 		capacity =3D 0;
 		bs =3D (1 << 9);
 	}
--=20
2.34.1


