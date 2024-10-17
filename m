Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5D4D374B8
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 16:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tOGBz/rCTzSIryNyP6GSBMTEgXEhA57kzrdrwgMPCHA=; b=Uu7UvLtfKojXIsrBmEFCwGBlOh
	BcrOUp85Oyj0vNMTUFOkOLu582Zd+sj5Fu5I0g2FnhE0kMotwS1BZ7dBTM9g+vEPVJvP7QX4IAwMb
	bLjMRCteeTkBDOM5MPT9vt9LPS8goyinAg+ygQy4gzDb3Oei+rspx44dnWnGfrGX/r8Y6QchGp57F
	PpkyQCC3TAH9PpMUYZ2OyAUtGtvNY5GXv6Ofuz73G9aGGsffhMZ+uBQMjEchAoPxUJ8u/CZhsAsN3
	G5V3JakBO1l/ss0+F4pHkFvhBfSy4R+TfReWlNN3Zw7iBwczmXNz6j9/aLhvarbXclzTRNy6iQvQl
	CWwlWWTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1T5k-0000000FQkj-3bew;
	Thu, 17 Oct 2024 16:11:12 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1T4l-0000000FQOB-04mF
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 16:10:15 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HChABN011337
	for <linux-nvme@lists.infradead.org>; Thu, 17 Oct 2024 09:10:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=tOGBz/rCTzSIryNyP6
	GSBMTEgXEhA57kzrdrwgMPCHA=; b=keMyyjtLol7RAtcGNTKxI8QlK8k1swjkdm
	BiSlJO6MXMXYySC0e+iQbnJSOskLIQL9EaV6JOcOHwD9zjcCqRY9liXDf5yppcmY
	1mEGzozq7e/0qC1J+rdBx02eumeTwc0T28Fo6di9qY1m7OWMUj3i2Uby9BBSoKQE
	DUSbZtRtjITPRW+QjwPA1zuBIQOGkIXfitGmqXz1Txh2nBWkNwS0dt7QmJuUtSyY
	Tne2S7b9fQxTM0wC+ULNdGBssW/Y5/ZMR1MJcDGt9SULIoJnJ0GxDNt1I4z2iYz1
	V9qk9KMQcbyOmhA8/YNTFlb0NGXoaimjxZ6oW7++bO0g7LxbKu8g==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 429wsspwe7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 17 Oct 2024 09:10:08 -0700 (PDT)
Received: from twshared16035.07.ash9.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 17 Oct 2024 16:10:07 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id DC738143A4A96; Thu, 17 Oct 2024 09:09:57 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <axboe@kernel.dk>, <hch@lst.de>, <io-uring@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <joshi.k@samsung.com>,
        <javier.gonz@samsung.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv8 0/6] write hints for nvme fdp
Date: Thu, 17 Oct 2024 09:09:31 -0700
Message-ID: <20241017160937.2283225-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4_OA-UN1Ys7BQKx7yzdOMA88nQgsAxik
X-Proofpoint-GUID: 4_OA-UN1Ys7BQKx7yzdOMA88nQgsAxik
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_091011_410837_3D2D8B10 
X-CRM114-Status: GOOD (  12.78  )
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

Changes from v7:

  Limits io_uring per-io hints to raw block, and only if the block
  device registers a new queue limit indicating support for it.

  The per-io hints are opaque to the kernel.

  Minor changelog and code organization changes.

  I don't really understand the io_uring suggestions, so I just made the
  write_hint a first class field without the "meta" indirection. It's
  kind of like ioprio, which has it's own field too. Actually, might be
  neat if we could use ioprio since it already has a "hints" field that
  is currently only used by command duration limits.

Kanchan Joshi (3):
  block, fs: restore kiocb based write hint processing
  io_uring: enable per-io hinting capability
  nvme: enable FDP support

Keith Busch (3):
  block: use generic u16 for write hints
  block: introduce max_write_hints queue limit
  fs: introduce per-io hint support flag

 Documentation/ABI/stable/sysfs-block |  7 +++
 block/blk-settings.c                 |  3 +
 block/blk-sysfs.c                    |  3 +
 block/fops.c                         | 10 ++--
 drivers/nvme/host/core.c             | 82 ++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h             |  5 ++
 fs/aio.c                             |  1 +
 fs/cachefiles/io.c                   |  1 +
 fs/direct-io.c                       |  2 +-
 fs/iomap/direct-io.c                 |  2 +-
 include/linux/blk-mq.h               |  3 +-
 include/linux/blk_types.h            |  2 +-
 include/linux/blkdev.h               | 12 ++++
 include/linux/fs.h                   | 10 ++++
 include/linux/nvme.h                 | 19 +++++++
 include/uapi/linux/io_uring.h        |  4 ++
 io_uring/rw.c                        | 10 +++-
 17 files changed, 166 insertions(+), 10 deletions(-)

--=20
2.43.5


