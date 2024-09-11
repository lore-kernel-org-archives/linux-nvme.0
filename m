Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07724EE57CF
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 20:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LvDNngJGsWnatCyWW6vNi4OaEo2CnYyawxAlUHXUK4s=; b=I368wcldvwqAheqBISM0tMZHXf
	vn0wWY3UtaIsVOwamSWxJXG83kQzX1LQ8RikeP7uHtSN2T90hrLnequAZpvnMJWwdpJeaXyXQ5kBN
	p7WaS+mP41Dl1lM0t1GT0tRmge7vPJ1xSa1x3Yu7vt00LGJzIPIltpx/pXT92T81OjjDU9r+C6HG6
	8jG5z6gIUE8LkoAHKm9kvJDL7YJcnxOF72yKfaftcLXfI9QNZ8TcSUm01sa8ab8JD4N/96KrB97Ht
	JvpYbYoiEmXifDKWm17Fo9q7ApXjQmTP4icBzvpKocuJWb7fr5qPwoDJq+VnLCcXkBq2TuArzRb+a
	is/gyOzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soTiG-0000000Ar4X-0m5I;
	Wed, 11 Sep 2024 20:13:16 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soThz-0000000Aqny-1Nxo
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 20:13:01 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BHjdxi019460
	for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2024 13:12:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=LvD
	NngJGsWnatCyWW6vNi4OaEo2CnYyawxAlUHXUK4s=; b=dwO5eQPMAfqEQrJAdFF
	BQlrSXYCdox1DnS1KkpEbEQBR5EeLwwUDKkMnddw9N4Zof64jlTMsxaCUKbZIoj1
	grEUaZLsN49oyz+5IaKqcD6NOPmGFcCsKlS2RiGCoivMqHrd6D3pOx9H6QHfI5ut
	IQA+lHImKmoIkzO1fp6edRzx/nZ1thLlo6rYmT+yRcwAij5SNE/O0vwsSESc3uPl
	7PsrJSs9Y3JvK+nYZDFGfTe39USN9P4DsN6r3If6ouRGCVTjLl7MvWmf4wVICXDq
	swKzFfjiKw0stqYtRQ9F2ZHKC0Pf3dSQgg9Q7yRzVHgEf87GgwjRotdWh9Q5/CYL
	NOQ==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41kbpe38qg-20
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2024 13:12:58 -0700 (PDT)
Received: from twshared18321.17.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 11 Sep 2024 20:12:55 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id B204112E5EDA2; Wed, 11 Sep 2024 13:12:41 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 00/10] block integrity merging and counting
Date: Wed, 11 Sep 2024 13:12:30 -0700
Message-ID: <20240911201240.3982856-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: eWKnrVMji9ceub4UUenwb5vbn2MBTjnY
X-Proofpoint-GUID: eWKnrVMji9ceub4UUenwb5vbn2MBTjnY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-11_01,2024-09-09_02,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_131259_566575_8D05C756 
X-CRM114-Status: GOOD (  10.52  )
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

Some fixes and cleanups to counting integrity segments when metadata is
used. This addresses merging issues when integrity data is present.

Changes from v3:

  Unconditionally define nr_integrity_segments. (Christoph)

  Dropped the "simplify" patches and the queue limits checks; they are
  not correct under some conditions. (Christoph)

  Fix a commit message typo. (Anuj)

  Reordered the driver patches to appear after the integrity segment
  count is accurate.

  Added a patch (5/9) that accounts for user mapped integrity segments.

  Added reviews.

Keith Busch (10):
  blk-mq: unconditional nr_integrity_segments
  blk-mq: set the nr_integrity_segments from bio
  blk-integrity: properly account for segments
  blk-integrity: consider entire bio list for merging
  block: provide a request helper for user integrity segments
  block: provide helper for nr_integrity_segments
  scsi: use request helper to get integrity segments
  nvme-rdma: use request helper to get integrity segments
  block: unexport blk_rq_count_integrity_sg
  blk-integrity: improved sg segment mapping

 block/bio-integrity.c         |  1 -
 block/blk-integrity.c         | 36 ++++++++++++++++++++++++-----------
 block/blk-merge.c             |  4 ++++
 block/blk-mq.c                |  5 +++--
 drivers/nvme/host/ioctl.c     |  6 ++----
 drivers/nvme/host/rdma.c      |  6 +++---
 drivers/scsi/scsi_lib.c       | 12 +++---------
 include/linux/blk-integrity.h | 13 +++++++++----
 include/linux/blk-mq.h        |  8 +++++---
 9 files changed, 54 insertions(+), 37 deletions(-)

--=20
2.43.5


