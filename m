Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83D0C54E65
	for <linux-nvme@archiver.kernel.org>; Wed, 21 May 2025 22:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4OMSpxN4Zzouf3D4WwvIxwz73dA7VLEPMQUs1MZ4RTA=; b=4blmjDe/mQrTIO+t0k4Cp0pfH8
	GvxTCo1s09SAohBjoNKiubxUZWYxxhgs1uHALZHOi2ANGry0h5pz/lu/QieB1drWPJZltzb2JIlhZ
	HOn9hWz8GU2VfZLuYwyWj6gEY96S116A6tL0dsOcIsz3EP8a4/kWvyH6VH11XjgrNYwphRuhQRxcA
	sj/e07+Z5267fvJ3C6TILhZUix/3W+8HhjRF3kTke/P/3hCAHqzfgoMN+sF5fBYv3dzvjUxfd8HXO
	SRuu5G/6j+hCZ2ydZXvlz2hQKODRQxIV8aPJGbMfoRYsoAqdk+BHuBpuo6rzLh8JNObNCaTZaYG6t
	b9sxbsAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHryD-0000000Gvlv-3lQG;
	Wed, 21 May 2025 22:31:29 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHryB-0000000GvkE-1FPi
	for linux-nvme@lists.infradead.org;
	Wed, 21 May 2025 22:31:28 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LMQWgG029158
	for <linux-nvme@lists.infradead.org>; Wed, 21 May 2025 15:31:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=4OMSpxN4Zzouf3D4Ww
	vIxwz73dA7VLEPMQUs1MZ4RTA=; b=NcfymIODh7DioT1YpX5sdW/6k+uobh3YbD
	gMdgeTma9KuzLogbGEId+VnaJASttDmzDxI0YDNkznWotjNiZBOw/jLDxXt8UN+k
	K4F3dh7+C91i8+fwxbmYC5sWbZ+QNa+gESIoeqvphqgsADLseMDQw4Atm/rikn6M
	PEBaGjVn79gRl6iPmmCTRmQHIUoi/FvVWte5yfb3EqcJclS0wmH1EBc/Z6QYzZjm
	7x1RjwyYv960FCFCqhzcbr4G7CASueP3nd0mefz4+CIRS/VIl2N5aV4pHhbTAVfo
	H6pxrtHM6J+WaJmV514l7JEgE4r98ZbSI3ap6xuZQSpGqFVEl7qg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46sd06wf38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 21 May 2025 15:31:26 -0700 (PDT)
Received: from twshared37834.15.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Wed, 21 May 2025 22:31:24 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 9D2C11BE54AC2; Wed, 21 May 2025 15:31:10 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 0/5] block: another block copy offload
Date: Wed, 21 May 2025 15:31:02 -0700
Message-ID: <20250521223107.709131-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=MaBsu4/f c=1 sm=1 tr=0 ts=682e543e cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=GS0gexFe5ZxbJc13yJoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDIyNCBTYWx0ZWRfX5lD9iIyQ0XsK 6flhqgng44X8ALV8wmUqpLdw+UfD8znYkwj3DeXASWUEHt4ICUIJXGdqkyWLNB+YyMobyBmsTxp //F4rtWFqCwNdDwOWzpAxJRJ7ct0uMoMA9FFZQcoMBQMSJJ1H8+mn43QbVWj00a4OldrS7/oYzu
 OR8VDJjnameHiEp9e1NQtvEZp/Hp+EthilwMXi8jmYkXo948OXXAzkswN0etAB6fO2i/6UisldD SHqPblBppE0qpUV9rwiBUdiuirE84JZtY3jJuuYsVV+gTanvXJM3xJ9Te5XQiOAL/xGSHHZcrdT TbNIjrOAQ3U7rVkj++IbhOCzCk9fGnJfjQptih2xNk0sB+zTUahsMiKbvUcEEcMVfDhCTVdgc/c
 R4okzCisRiXAbxUPSxqb/W5BDzRDLOjZupOpb+g5UWRVgvBDZUHBHi2Fe4zeRMrkvodv7vGO
X-Proofpoint-ORIG-GUID: WAbnjpQoeYkpDbQBQrZFIYU713EOXPgY
X-Proofpoint-GUID: WAbnjpQoeYkpDbQBQrZFIYU713EOXPgY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_07,2025-05-20_03,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250521_153127_455794_4BC53648 
X-CRM114-Status: GOOD (  13.32  )
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

I was never happy with previous block copy offload attempts, so I had to
take a stab at it. And I was recently asked to take a look at this, so
here goes.

Some key implementation differences from previous approaches:

  1. Only one bio is needed to describe a copy request, so no plugging
     or dispatch tricks required. Like read and write requests, these
     can be artbitrarily large and will be split as needed based on the
     request_queue's limits. The bio's are mergeable with other copy
     commands on adjacent destination sectors.

  2. You can describe as many source sectors as you want in a vector in
     a single bio. This aligns with the nvme protocol's Copy implementati=
on,
     which can be used to efficiently defragment scattered blocks into a
     contiguous destination with a single command.

Oh, and the nvme-target support was included with this patchset too, so
there's a purely in-kernel way to test out the code paths if you don't
have otherwise capable hardware. I also used qemu since that nvme device
supports copy offload too.

Keith Busch (5):
  block: new sector copy api
  block: add support for copy offload
  nvme: add support for copy offload
  block: add support for vectored copies
  nvmet: implement copy support for bdev backed target

 block/bio.c                       |  25 +++++++
 block/blk-core.c                  |   4 ++
 block/blk-lib.c                   | 115 ++++++++++++++++++++++++++++++
 block/blk-merge.c                 |  28 +++++++-
 block/blk-sysfs.c                 |   9 +++
 block/blk.h                       |  17 ++++-
 block/ioctl.c                     |  89 +++++++++++++++++++++++
 drivers/nvme/host/core.c          |  61 ++++++++++++++++
 drivers/nvme/target/io-cmd-bdev.c |  52 ++++++++++++++
 include/linux/bio.h               |  20 ++++++
 include/linux/blk-mq.h            |   5 ++
 include/linux/blk_types.h         |   2 +
 include/linux/blkdev.h            |  18 +++++
 include/linux/bvec.h              |  68 +++++++++++++++++-
 include/linux/nvme.h              |  42 ++++++++++-
 include/uapi/linux/fs.h           |  17 +++++
 16 files changed, 566 insertions(+), 6 deletions(-)

--=20
2.47.1


