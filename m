Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F394CCF2D3
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 07:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MVtTxCBEl2jKgEbJ+rhC97/VNjZ3AZ2y+AYIwfmjHWA=; b=GY8oIFvIcaP20MeZKg98/Dc/o3
	LjijQLBFVxlp0MznDwZazI7BmzkFIK4JYTIu5/1LV4/omd5vLOeqqzNZiJBIbnE33dKKZbULZkxXA
	tcgQAkB1JcasiellOwPnIxRznfxvmzdXCN6yNwIjY9Y/8E8qHRHEpcoBFVONavBb+PieGKBYvUsb8
	+lTd7rlGH1TSFHQ/HBPIz0g4KX6JLGZ7gf+oVqz7MCncqDkYSU+sU5CgDTaaSHkS3s+7oIHokNQxL
	OW8e22/sbX9FNpQ3PZHvDYeai9UJTebJN9n6RtmY6LwgMITZ9RQFaEgUTF56GpTT9Pl4J10liZMrW
	L3yQQsfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIiEG-00000006nix-2nI7;
	Mon, 19 Oct 2026 07:56:20 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIiEC-00000006nfI-0vLI
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 07:56:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792396574; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=MVtTxCBEl2jKgEbJ+rhC97/VNjZ3AZ2y+AYIwfmjHWA=;
	b=xY3p+QBT62/kwJ4l5DNY6GjKIphLwJATMQ/ZYB+GGAjfwSGUnpnrsTXbBfvtDUPQ2EbAyOiGYY2WUel/M7RoWdB+EJjBZ52F2oTn0gcMZ+7Dm71ZPywFXunSVCJ8xR003uXQY8lYEtKLhAq3MCnjGYmDbmfXi5OaJjPqS5A9IsU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XD1nmSR_1792396572;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XD1nmSR_1792396572 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 Oct 2026 15:56:12 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 0/3] nvme: introduce the service-time iopolicy
Date: Mon, 19 Oct 2026 15:56:02 +0800
Message-ID: <20261019075607.808947-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_005616_944594_0BED8CE7 
X-CRM114-Status: GOOD (  13.00  )
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

The queue-depth iopolicy counts requests, so a 128K I/O weighs the same
as a 4K one, and it cannot express that one path is simply faster than
another. This series adds a service-time iopolicy for NVMe native
multipath, adapted from dm-ps-service-time: it picks the path with the
lowest estimated service time, in_flight_bytes / relative_throughput,
so balancing follows actual bytes in flight and per-path throughput
weights.

Weights live in a per-path relative_throughput sysfs attribute (0-100,
default 1, 0 makes the path a standby). Patch 3 documents the new
attributes in the stable sysfs ABI; patch 1 carries the benchmark data
in its commit log.

Changes since v1:

- Rebased onto v7.3. iopolicy parsing was refactored into
  nvme_iopolicy_parse() in the meantime, which picks up the new policy
  for both the module parameter and the per-subsystem attribute.

- The comparison helper now returns a sign-safe -1/0/1. The in-flight
  sizes are 64-bit, and returning the plain difference truncated to
  int can report the wrong sign once loads grow. Selection is
  unchanged in the ranges the benchmarks cover.

- relative_throughput now defaults to 1 in nvme_mpath_init_ctrl().
  v1 re-applied the default on every controller reset in
  nvme_mpath_init_identify(), which silently re-enabled standby paths
  after routine reconnects.

- Dropped the unused "incoming" argument of the comparison helper.

- Added ABI documentation for in_flight_bytes and relative_throughput.

On the adaptive I/O policy dependency Hannes raised during v1: that
series has become the latency I/O policy and is still under
revision, so this version stays on plain master. The two are
complementary: the latency policy infers path speed from observed
completions, service-time takes configured weights and byte counts.
I can rebase once the latency series lands.

Guixin Liu (3):
  nvme-multipath: implement service-time iopolicy
  nvme-multipath: document service-time iopolicy
  nvme: document the service-time iopolicy sysfs attributes

 Documentation/ABI/stable/sysfs-nvme          |  22 +++
 Documentation/admin-guide/nvme-multipath.rst |  31 +++-
 drivers/nvme/host/multipath.c                | 162 ++++++++++++++++++-
 drivers/nvme/host/nvme.h                     |   6 +
 drivers/nvme/host/sysfs.c                    |   5 +-
 5 files changed, 221 insertions(+), 5 deletions(-)

v1 of this series:
https://lore.kernel.org/r/20260617114602.2224074-1-kanie@linux.alibaba.com

latency I/O policy v7:
https://lore.kernel.org/r/20260809100825.2014133-1-nilay@linux.ibm.com
-- 
2.43.7

