Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67730D6407B
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 19:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6okj447WixbNNhNQHaA9DEOarhvhg3oKtVsSwQCEn3Y=; b=W4RuagK4b499GFXvQsmyU2kNy5
	DfSNzw+vj6PtcOnOq8m5TTm3ApLLuOFlQvGFB7L64l8JG1u32pyKcbDKZhi2kr8Hve217LBhXtUwZ
	oYvNJ4IlrEKLsFsIy+F95GZD0eCfFSc6faeQQV7WsX0+4xj7A9zTsZGm/yQXRXb/FazcMkZU0NHz5
	cTZ8Cd3Zn/AL1yAsEEjGR6Z/FuUEt2laLrYSPaJbcZWGSTvO57gOGmizhxaj7JqYQLKjgpAknJPqh
	hEmm8mpMJ0570uNoBVoJWmphYhaY4ZLF7sgoDNgy2dvghhblYmMsLg8DW0R/MLuQ+SgBqdwm171xe
	UA5iGjow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9Usv-0000000BlTt-2hS5;
	Fri, 08 Nov 2024 19:43:09 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9Usq-0000000BlSa-3bnT
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 19:43:06 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8IANqR004929
	for <linux-nvme@lists.infradead.org>; Fri, 8 Nov 2024 11:43:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=6okj447WixbNNhNQHa
	A9DEOarhvhg3oKtVsSwQCEn3Y=; b=RhE734FeexQvP2U1/uC+/vT3UbmmyFSZTM
	t6gNuFDeljwFO4jwyriPVo/Z3MCFa2XrL5kQJeuxBIkYwLR/mfpEC6mdWzISpHeF
	BLc70a91dCVA6Mj51ps0q4sHzLVLoRGMWdevQ2ZF8SWqiwEw/KANbr3Lg/apws1i
	bFW8XpENiSQmwfY652E+abHV8lxjGQ4zGTwBNQbVnM81IHgPIhPZMyNi1aL00Box
	JyXPtvbD/KIwwQ6dO2KSs9bSvt/x92rzotW2OymXKnZ0yhfDBkO1qfA8l6exs7ct
	NV7N1daP8VwsO2MOwRABrflZdZTdDI4XFIyPvZxHqY98amJToO/Q==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42sqpc0qye-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 08 Nov 2024 11:43:04 -0800 (PST)
Received: from twshared29075.03.ash8.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 8 Nov 2024 19:43:00 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 35FAE14E3A027; Fri,  8 Nov 2024 11:36:58 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>, <axboe@kernel.dk>
CC: <hch@lst.de>, <martin.petersen@oracle.com>, <asml.silence@gmail.com>,
        <javier.gonz@samsung.com>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv11 0/9] write hints with nvme fdp and scsi streams
Date: Fri, 8 Nov 2024 11:36:20 -0800
Message-ID: <20241108193629.3817619-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 5Vrgcy13xXq7u1CIprcGerDKgsSxOKxm
X-Proofpoint-GUID: 5Vrgcy13xXq7u1CIprcGerDKgsSxOKxm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_114304_933858_506D443B 
X-CRM114-Status: UNSURE (   8.19  )
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

  Fixed FDP max handle size calculations (wrong type)

  Defined and used FDP constants instead of literal numbers

  Moved io_uring write_hint to the end of the SQE so as not to overlap
  with other defined fields except uring_cmd

  Default partition split so partition one gets all the write hints
  exclusively

  Folded in the fix for stacking block stream feature for nvme-multipath
  (from hch xfs-zoned-streams branch)

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

 Documentation/ABI/stable/sysfs-block | 14 ++++++
 block/bdev.c                         | 22 +++++++++
 block/blk-settings.c                 |  5 ++
 block/blk-sysfs.c                    |  6 +++
 block/fops.c                         | 31 +++++++++++--
 block/partitions/core.c              | 45 +++++++++++++++++-
 drivers/nvme/host/core.c             | 69 ++++++++++++++++++++++++++++
 drivers/nvme/host/multipath.c        |  3 +-
 drivers/nvme/host/nvme.h             |  5 ++
 drivers/scsi/sd.c                    |  2 +
 fs/stat.c                            |  1 +
 include/linux/blk-mq.h               |  3 +-
 include/linux/blk_types.h            |  4 +-
 include/linux/blkdev.h               | 15 ++++++
 include/linux/fs.h                   |  1 +
 include/linux/nvme.h                 | 37 +++++++++++++++
 include/linux/stat.h                 |  1 +
 include/uapi/linux/io_uring.h        |  4 ++
 include/uapi/linux/stat.h            |  3 +-
 io_uring/io_uring.c                  |  2 +
 io_uring/rw.c                        |  2 +-
 21 files changed, 263 insertions(+), 12 deletions(-)

--=20
2.43.5


