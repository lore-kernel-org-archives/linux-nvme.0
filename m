Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F01606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2026 01:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ie2lQes3;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=coCCo1Uh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=8e/IpuSYW9d0QekEXFx6bT2Oe0C5XCSMgDyLhp7uw80=; b=Ie2lQes3oTsH6jpwpEc/3Gtzgn
	mgRhIn7pmDG/WZyF/lYVacejOJwKLVs2xlUY0gXWoDzQxuG/YNJjnv4sjoIQh4wGKY7Nkpg5kiXNp
	7xz0dq1qbt6tzd/yXG03Z3f2Kyd6s2xCrR0y/MtttGUineBNCLxlSU12oaTjWeF3a116SDVLBEKfz
	tGbYP05iHCtg1KRTV2urzXSdhl7YquD3uBHpYg344X+SNNYTp/UR8SGpBK+Pd5gOADqGivSBJnPgw
	3XSq7b4h1omYsb62ZOtQWEAhABQCc6XG+KwBm8o/top4t1TbWxQ2l5RrMQUo+9UQiBN+2RKbVAK8w
	jzUfM3Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMbgo-0000000Ad0A-2ZoN;
	Fri, 30 Oct 2026 01:45:54 +0000
Received: from mail-dy1-x132a.google.com ([2607:f8b0:4864:20::132a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMbgl-0000000Aczh-200V
	for linux-nvme@lists.infradead.org;
	Fri, 30 Oct 2026 01:45:53 +0000
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-36a1947498bso451093eec.1
        for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 18:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793324750; x=1793929550; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8e/IpuSYW9d0QekEXFx6bT2Oe0C5XCSMgDyLhp7uw80=;
        b=coCCo1UhUtD4BoQU7r55ZW5/0cuUF+lNLDPGn8THElb5mgEnVNdK3DjLSsGpMggf1J
         QjfBEiDOuZ4J9e1LgWrOGoBxdGWvoZlKOA7WZTZQ5N5SXMpLNJticJyL8HSnIGcf2skk
         640RxQ6J5m1zxlXBieHYzLwMuY9Sj9Ygy0U/jxwEPH9vUGC1LYUS3ggB6jLbG/BWdyc0
         L4FR56dSmu3QWI9ja2U49XJKNsYzN5Z3Sab5cYC4lrHvYkQyQOL+d1mbYsN1cc4yqYsX
         8MjbVW3Mbr2bjFEK72rJsSbHPheedSAWiw37KsJowuPhcMX6H9niByC/B0xqxym6F33u
         LR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793324750; x=1793929550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8e/IpuSYW9d0QekEXFx6bT2Oe0C5XCSMgDyLhp7uw80=;
        b=f6hzCIJZtt8/0G4Bb5aN12Om6D3xM0q+flj6zmSpnAKRr6lqaOns1nBpp5vf+qWi08
         F6c/wzGEhRX7969Egf0EOCHFTpkpklJYuVZm+7AKhU0f/wtafKCJTLXTsFA2gM4HdbIe
         HKfrY4bqRvp9cvCddoEgY1XHWZvdAQPL8hutDyJzEf/uzTWmzFAfJg6hj6NoXl2AGsiV
         14kd++5mxE3NofAvxIKcshd959PIc5Bn/Td9udmFHwQbQBswtiELRKRSXklM7WXqjusv
         cRlXivx9mgOqzmU9fIzroLeXdsLHIu7FjMybKg5KCytC57hHa9pRsf5kOGbODXRF17Ox
         cWFw==
X-Forwarded-Encrypted: i=1; AKwUvBzrzNgQNw2DBISNsj9jwqB50EexLR/4fwdSoYImevbz0Zp/Jw9VlAdUkURfcM+sL3OdKa4E5EyBmNrk@lists.infradead.org
X-Gm-Message-State: AFq9FYJvAqR3lyYlqKLMMzCSO8Bq/PXMUlgMUBKzz1yrRPeAY0hzs0W0
	NVMwnmeDeDF93Rnhbrtgd144YGScpUPkOE2kU9zO1bigrIeU13b30nc=
X-Gm-Gg: AYBFou1FixMqWfLmTk94k10YQMLNNTAK1vESN677b1M2OQoX6uStv85f/I4JPxzpuLU
	ZH7gvE0nLq5gquO1ukzMXQQAvxYvdJapV+cIqHAHusmbLQjz1+hPGcuvu4Qk1U6IaoeV0bL0++w
	YJdXEd3tzw8UKeuB9QJMS8bveQLtlwQih5A48d4bmaKioUMLeUsmv8t749JqxFpwMhmBUJdhJ9+
	yzStekI0ZZechG1hxw1o8xPYK4otQkhV9erUwBezDcOZljI+NjWqUq7nb3ampw6pet8EpRX5Esz
	xiOj+arcbCOzgOlfeQQMvm+NFgr+HSubVvrs2d5TKG8SB05/m/d8A6DcPjck460amE35tH6ba+y
	5MnBvs5hrzn2VkIaGckrqBJ4IqcOSvpHlxdViUq1KUUFmsFYpDYqZlCX1UGbXYHT1l5QXHX4I8F
	SpRuVntdmcA21mYFe1jppSPt6Ti7I3yIo6EQaHLINdxneg6btjQWs+aVb9cRXqUeumH/ohZi12l
	pZjFOtAWvH6vyYceLIf00UbBeaSCGgREeUcl9yinNlNPortduLn4fdcPRdGGcC1CqPCNAzCjT2n
	ecY+UknLSkbx6UYVW6SbZ4hc76k9kOd0YJXYVvxr+H28PlkbMnLTTrMO572Y7TkEKcXLtS5bExb
	cFOo6xD6yz1Pb2AzYHh9K44sjGd/LQ4A3em6t2Q==
X-Received: by 2002:a05:693c:8806:10b0:369:f97f:72c1 with SMTP id 5a478bee46e88-36a4241bbd5mr1678012eec.36.1793324749832;
        Thu, 29 Oct 2026 18:45:49 -0700 (PDT)
Received: from anuj-MacBookPro.. ([2406:7400:63:75fd:f9a4:4062:7980:1324])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428fa380sm2209020eec.12.2026.10.29.18.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 18:45:49 -0700 (PDT)
From: Anuj Gupta <anuj1072538@gmail.com>
To: axboe@kernel.dk,
	asml.silence@gmail.com,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	James.Bottomley@HansenPartnership.com,
	mkp@kernel.org,
	bernd@bsbernd.com,
	joannelkoong@gmail.com,
	miklos@szeredi.hu
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	joshi.k@samsung.com,
	anuj20.g@samsung.com
Subject: [PATCH v3 0/5] dma-buf backed NVMe passthrough I/O
Date: Fri, 30 Oct 2026 07:15:35 +0530
Message-ID: <20261030014540.3065403-1-anuj1072538@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_184551_617858_CE278B10 
X-CRM114-Status: GOOD (  10.94  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds support for dma-buf registered buffers in NVMe
uring_cmd passthrough.

Patches 1-2 add import flags to the fixed buffer import helpers, so
uring_cmd users have to opt in to dma-buf. Patch 3 adds the io_uring
side, patch 4 lets the block layer map dma-buf iterators for
passthrough, and patch 5 enables it for the NVMe namespace character
device.

Tested with this liburing test:
https://github.com/anuj7781/liburing/tree/rw-dmabuf-pt

Changes since v2:
- return -EOPNOTSUPP when the controller has no dma-buf support (Pavel)

v2: https://lore.kernel.org/linux-block/20261022144501.2478417-1-anuj1072538@gmail.com/

Changes since v1:
- split into io_uring, block and nvme patches (Christoph)
- pass import flags to io_import_reg_buf() and
  io_uring_cmd_import_fixed(), and make callers opt in to dma-buf
  (Christoph, Pavel)
- add io_uring_cmd_hw_done(), so nvme no longer handles the dma-buf
  map (Pavel)
- warn if task_work is queued with a dma-buf map attached (Pavel)
- make the -EREMOTEIO conversion explicit and comment it (Christoph)
- refuse dma-bufs larger than 4GiB on the character device

v1: https://lore.kernel.org/linux-nvme/20261016103453.1129150-1-anuj1072538@gmail.com/

Anuj Gupta (5):
  io_uring/rsrc: pass import flags to io_import_reg_buf()
  io_uring/uring_cmd: add import flags to io_uring_cmd_import_fixed()
  io_uring/uring_cmd: support dma-buf registered buffers
  block: map dma-buf iterators in blk_rq_map_user_iov()
  nvme: support dma-buf registered buffers for passthrough

 block/blk-map.c              | 15 ++++++++++++++-
 drivers/nvme/host/core.c     | 16 ++++++++++++++++
 drivers/nvme/host/ioctl.c    |  5 +++--
 drivers/scsi/scsi_bsg.c      |  2 +-
 fs/fuse/dev_uring.c          |  2 +-
 include/linux/io_uring/cmd.h | 14 ++++++++++++--
 io_uring/net.c               |  6 +++---
 io_uring/rsrc.c              |  6 +++---
 io_uring/rsrc.h              | 13 +++----------
 io_uring/rw.c                |  5 +++--
 io_uring/uring_cmd.c         | 31 +++++++++++++++++++++++++++++--
 11 files changed, 88 insertions(+), 27 deletions(-)


base-commit: 70866cfa169d5ee149364267289e71d50f9a7ae9
-- 
2.43.0


