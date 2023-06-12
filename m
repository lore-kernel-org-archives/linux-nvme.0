Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D46AC88CB7
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jun 2023 19:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4cT2BB79av4X2m47c8QSpy8GnjpJdMG3CuizmFlgZO8=; b=zyZqyN+RWNwtnrEjjrsim/mYFf
	gaC/0mWNE/Lsw/pkbhBz+30Ld7l0VeDO8vqyGJuAxhE90Nxw/Ta8BOtIxivZ4dHeG6KNyTTJ9gLjc
	yB8IXHyLQiWQ85pohQlu4wGsFEm1bzvsvliD9fZgKvxczd8ozuBLTE+hjlg4KDkRWeTr1Ef6McwOu
	JJ9Cf7Iicw2nar1WfuQDs0hb0GSgEPienjlkJUQzZoCCxzTcYza9Ak3w/kEPluI+z8Jvfr4Hut8hO
	R1+Ra2o/rqfuzsQOs3ipduVmj0jn1JJORMmxBjlIsliAxK0Oja3Ay8LqmgTGq95of2ufcBm+IYvFm
	KfcCQNkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8mpl-0052ep-1S;
	Mon, 12 Jun 2023 19:04:09 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8mpg-0052bK-2J
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jun 2023 19:04:07 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CHABcE025001
	for <linux-nvme@lists.infradead.org>; Mon, 12 Jun 2023 12:04:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=4cT2BB79av4X2m47c8QSpy8GnjpJdMG3CuizmFlgZO8=;
 b=nVhZS5GTwOR5q65Hqd/gN4IUHb/PLTqxRyHiFtLmMw8bKDr7UjdzDjoeBFiUVnIdKJpB
 CElO1+eJMInK/yshDVVSTHDKVRyHTpNGCrCexhfA+6JcYCfMK4ZeCBXrPR0a02k/MjT0
 gp0uwz2eZ1NoUT9ot8NDGOcwtgXYGn6cHkWHUo2xVdWtlk07JIg8Il2jWoNjmXJijth+
 suNZZDTMYz9+iUAl1oWIMlP4V+5Jcr/Yw4oL0Ph+uDyKo72SZGA3mFG7PlBAdIDe88ez
 D75363Thj+2oM8r05ge5x8cHrXJmkbnHZx030bIGSuECRRfv7vPNl4+axGWjmaU9IqXz bw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r5xdwmc73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 12 Jun 2023 12:04:02 -0700
Received: from twshared35445.38.frc1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 12:04:01 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id E58CA19FA77A0; Mon, 12 Jun 2023 12:03:44 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <io-uring@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <hch@lst.de>, <axboe@kernel.dk>
CC: <sagi@grimberg.me>, <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 0/2] enhanced nvme uring command polling
Date: Mon, 12 Jun 2023 12:03:41 -0700
Message-ID: <20230612190343.2087040-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: FKeXvixMjuSukgWzbK8HMSnbN47ORztK
X-Proofpoint-GUID: FKeXvixMjuSukgWzbK8HMSnbN47ORztK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_14,2023-06-12_02,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_120404_892129_C8823620 
X-CRM114-Status: GOOD (  11.30  )
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

Changes from previous version:

  Fixex botched merge compiler bug (kernel test robot)

  Added reviews

Keith Busch (2):
  block: add request polling helper
  nvme: improved uring polling

 block/blk-mq.c                | 48 ++++++++++++++++--------
 drivers/nvme/host/ioctl.c     | 70 ++++++++++-------------------------
 drivers/nvme/host/multipath.c |  2 +-
 drivers/nvme/host/nvme.h      |  2 -
 include/linux/blk-mq.h        |  2 +
 include/uapi/linux/io_uring.h |  2 +
 6 files changed, 56 insertions(+), 70 deletions(-)

--=20
2.34.1


