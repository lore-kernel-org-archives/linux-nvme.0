Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA117C021B8
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 18:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=culURc658vVmanTo+XYHxzDv6Z18DgPKZ90+OM6pNpo=; b=klSFPwT8Hm7ojX/c/2sQK7Whlx
	oaiaP1bZtBP029BIZZIYTtwvGzVrTmowsIBeohUjnCdSAk0eRf/huVCjpr4EXKGhwzwk5bskFNL1D
	6UyxUiQOgg3kzmoy+ZMKZiODaUa3v20EU4510tKot+mC1hYE/sqDnqpHhzWoW1iOVoQmdkqEFHGzL
	jp6owO1MmC5mgjw9CD4PVnjz1ipAE7cY5RT+2TX3WTTE1w0eQO/5J79FWBfYm4rJ6IwJjTxO/V+Pe
	GLmnPvumsS09untlulTE6uYKtTiWJ3h4ttvhztuXNNpHQCGF1A1qTwuT2sKkusVGMa8JiU7gJgWN1
	PW8kFozA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnM1z-00000004uoE-1b9b;
	Wed, 26 Feb 2025 18:21:15 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnM1x-00000004umW-37g3
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 18:21:14 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QEmgYM003813
	for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2025 10:21:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=culURc658vVmanTo+X
	YHxzDv6Z18DgPKZ90+OM6pNpo=; b=kDBN0UGx/yolLikJbs+sFXOujrCeB3A6x+
	PjfJNLBdR5Iqwtma1wCcbOd4tPgyiuzeLveB3UjeNc9Sedy3a/66LJKgDfcKJ0Tc
	d2FkKzVS3r2k85bGzL5JkZtg/mF9p0ZvjfQ/unZhImTthnRdhAYF2/a1a7ZaelNL
	x7mgohUtDJnejrRlKKba22wL77mWOTjmo54pka+HZt0kQIaG2A7sk4UzEinwYEk3
	2u1JvU9HpMueyJqA4ZZXLdOUY3a+avIdy//qr7s4SPD2Vub8mNiiv7snbC10f66Y
	iWbpXkesB0+Vygz73qqgYTqFAaPwNmjKg8pvhDlB28ct8pDjnlwg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 45251shpbr-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2025 10:21:12 -0800 (PST)
Received: from twshared53813.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 26 Feb 2025 18:21:00 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id AAB85187C82C3; Wed, 26 Feb 2025 10:21:04 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <ming.lei@redhat.com>, <asml.silence@gmail.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <bernd@bsbernd.com>, <csander@purestorage.com>,
        <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv7 0/6] ublk zero copy support
Date: Wed, 26 Feb 2025 10:20:55 -0800
Message-ID: <20250226182102.2631321-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: KfI6s2iO61LPNuky2QwGfby3WY7chZq2
X-Proofpoint-ORIG-GUID: KfI6s2iO61LPNuky2QwGfby3WY7chZq2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_102113_903331_321877C0 
X-CRM114-Status: GOOD (  10.76  )
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

Nothing's changed from intended v6. This just fixes up the directory for
the mailed patch set.

Changes from v5:

  Merged up to latest block for-next tree

  Fixed up the io_uring read/write fixed prep to not set do_import, and
  actually use the issue_flags when importing the buffer node (Pavel,
  Caleb).

  Used unambigious names for the read/write permissions of registered
  kernel vectors, defined them using their symbolic names instead of
  literals, and added a BUILD_BUG_ON to ensure the flags fits in the
  type (Ming, Pavel).

  Limit the io cache size to 64 elements (Pavel).

  Enforce unpriveledged ublk dev can't use zero copy (Ming).

  Various cleanups.

Keith Busch (5):
  io_uring/rw: move fixed buffer import to issue path
  io_uring: add support for kernel registered bvecs
  ublk: zc register/unregister bvec
  io_uring: add abstraction for buf_table rsrc data
  io_uring: cache nodes and mapped buffers

Xinyu Zhang (1):
  nvme: map uring_cmd data even if address is 0

 drivers/block/ublk_drv.c       | 119 +++++++++-----
 drivers/nvme/host/ioctl.c      |   2 +-
 include/linux/io_uring/cmd.h   |   7 +
 include/linux/io_uring_types.h |  24 +--
 include/uapi/linux/ublk_cmd.h  |   4 +
 io_uring/fdinfo.c              |   8 +-
 io_uring/filetable.c           |   2 +-
 io_uring/io_uring.c            |   3 +
 io_uring/nop.c                 |   2 +-
 io_uring/opdef.c               |   4 +-
 io_uring/register.c            |   2 +-
 io_uring/rsrc.c                | 280 ++++++++++++++++++++++++++-------
 io_uring/rsrc.h                |  10 +-
 io_uring/rw.c                  |  39 +++--
 io_uring/rw.h                  |   2 +
 15 files changed, 389 insertions(+), 119 deletions(-)

--=20
2.43.5


