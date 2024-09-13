Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC93FC6172
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 18:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/V+SQCa2TzW8MFzEkXVSlXsp7/37DTm/d7GB3FIFO3s=; b=CUmjmDUcDc50nJ3w2guWsiP2Zm
	VYLeS9N7Rta9EjIX8MzFclFfQDQlV7eaIUBQfswXvEZgnTKN+Yl3jtSFm5hDDIKKpxIMMzen2CkdN
	PiNr5AlTIQ5gQ27/G94M6cbWtbymYEeGv1e7ZXxq/Pe4VniTFvslg0u9QNIb7i5DNgLiNTGi9rEBe
	BkuIaEunxG0uBnJKLBn7ecbaSEqSuPK9o2ni9+/vow4pBN6kyfujyTJACJF5Uakx6Y6diVsc+sJL1
	ohKUM2wqxL3jVpVkXX3MlSZnk4eEhAd5f3YJv2uyqCQpsYktA3K4MTe9/m5WNMmo6VOXVA8AaObfU
	C4yMqCPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1spB2z-0000000GoSC-09qN;
	Fri, 13 Sep 2024 18:29:33 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1spB2i-0000000GoLr-0XQf
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 18:29:30 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DI2LlU003051
	for <linux-nvme@lists.infradead.org>; Fri, 13 Sep 2024 11:29:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=/V+
	SQCa2TzW8MFzEkXVSlXsp7/37DTm/d7GB3FIFO3s=; b=R7owH2/YW1ioGYQXpUm
	E6nWvgKbwyT+UR5+hMdzVUr1dXh/hr402fZifZUtcggoO0KKgd0howyrhb5wl5XR
	GTq3fl5bWp9Hx0kQMsEA3n+CBvRQPe9pbzGXoNacgvP568JC1Twl6D6CgA19ig9d
	nUM1yz0RrqcsxTTKEuPmp8zAIiJBVp/hyWkWSrMbDgNSwBHSVj5t7hlP+cCiS5mD
	RycnwdMV6NhUuZpM4l++3mtRSJsNw3qXU85Ut/FAChqsYPcI3lx57PQ2D3ZfRecn
	ndcMNZkEoiu1ptieZuyoNt3keAKw3l503sldbL+R6n2ED5fi3xzPGzK0Iy0dkVzx
	pIA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41kha4qjc4-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 13 Sep 2024 11:29:15 -0700 (PDT)
Received: from twshared32638.07.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 13 Sep 2024 18:29:10 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 518A912F91041; Fri, 13 Sep 2024 11:29:03 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv5 0/9] block integrity merging and counting
Date: Fri, 13 Sep 2024 11:28:45 -0700
Message-ID: <20240913182854.2445457-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Vg4w7H53D5DgOWMYqsCN16JOSKVikrFW
X-Proofpoint-ORIG-GUID: Vg4w7H53D5DgOWMYqsCN16JOSKVikrFW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_112916_311255_8679D533 
X-CRM114-Status: UNSURE (   9.02  )
X-CRM114-Notice: Please train this message.
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

  Dropped the trivial nr_integerity_segments helper

  Fixed sg mapping sanity check

  Added reviews

  Fixed commit log typos

Keith Busch (9):
  blk-mq: unconditional nr_integrity_segments
  blk-mq: set the nr_integrity_segments from bio
  blk-integrity: properly account for segments
  blk-integrity: consider entire bio list for merging
  block: provide a request helper for user integrity segments
  scsi: use request to get integrity segments
  nvme-rdma: use request to get integrity segments
  block: unexport blk_rq_count_integrity_sg
  blk-integrity: improved sg segment mapping

 block/bio-integrity.c         |  1 -
 block/blk-integrity.c         | 36 ++++++++++++++++++++++++-----------
 block/blk-merge.c             |  4 ++++
 block/blk-mq.c                |  5 +++--
 drivers/nvme/host/ioctl.c     |  6 ++----
 drivers/nvme/host/rdma.c      |  6 +++---
 drivers/scsi/scsi_lib.c       | 12 +++---------
 include/linux/blk-integrity.h | 15 +++++++++++----
 include/linux/blk-mq.h        |  3 ---
 9 files changed, 51 insertions(+), 37 deletions(-)

--=20
2.43.5


