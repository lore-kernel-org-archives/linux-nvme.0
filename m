Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB076E77170
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2024 01:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=N6QJZ2jdiu9UH+vLXQlsk+NJB6RNvYfSL8jeMy0Efqw=; b=rXHQOq0Uw9KiM3ixecTKIzXwQT
	w55UFSYA20NXeYpf1kFRoGrPLuv31c+RYHuUo2lUNuhMXDtY+Gk7JhMFQxnR6gYaHHVE/aqVhTSr+
	1TcLjvg/YvOUWndImJaMUKOlHxdH+/ibpeAmTaKT3Yc9BvkP/qwdKRj2fLQzYTzSLIGF2ruorlDcc
	xNboY0n44j3SXr2BgBW+nt9FWrij28Kb3cEF4xt1ixhazC4yLvzqt/XfmXtEiSdPHkviEGJv2Avir
	XurbCJwzj4cQTP/t6p0MIG6wgoQfDn75hVeq/esqaxu8D9cLPp35TTwHX1iJQM4+aW2sVJsWnyBOk
	DrzAEMzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJNXI-00000000FSJ-3hLD;
	Fri, 06 Dec 2024 01:53:40 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJNX9-00000000FFU-2DBm
	for linux-nvme@lists.infradead.org;
	Fri, 06 Dec 2024 01:53:34 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B603MMq014363
	for <linux-nvme@lists.infradead.org>; Thu, 5 Dec 2024 17:53:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=N6QJZ2jdiu9UH+vLXQ
	lsk+NJB6RNvYfSL8jeMy0Efqw=; b=LviDA6LewbUvCfamYOMr+0mwCJG9IW+FFl
	STB3fqyTPEWWzwlRkxT6XtKmqJiFOdUtgGE+q/tEyBlNtqTOf6KMU2SCIfxmTIcU
	pyvqlBi4SZ/yo3c/0FrzSQBsOmVFpzsHfUY5P1JT4oq1NGkPfuLSAEW4SOi5bU9o
	Yv5jhLBSFy4icQ/eSQc0FZEc5Rj6ED5wX4oQP2u+KHF8HTKSAlDtZdOkWFJRgp1r
	Dq+l7G2QeHJNIjKf1TzDQ/t9szsvQW4qe5oSpSXxM7gQVchDn9nQ5plTN6gbuPr1
	CmENm6DGECC3aPVYC1cSwgFZrkH893LTAwr+blExIiwzlOj7a5lg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43bmru153t-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 05 Dec 2024 17:53:30 -0800 (PST)
Received: from twshared11145.37.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 6 Dec 2024 01:53:24 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id C476E15B21147; Thu,  5 Dec 2024 17:53:08 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>
CC: <sagi@grimberg.me>, <asml.silence@gmail.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv11 00/10] block write streams with nvme fdp
Date: Thu, 5 Dec 2024 17:52:58 -0800
Message-ID: <20241206015308.3342386-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: W6FAlIv8WIrSY5J3jf6PMT25_W8tMW7V
X-Proofpoint-ORIG-GUID: W6FAlIv8WIrSY5J3jf6PMT25_W8tMW7V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_175331_701305_1BCF3D01 
X-CRM114-Status: UNSURE (   7.79  )
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

Changes from v10:

 Merged up to block for-6.14/io_uring, which required some
 new attribute handling.

 Not mixing write hints usage with write streams. This effectively
 abandons any attempts to use the existing fcntl API for use with
 filesystems in this series.

 Exporting the stream's reclaim unit nominal size.

Christoph Hellwig (5):
  fs: add a write stream field to the kiocb
  block: add a bi_write_stream field
  block: introduce a write_stream_granularity queue limit
  block: expose write streams for block device nodes
  nvme: add a nvme_get_log_lsi helper

Keith Busch (5):
  io_uring: protection information enhancements
  io_uring: add write stream attribute
  block: introduce max_write_streams queue limit
  nvme: register fdp queue limits
  nvme: use fdp streams if write stream is provided

 Documentation/ABI/stable/sysfs-block |  15 +++
 block/bdev.c                         |   6 +
 block/bio.c                          |   2 +
 block/blk-crypto-fallback.c          |   1 +
 block/blk-merge.c                    |   4 +
 block/blk-sysfs.c                    |   6 +
 block/bounce.c                       |   1 +
 block/fops.c                         |  23 ++++
 drivers/nvme/host/core.c             | 160 ++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h             |   5 +
 include/linux/blk_types.h            |   1 +
 include/linux/blkdev.h               |  16 +++
 include/linux/fs.h                   |   1 +
 include/linux/nvme.h                 |  73 ++++++++++++
 include/uapi/linux/io_uring.h        |  21 +++-
 io_uring/rw.c                        |  38 ++++++-
 16 files changed, 359 insertions(+), 14 deletions(-)

--=20
2.43.5


