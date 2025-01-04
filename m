Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A6CE77188
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jan 2025 13:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8JmZV9MRuO2kKUUks8MvUz8N/xAfhkT3hAUuevrNhz8=; b=Nlf+8AxntM7HB9Pl4HFWZaQV71
	zNkNKon2Juy/pXTrnV8xFKqxV7woPLyRCS6aZj4rljDh5dn6umIGqeax7DPbB5aCxFAQVrse/1JVN
	h0twW5126CaDw58B2ItQEN67r/GuPeDE3GptmOyZJJD2q8iAlHTQESigkxjrkRyKyY/3CPwtSmkBb
	M/aqybkc9r8Y9lmr/VEfSdnZY0FBgVnlbPbPx720BCReKRm7ZlYLdscC8CWjDNGYpU5Z3A45der5R
	YxLUTiqjtqXgfg7DVQdcc7jYHGP2gvV9mmEiSaqbSX16Gp6j35NyrTCf0eM7CXXyzE5X2G4HA1+uY
	QKBdefZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tU4AJ-0000000F2i1-13gI;
	Sat, 04 Jan 2025 13:26:07 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tU4AC-0000000F2gn-1HKx
	for linux-nvme@lists.infradead.org;
	Sat, 04 Jan 2025 13:26:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4286B5C545D;
	Sat,  4 Jan 2025 13:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA960C4CED1;
	Sat,  4 Jan 2025 13:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735997159;
	bh=har1/GhEcZrPJFeBVnIml94XvalIgKbFhgx19QnyqSs=;
	h=From:To:Cc:Subject:Date:From;
	b=YNJAs4Po56ImaJXQNeMoij9BIPW0FM8b8wd2994m93QnXpf5MiI4kWPBw7m43S8Mb
	 Hjg/mngVTH5CuY+G7c6/xiewDKFBErFFh5IzO3NuxFtI7VbhwyOvYrOh14QuVgh2UG
	 WPlsTRYtL+gHrZT9ttV/bLp804db09LNgeIP81LeqZXQcSYELBOQaMGigsVHsf6ohR
	 XbGpGE26OjVJ7CdRYeHnYwMGxTFS8o55Mlxe195s0ciHgebz15gLfodRjDer3Nx2M9
	 PxJdiSM9z/7ekWDGSG0ks5Oq1Xe2iphSrygjIhu61C72ZEzpKvzXjbKGgS1b5Rb2rz
	 HKRSXAu7f6D2g==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 0/3] Fix queue freeze and limit locking order
Date: Sat,  4 Jan 2025 22:25:19 +0900
Message-ID: <20250104132522.247376-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250104_052600_397595_5B1F9263 
X-CRM114-Status: UNSURE (   9.13  )
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

Three patches to fix the ordering of freezing a queue with
blk_mq_freeze_queue() and obtaining a device queue limits lock with
queue_limits_start_update(). These changes ensure that a devie queue is
always frozen after the device limits lock is obtained to avoid
potential ABBA deadlocks in drivers that need to issue commands to probe
a device limits with the limits lock held (e.g. the SCSI sd driver).

Damien Le Moal (3):
  block: Fix sysfs queue freeze and limits lock order
  block: Fix __blk_mq_update_nr_hw_queues() queue freeze and limits lock
    order
  nvme: Fix queue freeze and limits lock order

 block/blk-mq.c           |  25 +++++---
 block/blk-sysfs.c        | 123 ++++++++++++++++++++-------------------
 drivers/nvme/host/core.c |   8 ++-
 3 files changed, 85 insertions(+), 71 deletions(-)

-- 
2.47.1


