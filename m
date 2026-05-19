Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF18CCD4F5E
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 17:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DgSDBglcHMWndZa8iapvzamBLG1cvjdm8KJL+W9JABU=; b=UXCxEKvOOo3v7zIjngZkjdq7oL
	8KCY+5xE2/ieZgIbKyC7efGNei/wivWB+yjJwDjIRIdThar2NPS30e7MPX+bQlkIxoXzcN3i1Abui
	lwuyHHgf9TZmxjggscpIHcMaCRvrMf3xHbSPa363D6bFl0327IhrEy2JKgakjbIWVOI7Ma75yjP3D
	SbMgJ6TjdJfcnbels6RnJRpUgHxJ3FvuLr5aErK1Au5SFA9vwbtmjgAtKhB6wGTxdSM7y+p+DvxB8
	Dp5scdGrFj+ZvMAkKXVCJcdX05fNmEmSMiAcFcrUp1o09w4RmKqRIkdCFZOV+bb4atMteedUD9GME
	/bcpz3ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPOAv-00000002Nje-0abj;
	Tue, 19 May 2026 17:24:13 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPOAr-00000002Nen-1Rv6
	for linux-nvme@bombadil.infradead.org;
	Tue, 19 May 2026 17:24:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=DgSDBglcHMWndZa8iapvzamBLG1cvjdm8KJL+W9JABU=; b=qhNrg+pEm4OGQa7LE8d4o3SxDM
	wQzAdaHUQKkRNzp9vn0EsXs1WFSlY1wiybQZjVkWL7slZ5bV7XX4abimTLmlhi/CP5QSU6QrpjjBg
	j3ODP0x+cRJhOPKeAtrqZzjidi5lePqK3X/pJnZfHtZF4mxXq5GWP0bBgbYPbwujrTsk72b1HKOI/
	QTliUh0iQcLMS7JTzpuCx3V4sdqji1lSBIGnwflC3m/RhW4k9f2Y8hTqnSYgc1PpEg2o62J9zkbRK
	m5bKZf61MFJZ4dQ9sgYZxZsFmEroQyC7nBPL2t7N8MvoAYlT11jVhhPGTX7i1yZNPu5kV4m3pAAKG
	vl2aIZ2Q==;
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPOAn-0000000EvKB-47Bm
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 17:24:08 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J4VXVT182059
	for <linux-nvme@lists.infradead.org>; Tue, 19 May 2026 10:24:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=DgSDBglcHMWndZa8ia
	pvzamBLG1cvjdm8KJL+W9JABU=; b=GxE2RR/8JD5zU7w9Lgemx3/pXoABU3tt4j
	CtJzH2OWlZ9i077DrdPmoqqEW60ZmsP3G8+8BvlsQiBFL9h17piNaq5er6mzTciL
	QTrhyMC1N89a5KmOiAHZzguSaRwKuzEk6KVw/5pfEotipKwZAapl2ij2q0MsUuti
	QJaeuzargJbeamXKq8ULSsGPgBvSDVEWGiUZ2vsXZe7oZnFZCH0UKE5/jTYbSpV+
	Xj4XeiZ8TVJ3fOye0BSIqplZLc5S6YQp7pAdNtItplHZDLZ+HXPeJaoWiPuMkT7p
	lbLK2r6+c28nk+uaLHCiDWfc6XL88GAyqoW9ygODK2un0xMQCBNQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e6p3bskgw-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 19 May 2026 10:24:04 -0700 (PDT)
Received: from twshared132777.16.frc2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 19 May 2026 17:23:54 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 0BCA41A75976E; Tue, 19 May 2026 10:23:31 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <tom.leiming@gmail.com>,
        <coshi036@gmail.com>, <Igor.Achkinazi@dell.com>, <dlemoal@kernel.org>,
        Keith
 Busch <kbusch@kernel.org>
Subject: [PATCH RFC 0/5] block: validate bios against queue limits in the entered context
Date: Tue, 19 May 2026 10:23:21 -0700
Message-ID: <20260519172326.3462354-1-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE3NCBTYWx0ZWRfX9HuW5dnruf7d
 Gy+eCBzgg7fyO8GJf/5kvz/LyOqFjt+qAaCwBnibgJOVWXtfH4j8UTNFeW2WcVPZvtvncjQOCGF
 Upfdx5K3YTinZ1p748ntLaRYohj1TLRnklktm3NSiuqw4DTKkHbiIUKIpUxWQmq4wqghKzTQGGz
 BFKTf4qqy0/3bxqtymFh5Ut4QIFaCFMeN44UT6fLS8Eszetrxyprcj+FVryMNuN8jNUgZu69LAG
 xEu+xusHP4g9uUEKJnxtBs1Q+d80k0p95ULGwxM/aP1wMlk5Dcfslf0avarJZ6J5BWQ5FTyu1S1
 eedDLyWKagpVzBrsfEuetfa8kN9OGZCrt9MS5v1TkMwPUXbA42EShXrD6iaCPUpMZv5UXX/QWqf
 d4dbrSx6pazOxNsk80p3kRjDBqG6ARTN1XVCsJjNQ0JWaIVHMJ9gXczA258hqN8b8Wky8lUGCdI
 3xWFdzqVMCgGqcwOaPg==
X-Proofpoint-GUID: fRYVvoXGJtBfGPLvGzOTwL-QqPnaj6Td
X-Authority-Analysis: v=2.4 cv=K6cS2SWI c=1 sm=1 tr=0 ts=6a0c9cb4 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=JnKecZnUtZousrUlYMGU:22 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8 a=pGLkceISAAAA:8
 a=CmBJLTqHQE19MeuuKJcA:9
X-Proofpoint-ORIG-GUID: fRYVvoXGJtBfGPLvGzOTwL-QqPnaj6Td
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_182406_553591_93489785 
X-CRM114-Status: GOOD (  17.85  )
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

The block layer validates bios against various queue limits and device
capacity in submit_bio_noacct(), but these checks run before
bio_queue_enter(). This means they are not serialized against drivers
that update queue limits inside a freeze window. A bio that passes
validation under old limits can enter the queue after the update and
reach the driver with an invalid configuration.

This series moves all limit-dependent validation into
__bio_split_to_limits(), which runs after the queue usage reference has
been acquired. This ensures proper serialization against limit updates.

This changes was motivated by a few recent reports:

  https://lore.kernel.org/linux-nvme/MW5PR19MB548483D1FAE4F322E4C97352FD0=
32@MW5PR19MB5484.namprd19.prod.outlook.com/
  https://lore.kernel.org/linux-nvme/20260517053635.2282446-1-coshi036@gm=
ail.com/

When an NVMe namespace that is reformatted to use extended metadata that
can't be controller generated/stripped, the driver sets capacity to 0
inside a freeze window because the block layer is not able to form a
viable request for this format.  But a bio that passed bio_check_eod()
before the freeze can still reach nvme_setup_rw() after the update,
triggering a WARN that we didn't expect to be possible of reaching.

For NVMe multipath, moving these checks into the entered context
exacerbates a different problem: a bio targeting a path being torn down
(capacity set to 0) would be failed by the block layer before the driver
gets a chance to redirect it to another path. This is a pre-existing
problem, but the initial changes in this series make it easier to hit.
The series addresses this by introducing a new callback to
block_device_operations, called from bio_io_error(), that lets the
driver intercept and redirect failing bios before they are completed.
NVMe multipath uses this to requeue bios back to the head device for
path re-selection when the path is no longer ready.

Note that callers of submit_bio_noacct_nocheck() (bio split, throttle
dispatch) will now hit the validation checks in __bio_split_to_limits()
that they previously bypassed. This is intentional: these checks must
run in the entered context to be properly serialized, and cannot be
skipped so it is a performance cost that can't be avoided.

Keith Busch (5):
  blk-mq: fix status for unaligned bio
  block: fix invalid zone append status codes
  block: validate bio bounds in the queue entered context
  block: move bio operation validation into __bio_split_to_limits
  block, nvme: add failed_bio callback for multipath bio failover

 block/blk-core.c              | 144 ----------------------------------
 block/blk-mq.c                |   3 +-
 block/blk.h                   |  89 ++++++++++++++++++++-
 drivers/nvme/host/core.c      |   1 +
 drivers/nvme/host/multipath.c |  26 ++++++
 drivers/nvme/host/nvme.h      |   2 +
 include/linux/bio.h           |   6 --
 include/linux/blkdev.h        |  16 ++++
 8 files changed, 133 insertions(+), 154 deletions(-)

--=20
2.53.0-Meta


