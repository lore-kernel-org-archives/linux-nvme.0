Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369FFE77180
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 20:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZtDYxbjHiaugtFmzLqbe9j/YPTnjBLHkM7Z0sBvStvs=; b=IyF3l/+GTwWoP+qzwTCLsxGX2o
	lmu0aFNTI7Tn7Y21fuTbmkG/eqYH81TCAQtXtl6NfeN3idqAEn6GbIFglOIyFgabOJ0s1rW6wjhmW
	H1ElOtxufW60NSPwQe6s2u+3/FOd7I/NlEkbZLgDqSLu6SlLFzqcokbypF71Dj4noWphVLv6LWBs2
	cVB9/mX+GVoBQwGcOjhTSJy+N+ceAzQLvuxVEjjx4/PPNwNPpH0vpvU1u7Gf78JRTQ5ebe+TlHo3a
	nKGazeNDAUe7pw6iEqz70XOmWUCsWndfIf1P8LsgunYpF9HIzu160M9BWv5BP3bTq9a7aBU/QDBQ8
	UseY2JMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tL6TM-0000000Cbyn-2RVL;
	Tue, 10 Dec 2024 20:04:44 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tL6TK-0000000Cbxe-3R8f
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 20:04:44 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAHLsEJ007977
	for <linux-nvme@lists.infradead.org>; Tue, 10 Dec 2024 12:04:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=ZtDYxbjHiaugtFmzLq
	be9j/YPTnjBLHkM7Z0sBvStvs=; b=i1/LxjytsrUE2esRwd3xvkCBcnoiRiXuyU
	pbeKfuULkMjMu0pa+MTaqto5feRfwEeTIeHQF1QgRbTZfCjzLDfwXgPC27TsvqYV
	5gb2ODWwzrYYP7V57XvJDs/tZROnH8DWmBkW/c74Ms8mnkQ0fcsGn+zzPEPGzTLb
	GnT45+0dFOv9r7UHNNP1fxNDqZXJShVHfCyiixEztSlanHuXDtzRqW8KMzDEtLy/
	T8eSGXHqBDMmmL7RiixMCDLGK2vxfT9zCTyNZkbxKdHdoM0oxaaQOgu/0kF5U78F
	kpTpOMzIyAYV8074XVkLyHhwgAPyd8uZlhFUfG0Mvp2w0artKgAQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43esyusb7k-20
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 10 Dec 2024 12:04:42 -0800 (PST)
Received: from twshared9216.15.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 10 Dec 2024 20:04:31 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 207B715D5C7B7; Tue, 10 Dec 2024 11:48:08 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>
CC: <sagi@grimberg.me>, <asml.silence@gmail.com>, <anuj20.g@samsung.com>,
        <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv13 00/11] block write streams with nvme fdp
Date: Tue, 10 Dec 2024 11:47:11 -0800
Message-ID: <20241210194722.1905732-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: u5e_4PrDQnHnIdXbE2pUjHXruMPGNskf
X-Proofpoint-ORIG-GUID: u5e_4PrDQnHnIdXbE2pUjHXruMPGNskf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241210_120442_865435_2359793B 
X-CRM114-Status: GOOD (  11.40  )
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

Previous discussion threads:

  v12: https://lore.kernel.org/linux-nvme/20241206221801.790690-1-kbusch@=
meta.com/T/#u
  v11: https://lore.kernel.org/linux-nvme/20241206015308.3342386-1-kbusch=
@meta.com/T/#u

Changes from v12:

 - Removed statx. We need additional time to consider the best way to
   expose these attributes. Until then, applications can fallback to the
   sysfs block attribute to query write stream settings.

 - More verbose logging on error.

 - Added reviews.

 - Explicitly clear the return value to 0 for unsupported or
   unrecognized FDP configs; while it's not technically needed (it's
   already 0 in these paths), it makes it clear that a non-error return
   wasn't an accidental oversight.

 - Fixed the compiler warnings from unitialized variable; switched the
   do-while to a more clear for-loop.

 - Fixed long-line wrapping

 - Memory leak when cleaning up the namespace head.

 - Don't rescan FDP configuration if we successfully set it up before.
   The namespaces' FDP configuration is static.

 - Better function name querying the size granularity of the FDP reclaim
   unit.

Christoph Hellwig (7):
  fs: add a write stream field to the kiocb
  block: add a bi_write_stream field
  block: introduce a write_stream_granularity queue limit
  block: expose write streams for block device nodes
  nvme: add a nvme_get_log_lsi helper
  nvme: pass a void pointer to nvme_get/set_features for the result
  nvme: add FDP definitions

Keith Busch (4):
  block: introduce max_write_streams queue limit
  io_uring: enable per-io write streams
  nvme: register fdp parameters with the block layer
  nvme: use fdp streams if write stream is provided

 Documentation/ABI/stable/sysfs-block |  15 +++
 block/bio.c                          |   2 +
 block/blk-crypto-fallback.c          |   1 +
 block/blk-merge.c                    |   4 +
 block/blk-sysfs.c                    |   6 +
 block/bounce.c                       |   1 +
 block/fops.c                         |  23 ++++
 drivers/nvme/host/core.c             | 186 ++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h             |   7 +-
 include/linux/blk_types.h            |   1 +
 include/linux/blkdev.h               |  16 +++
 include/linux/fs.h                   |   1 +
 include/linux/nvme.h                 |  77 +++++++++++
 include/uapi/linux/io_uring.h        |   4 +
 io_uring/io_uring.c                  |   2 +
 io_uring/rw.c                        |   1 +
 16 files changed, 341 insertions(+), 6 deletions(-)

--=20
2.43.5


