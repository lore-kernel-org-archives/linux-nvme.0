Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A1AC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 20:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/wnmJuKQZVcMXWwCKnMHfnjWFVxRy3y7qywtFzmwz5s=; b=C7uy3CBNC/ea/7En5S2oQaX9Ou
	CD/UYLBapr3cLwQ9IX2U+YixkkCc4AKcCtsP2GYJ5bxP9q7uFREDIyWOKqtiztSmovLgn9a+PYAmM
	LtwRI524GyJHT8zxzHiGtZ5uzoLMNPaN+ASGIpJUK2RgAJHKKyd/n8yVrglPB/tKJdJYPYQOEXCvp
	fwwelsPRpF2DOpoyE5DaBvW8zVeNND5V9wRnIyX+cTQLlD4pDXNRD2XgrWjzVLlQ3HGpgk1sAf60x
	nTXzmZ4eTY6/kRpv/Pu4EayS/tB9jgaU0M9sFUfsXHbRG+HF8UF30OZSkw32u5CrihAzbq4ZVafvE
	sFSo/5lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzkor-009czC-Gb; Fri, 10 Jun 2022 20:01:21 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzkom-009cxE-Rg
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 20:01:18 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25AIATpK020290
	for <linux-nvme@lists.infradead.org>; Fri, 10 Jun 2022 13:01:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=/wnmJuKQZVcMXWwCKnMHfnjWFVxRy3y7qywtFzmwz5s=;
 b=JUu//sj3fkZZ2jGzsb4b7anJHujMJlazo0N+S65Ha+EypIxi7rg7CGnjhwjQdQEtML0r
 /qRn4NdLyofj/XsKTDdcXCQlAw5fLusdeRegQSdnBbrqJElX3h5TEQV5OD7uVR9+86Se
 KfH6Bcz8Z/FLin2c/RUKPHnYnd6g5bKTXEw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gmb0hgmqc-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 10 Jun 2022 13:01:13 -0700
Received: from twshared17349.03.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 10 Jun 2022 13:01:09 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 3427E4E9D686; Fri, 10 Jun 2022 12:58:31 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv6 00/11] direct-io dma alignment
Date: Fri, 10 Jun 2022 12:58:19 -0700
Message-ID: <20220610195830.3574005-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: WxIQYfEBoqkc6cCJnpUeWgxZbx3SwcQ5
X-Proofpoint-ORIG-GUID: WxIQYfEBoqkc6cCJnpUeWgxZbx3SwcQ5
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_08,2022-06-09_02,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_130116_963079_797CCB68 
X-CRM114-Status: GOOD (  15.17  )
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

The previous version is available here:

  https://lore.kernel.org/linux-block/Yp4qQRI5awiycml1@kbusch-mbp.dhcp.thef=
acebook.com/T/#m0a93b6392038aad6144e066fb5ada2cbf316f78e=20

Changes from the previous are all trivial changes:

  Fixed a typo, s/bvev_/bdev_/

  Updated commit messages and reviews

  Updated code comments

  Added a new comment for request_queue dma_alignement expressly
  documenting the consequences of setting this. All existing users of
  this attribute were checked to ensure they are on the correct side of
  those consequences.

Keith Busch (11):
  block: fix infinite loop for invalid zone append
  block/bio: remove duplicate append pages code
  block: export dma_alignment attribute
  block: introduce bdev_dma_alignment helper
  block: add a helper function for dio alignment
  block/merge: count bytes instead of sectors
  block/bounce: count bytes instead of sectors
  iov: introduce iov_iter_aligned
  block: introduce bdev_iter_is_aligned helper
  block: relax direct io memory alignment
  iomap: add support for dma aligned direct-io

 Documentation/ABI/stable/sysfs-block |   9 +++
 block/bio.c                          | 114 ++++++++++++---------------
 block/blk-merge.c                    |  41 ++++++----
 block/blk-sysfs.c                    |   7 ++
 block/bounce.c                       |  13 ++-
 block/fops.c                         |  16 ++--
 fs/iomap/direct-io.c                 |   4 +-
 include/linux/blkdev.h               |  17 ++++
 include/linux/uio.h                  |   2 +
 lib/iov_iter.c                       |  92 +++++++++++++++++++++
 10 files changed, 224 insertions(+), 91 deletions(-)

--=20
2.30.2


