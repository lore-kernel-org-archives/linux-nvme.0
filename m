Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4ACDC54E76
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 22:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ug9QRpF/FSlWiJJzjUxxWpma7Oj8fHWym/H8mm64YIY=; b=keW6pVNEBFaVW3SFvbuU3rYD+G
	oAJByFWCADahKfixO7HiIqkps93DjoLuSDiuMyhgXrkW4Mcc29Z69K4iSkQ/RvtH03PzlPkXXZCFX
	KTXSexec/REQILlIZU/BWfarNmpBJjulXcGxgNy29wnplWpnB1S0C7MQ89gE73bYkSy3oq/3KR7/V
	iWxxXLaUGXeASUwR9SRxm+9kOfYzTzEcB+4DKfBCfopDyFJrPRI99VbEYKdAafDU33yiLGdg41JQr
	L45JiRFv7p0vpT6+cqOupVd9OzkqYGb+65eKcbsDKp0/QT/pIoSXaqHVvU49DiAcRtLaDhfkRi2Co
	xQtkok6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5CxF-00EzbH-1Z;
	Mon, 20 Nov 2023 22:41:21 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5Cx8-00EzWu-1B
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 22:41:16 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3AKMSZNC013393
	for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 14:41:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=ug9QRpF/FSlWiJJzjUxxWpma7Oj8fHWym/H8mm64YIY=;
 b=BDrW9ouAOFrx2/BcEvAet9hhLURx4pPPJk4U0MtmyluWuCJ31cz9SfcwGqz3DRYJsclk
 Pgf+bP2Jus1p0PUsJ5DPTW3cm0B7fZjEzQaT2NW8DSd4ewknNqQtNEwBRwjEtVaVt5pw
 Ea9SdD7s81zZFClYGfMzOmMxR+ryEC6Utt3Oej+7kNaiBNiDor7iSKrfDi6qFY6ZxAod
 V8sxBWYtTX+KzYrYH/3KFHMYIL/94I4Cfl2nMsFcLhG5PTk6/fy5FMvjkKhZCUi2086B
 Uxy3Ey1jK+xs9+b34JjaBygM13eL7Vxajifozl1lZQYICIUDaGNI18zrNiCna6L33RyQ QA== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3ugbt1abug-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 14:41:13 -0800
Received: from twshared13322.02.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 14:41:01 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 81B2421F1B1A6; Mon, 20 Nov 2023 14:40:59 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <io-uring@vger.kernel.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <joshi.k@samsung.com>,
        <martin.petersen@oracle.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 0/5] block integrity: directly map user space addresses
Date: Mon, 20 Nov 2023 14:40:53 -0800
Message-ID: <20231120224058.2750705-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: d5UU15yR_vWlmGUIP9jfKTXeVUj6eMTT
X-Proofpoint-ORIG-GUID: d5UU15yR_vWlmGUIP9jfKTXeVUj6eMTT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_144114_534422_40A4C608 
X-CRM114-Status: GOOD (  12.31  )
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

Handling passthrough metadata ("integrity") today introduces overhead
and complications that we can avoid if we just map user space addresses
directly. This patch series implements that, falling back to a kernel
bounce buffer if necessary.

v2->v3:

  Introduces a multi-page bvec iterator.

  Fix leaking pinned user pages (Kanchan)

  Fix final unpaired 'put' on user pages (Kanchan)

  Doesn't increase the size of 'struct bio_integrity_profile'; if the
  'copy_vec' pointer is needed, it gets appended to the existing bvec.

  Fix compiler warnings

  Fix compiler error for !CONFIG_BLK_INTEGRITY

Keith Busch (5):
  bvec: introduce multi-page bvec iterating
  block: bio-integrity: directly map user buffers
  nvme: use bio_integrity_map_user
  iouring: remove IORING_URING_CMD_POLLED
  io_uring: remove uring_cmd cookie

 block/bio-integrity.c     | 212 ++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/ioctl.c | 197 ++++++-----------------------------
 include/linux/bio.h       |  12 +++
 include/linux/bvec.h      |   6 ++
 include/linux/io_uring.h  |   9 +-
 io_uring/uring_cmd.c      |   1 -
 6 files changed, 261 insertions(+), 176 deletions(-)

--=20
2.34.1


