Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEDFD3A66B
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 15:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XgvQBUxMc4oBRDRypsEh3gf2mVo+uaeROl5mqKEtNEM=; b=scumI+hUw2SZtVGHq3mhwLi06L
	tXtSRvTOVv24KqOrs0SGwUgcTEwuHDh9n/PPtr916tqgAX7hvw+EIkSefp42fy0AntZhvLYk42SDm
	os/EU7dg9Usz0XzhEKCTaloJnSHvef9cCb2djU08i8kgClqqp42UODE5aLn0VZYflHZdSjxCwNE0x
	ZLMPDXZJeaF3wzcAQZIwQ9YQvMv6ZwypZmsSN2G/pT3XORSwKICfCHxvxY5pkqLd05Jcptu6c7WHj
	pdl4xpaJjRJgv1trjFTw9WKbi+y+9ceSOQ3913MDQcvyC9UOgPX0NcY0HxW2BIR3cN38U9dElRGV4
	CZ0p7Utg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5o3X-0000000Eta8-2zbu;
	Tue, 29 Oct 2024 15:22:51 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5o0o-0000000Eshf-1Zkf
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 15:20:04 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 49TD7Fwr021662
	for <linux-nvme@lists.infradead.org>; Tue, 29 Oct 2024 08:20:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=XgvQBUxMc4oBRDRyps
	Eh3gf2mVo+uaeROl5mqKEtNEM=; b=EkBldLnO1a5HwaERD48j8+tJYInobYCnto
	+7gK6kCnzA59H/PerqdNJH6U57UXRpA4P265FoAfDfBvquW4SsqUAf5bwseHRogt
	GNm2UQseW/y1/FI6TVRnHIlTrwl4QyDP028+Pa5WSrtYsoETwdCIbRKIYrG4jysk
	1s5MTTyxmeHVTFXstQalE8mUKJSHB+9MhSBjgAWo2IYYcj0bGf6KaNfaML12mw/I
	stlMrECM7iIqHeb2R8SbLqg4nf1qnIPeSVi8XfuEzan3LBxv3nMUs9sI+vALdfmK
	QgBOe7Lu8P/1YchdWUt9SMoKE9RbPsQKcatwmHxw87SeazTjAThA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 42k0af13y2-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 29 Oct 2024 08:20:01 -0700 (PDT)
Received: from twshared10900.35.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 29 Oct 2024 15:19:58 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id D97AA14920E9A; Tue, 29 Oct 2024 08:19:43 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <hch@lst.de>, <joshi.k@samsung.com>,
        <javier.gonz@samsung.com>, <bvanassche@acm.org>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
Date: Tue, 29 Oct 2024 08:19:13 -0700
Message-ID: <20241029151922.459139-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: DnSmwlLN5XD_GuOuSIQ547vCfuqlFbzP
X-Proofpoint-ORIG-GUID: DnSmwlLN5XD_GuOuSIQ547vCfuqlFbzP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_082002_614535_08D359F4 
X-CRM114-Status: UNSURE (   9.34  )
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

Changes from v9:

  Document the partition hint mask

  Use bitmap_alloc API

  Fixup bitmap memory leak

  Return invalid value if user requests an invalid write hint

  Added and exported a block device feature flag for indicating generic
  placement hint support

  Added statx write hint max field

  Added BUILD_BUG_ON check for new io_uring SQE fields.

  Added reviews

Kanchan Joshi (2):
  io_uring: enable per-io hinting capability
  nvme: enable FDP support

Keith Busch (7):
  block: use generic u16 for write hints
  block: introduce max_write_hints queue limit
  statx: add write hint information
  block: allow ability to limit partition write hints
  block, fs: add write hint to kiocb
  block: export placement hint feature
  scsi: set permanent stream count in block limits

 Documentation/ABI/stable/sysfs-block | 13 +++++
 block/bdev.c                         | 18 ++++++
 block/blk-settings.c                 |  5 ++
 block/blk-sysfs.c                    |  6 ++
 block/fops.c                         | 31 +++++++++-
 block/partitions/core.c              | 44 ++++++++++++++-
 drivers/nvme/host/core.c             | 84 ++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h             |  5 ++
 drivers/scsi/sd.c                    |  2 +
 fs/stat.c                            |  1 +
 include/linux/blk-mq.h               |  3 +-
 include/linux/blk_types.h            |  4 +-
 include/linux/blkdev.h               | 15 +++++
 include/linux/fs.h                   |  1 +
 include/linux/nvme.h                 | 19 +++++++
 include/linux/stat.h                 |  1 +
 include/uapi/linux/io_uring.h        |  4 ++
 include/uapi/linux/stat.h            |  3 +-
 io_uring/io_uring.c                  |  2 +
 io_uring/rw.c                        |  3 +-
 20 files changed, 253 insertions(+), 11 deletions(-)

--=20
2.43.5


