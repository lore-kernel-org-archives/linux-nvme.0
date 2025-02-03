Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F39C02192
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 18:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KMmG5gJPTqu1RsuNuX10Ml6gX7oOZqPZjeqbhOhxPB4=; b=SgYh4nQV/CzWM1d5vXmXJYxdc1
	qZuirNIvsXnyD4VxGyy9v9gx5U6rySmfIP8NNcfdKjgiBpn92XDcvhJ5ZCJdOQLq2xR3oWaOtqTKL
	1eU9J1sy0/BBrruVyUeyEaAImNASi72VlETmFfiALuoH5oGfeaz42smdS6UDgbFbnaCQRVEwulWuq
	XkNU1r4KqIYfo9Nvf8uWvozyfoqNKA+66JBOGI940edg1ns0ozwFBcuQzaKltYKgn3iWn1p6lPddr
	Yy3CgRkxLAGpLeLqRJLZs9M93nLFJLL/onRSXq9WfdtSrurSuLgc4lUZnU0QsQZ9dOqq24curO2zM
	lmTIIZMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tf1ej-0000000GM2S-3cca;
	Mon, 03 Feb 2025 18:58:49 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tf1OU-0000000GIek-3oKP
	for linux-nvme@lists.infradead.org;
	Mon, 03 Feb 2025 18:42:04 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513II4uT006434
	for <linux-nvme@lists.infradead.org>; Mon, 3 Feb 2025 10:42:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=KMmG5gJPTqu1RsuNuX
	10Ml6gX7oOZqPZjeqbhOhxPB4=; b=Oh1LcRbbUPxefNDABEAQXrYS0O5V3SFY+5
	x776MigOcbrj8bT3C9IRiYTShwSWg9tKoPOiFgTmjcf0HUXoCQFmQntKfW0pxAp3
	JN1BLRIoBXGJsM1aEztEcBOSQhWMQTOYuP3jg60luPC3kkSfcfpQGFPIiUi52DZI
	x8kWzP141SYy0FhAy/hxgPGXA6+xVBOk1tyFgNyV4UCU/8otm3qa9F2jis9SKO0r
	ISyXY/FRL0K1kfUIVjg+fX0O6gZC5kLpwi5A1Cc4yhk6Kgo0rTI0GzCt1tSlVxuH
	012vXwEeJfDJXMFzKpHk0a23rg/p3Tpg3zk5YOwiJMc/OhSxOHsA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 44k2468p9k-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 03 Feb 2025 10:42:00 -0800 (PST)
Received: from twshared29376.33.frc3.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 3 Feb 2025 18:41:43 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id E8684179C261F; Mon,  3 Feb 2025 10:41:30 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <io-uring@vger.kernel.org>,
        <linux-block@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <asml.silence@gmail.com>,
        <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv2 00/11] block write streams with nvme fdp
Date: Mon, 3 Feb 2025 10:41:18 -0800
Message-ID: <20250203184129.1829324-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: kfKS1HWeVXpnYT2za0gbJwmQvTyq1xpW
X-Proofpoint-GUID: kfKS1HWeVXpnYT2za0gbJwmQvTyq1xpW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_08,2025-01-31_02,2024-11-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_104203_055850_622D9747 
X-CRM114-Status: UNSURE (   8.21  )
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

Changes since v14:

  Merged to latest nvme, block, and io_uring trees

  Replaced vmalloc with kvmalloc (Christoph)

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
 drivers/nvme/host/core.c             | 191 ++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h             |   7 +-
 include/linux/blk_types.h            |   1 +
 include/linux/blkdev.h               |  10 ++
 include/linux/fs.h                   |   1 +
 include/linux/nvme.h                 |  77 +++++++++++
 include/uapi/linux/io_uring.h        |   4 +
 io_uring/io_uring.c                  |   2 +
 io_uring/rw.c                        |   1 +
 16 files changed, 340 insertions(+), 6 deletions(-)

--=20
2.43.5


