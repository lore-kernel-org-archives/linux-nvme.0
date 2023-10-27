Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C65C25B48
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Oct 2023 18:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=14K4aSvh9zzHeXc3eYmxxneQuIpMkFPFLr74aX4jAbM=; b=BjNVBwbwm5zd6wwQZRCISZASL4
	DHnHL7aia8mrEO+rH7IIXghMTE7tuSwLWy+Z1JBiDbN6ngP+G9vU6E/xvc6MIQbHFWGt793vBacaQ
	UDvvhFUoJd+a4FwoPFAyX+nFQrU2xvsRnND9/h1+vjGlG61T/I17zRtEtRgBU1oKl58DyIFHMLoZL
	XNnSMDUijEuboBCB3gOX/WDTLTLmiwNB/+uvcy+KjuqWx+99NyzXUKi9ycHT+Pi+jeMP8O8ebb25T
	3CNoroD50f+dG1f8mium7ZG0sEdR2u51wnI9mqN1kBKWqbU4mHTkB7qI1Xnsu3F1KStYx+ZGUe6zL
	yYbz+Uiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qwRRB-00Gw3u-1L;
	Fri, 27 Oct 2023 18:20:01 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qwRR8-00Gw2x-0j
	for linux-nvme@lists.infradead.org;
	Fri, 27 Oct 2023 18:19:59 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RE5YgD006135
	for <linux-nvme@lists.infradead.org>; Fri, 27 Oct 2023 11:19:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=14K4aSvh9zzHeXc3eYmxxneQuIpMkFPFLr74aX4jAbM=;
 b=TGJuFBE1aQjjfurggepHZ27mNihKdx2Cf+0ozDFYC96is4pMipoL1wxmKukgQ4daoIXR
 U8S8JrYgx1OEvPlyXy2wyqzAiNZKENQHJIVAiv0oaJcQDpEdu+m/19eYTERHWTvLL0J6
 cfICDNy98PCDuTh1hB0uxaZb3cCg24DbS6XjF5pPnA6yT6PGfaHpqUGLuiY8OAyIxkKn
 FOoMGsjTg8pwNSSfbiiUSAydR3tYLBN2V8xm7OOAQ1b8feFhNTJhsFmJrTaKYZSrl5Gi
 eWKAzepqdRvvehXHXf0nKNB3LUXGbpa025Q/1V1Dnq/1Qs15LKoIYnAN1NcUvOEZw2Zw HA== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u0c4pu407-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 27 Oct 2023 11:19:56 -0700
Received: from twshared16118.09.ash9.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 11:19:54 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 3ADAD20D0939E; Fri, 27 Oct 2023 11:19:36 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <io-uring@vger.kernel.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <joshi.k@samsung.com>,
        <martin.petersen@oracle.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/4] block integrity: directly map user space addresses
Date: Fri, 27 Oct 2023 11:19:25 -0700
Message-ID: <20231027181929.2589937-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: p9imzeSEFJndTDq3kOZH72OVyy-0pWlK
X-Proofpoint-ORIG-GUID: p9imzeSEFJndTDq3kOZH72OVyy-0pWlK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_17,2023-10-27_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231027_111958_387636_0EF39160 
X-CRM114-Status: GOOD (  13.30  )
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

v1->v2:

  Bounce to a kernel buffer if the user buffer fails to map to the
  device's integrity constraints. The user address remains pinned for
  the duration of the IO, which makes the copy out on completion safe
  within interrupt context.

  Merged up to current io_uring branch, which moved the driver owned
  flags to a different file.

Keith Busch (4):
  block: bio-integrity: directly map user buffers
  nvme: use bio_integrity_map_user
  iouring: remove IORING_URING_CMD_POLLED
  io_uring: remove uring_cmd cookie

 block/bio-integrity.c     | 202 ++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/ioctl.c | 174 +++++---------------------------
 include/linux/bio.h       |   9 ++
 include/linux/io_uring.h  |   9 +-
 io_uring/uring_cmd.c      |   1 -
 5 files changed, 240 insertions(+), 155 deletions(-)

--=20
2.34.1


