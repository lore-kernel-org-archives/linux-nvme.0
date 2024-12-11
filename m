Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C90CE77182
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2024 19:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=s8GAwMobQbYzm1WpzPfIBLt+oYBnnbj6arNEC9wHIYw=; b=UClhoMka6MrUEKBgVoVJPkIRA8
	qmS8cAOfK0yxCYtAlOcq4xPhDO446xLBSJGEuc0AyHTir+n2VNoWlwiZN+Cw6/v5/C2zEOnQ2bhOH
	hjfUllTDjVPSa+j7V8SqkBvGBB/5Ptq+YoZKf5ZuDVliNPLnaSRzgOLaqMmLlclI8QhwhHfH0H/UB
	Q2zRMrNQgP9hFKC0rxMpcQOUO6i/PaC6NROzw+rJU56rJdbLXncS7Vphw4ZiTCiRUq02kEo2WBnKW
	+7Mslb8X9bMMx/H/WsTXjdXZCZSW8++sUySxK71vhIT3EiDFMLOESh6OCwcjtHouQAJB/Gn7KIQ8I
	ZgWetWPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLS4l-0000000FrJS-1ZQ7;
	Wed, 11 Dec 2024 19:08:47 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLS4i-0000000FrHT-3Vyj
	for linux-nvme@lists.infradead.org;
	Wed, 11 Dec 2024 19:08:46 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBFIAIV019540
	for <linux-nvme@lists.infradead.org>; Wed, 11 Dec 2024 11:08:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=s8GAwMobQbYzm1WpzP
	fIBLt+oYBnnbj6arNEC9wHIYw=; b=JX8RI6CwFXQDwtwFdYbP50iojC2l8fBcjJ
	ZvB57GxwQ9odca3acZmX/DzDndAevyQ7vugOdzBvCC9NmQWzeBXTOGxHPy18a7nY
	JMH6rZ7RzRmzLiFM+KGg/+I3Nj81fYQqduP2dehfBDdfF2EZ0dyX6gEP4QKIQ+Dg
	Gxx8/pPzqfY2bx86MHi34cJnXuLc4IehQz2YCd5ZP8prr4GM1YKVVsHG5rV5h6ct
	4wheMzhn1pa353euov2DT6t8OlTk5pIsAPzkmdvX+yN92NpTRBdX3PU4f4Zs/c8A
	vkDMAQdOccifqH6MNJliWG+Z8B7/YnGbI5NZX/x3s9W2xjgpZ82g==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43faw8axnc-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 11 Dec 2024 11:08:44 -0800 (PST)
Received: from twshared55211.03.ash8.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 11 Dec 2024 19:08:40 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id C094E15DE394C; Wed, 11 Dec 2024 10:35:15 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>
CC: <sagi@grimberg.me>, <asml.silence@gmail.com>, <anuj20.g@samsung.com>,
        <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv14 00/11] block write streams with nvme fdp
Date: Wed, 11 Dec 2024 10:35:03 -0800
Message-ID: <20241211183514.64070-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 5-0rIyX4wOtqAthBlTv3gnY40aeFsdUR
X-Proofpoint-GUID: 5-0rIyX4wOtqAthBlTv3gnY40aeFsdUR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_110844_881646_0B8EBEBE 
X-CRM114-Status: UNSURE (   9.41  )
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

Previous discussion:

https://lore.kernel.org/linux-nvme/20241210194722.1905732-1-kbusch@meta.c=
om/T/#u

Changes from v13:

  Fixed up printing size_t format (kernel test robot)

  Use %d for endgid (John)

  Removed bdev write stream granularity helper (no user in this series)
  (John)

  Clamp variable size FDP config log page size to max order (Hannes)

  Ensure the log descriptor sizes make sense (Hannes)

  Comment typos (Nitesh)

  Commit log description fix for where to find the write stream
  parameters (Nitesh).

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
 drivers/nvme/host/core.c             | 192 ++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h             |   7 +-
 include/linux/blk_types.h            |   1 +
 include/linux/blkdev.h               |  10 ++
 include/linux/fs.h                   |   1 +
 include/linux/nvme.h                 |  77 +++++++++++
 include/uapi/linux/io_uring.h        |   4 +
 io_uring/io_uring.c                  |   2 +
 io_uring/rw.c                        |   1 +
 16 files changed, 341 insertions(+), 6 deletions(-)

--=20
2.43.5


