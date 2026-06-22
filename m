Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16196CDB470
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jun 2026 10:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VzqHiJHUtGCmV8nuT/8fkwjWn0zDgWRiZ/4+xv5qAqI=; b=NiA9eHCqi/JlncO5MTt13NACr+
	EXHmq1S0rKTxrEBEjFNyh3Y9XENO62f52Xq6HqHjxmN1F4gY/vYmTf1eMiFRqGLcasWz4w5ia2Rtv
	M93VVS7LZK0yV49L/OfDmDeDWydhfGrARsX2XxOqdBzUvu4e8pNUmaotD8xsqT6VLggMaBJePhtMi
	0kQXUMLRpVBjwgSeJGGb/7JbUhviiQGVNGc1h0GWrZ6nRlbWvtfPDZvCBMiFnm487HZYL2m0UWICb
	iw2pwm6DHcvuWmdSWNbWa1jbCVMmcxfiH/dOp7xK0YXvUX7OBAEEBDNbLp5VKbUaHvkzuCc/qNw7X
	aeYJSUTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbc8l-00000004qqg-0nL3;
	Mon, 22 Jun 2026 10:44:31 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbc8j-00000004qqF-01ub
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jun 2026 10:44:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782125066; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=VzqHiJHUtGCmV8nuT/8fkwjWn0zDgWRiZ/4+xv5qAqI=;
	b=L/fp4qi7wpDWGi5+OfTgbsLq35VwRSfLmLY1p9lKT3LC6P159rCqAzYYWVIXolmZD8LqQ0PdFMiiWimrZnsp1eBIBNr0trGfXDxeVDglplydY4wxiLylVedf6zjhEnbPPPvqv7XFgPt/QxE0tzRvqH8jma/q9Hr+XcfzwwwFBZc=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X5M.r2G_1782125058;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X5M.r2G_1782125058 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Jun 2026 18:44:25 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 0/2] nvmet: add namespace-level debugfs for reservation state
Date: Mon, 22 Jun 2026 18:44:16 +0800
Message-ID: <20260622104418.2070277-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_034429_221965_E697E164 
X-CRM114-Status: UNSURE (   6.56  )
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

This series adds debugfs support for inspecting NVMe target reservation
(PR) state at the namespace level.

Patch 1 introduces per-namespace debugfs directories under each subsystem,
providing the infrastructure for namespace-specific debug entries.

Patch 2 adds a 'reservation' file that exposes the persistent reservation
state including enable status, generation counter, holder information, and
the full registrant list.

Example output with two registered hosts and an active holder:

  $ cat /sys/kernel/debug/nvmet/testnqn/ns1/reservation
  enable : 1
  generation : 2
  notify_mask : 0x0
  rtype : write_exclusive
  holder : hostid=11111111-1111-1111-1111-111111111111, rkey=0x1111
  registrants:
    hostid=11111111-1111-1111-1111-111111111111, rkey=0x1111
    hostid=22222222-2222-2222-2222-222222222222, rkey=0x2222

Guixin Liu (2):
  nvmet: add namespace-level debugfs directory
  nvmet: expose reservation state through debugfs

 drivers/nvme/target/core.c    |  2 +
 drivers/nvme/target/debugfs.c | 75 +++++++++++++++++++++++++++++++++++
 drivers/nvme/target/debugfs.h |  5 +++
 drivers/nvme/target/nvmet.h   |  3 ++
 4 files changed, 85 insertions(+)

-- 
2.43.7


