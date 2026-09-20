Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EDDC982CC
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Sep 2026 02:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SqZKxxJthjByJNOF61FIu8eTMS5rxMxdiNWYeHoqHuA=; b=InoBWbUufOAT/+jTvXjYbtJfyy
	dTliSfiZqmovL8//ObAxd35Fj9/2SpuTNNIGmYUce5WIUkPoaAWMS1DHMuTtUNRXVwfONQRR34abe
	NMhqhjMPcKjCIHDbRwpkYu1NJtriJTlgvOz0TJcjqAiI8I3IPgmLitYsn5VvMaacgKCH2U4Q0Wp1e
	d/oygBVRLyfbCGDs6CNIckRTOQBNT2jK3klnPvwiBTGhmAhZMfVl39LBCLk3w2fT7ysaIJx5/MhXH
	21bsefoY6/FPcd/v9INRkwf5DvgUgDEXSH2vj+fBfNMkvLdYNgFebEc8myB+OgAZDThwdjtSXVuio
	08uhnZyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x87fJ-0000000GmEj-3jnh;
	Sun, 20 Sep 2026 02:52:29 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x87fG-0000000GmE3-0zQ3
	for linux-nvme@lists.infradead.org;
	Sun, 20 Sep 2026 02:52:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789872743; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=SqZKxxJthjByJNOF61FIu8eTMS5rxMxdiNWYeHoqHuA=;
	b=Dt9F8dFyBvgkagAVUuBLdQKdsJMVMdJsmJI8P4fKmjTg6c2Q0dygBA8PoPfSyGG0SFFfJXOkRxenKwBZbuABbDnw1P1ac3YOx8BX23SvVlYveVIoizSw2l1YyRXBv0akC3DYo9UTXz0bQfQsArQgAibmbd2Uhs/Yc+QB8pw2eK0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XBEqZua_1789872742;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XBEqZua_1789872742 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 20 Sep 2026 10:52:23 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v5 0/1] nvme-multipath: expose path_state via sysfs
Date: Sun, 20 Sep 2026 10:52:13 +0800
Message-ID: <20260920025214.3089533-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260919_195226_851263_4F13DBF4 
X-CRM114-Status: GOOD (  10.38  )
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

This series adds a read-only "path_state" sysfs attribute to each NVMe
multipath path namespace device (/sys/block/nvmeXcYnZ/path_state), giving
userspace visibility into whether a path is currently usable for I/O and,
if not, the reason it is disabled.

Today users have to piece this together from the controller state and
various namespace flags. The new attribute reports the path selection
state directly, and is kept in sync with the path selection logic by
sharing a single nvme_path_get_state() helper.

Changes since v4:
- Merge the two patches into one patch. (Christoph Hellwig)
- Change the new ABI's KernelVersion from 7.2 to 7.4.

Changes since v3:
- Use single-token sysfs values ("enabled", "ctrl-down", "ana-pending",
  "ns-not-ready") instead of the composite "disabled (reason)" and
  "enabled (optimized)/(non-optimized)" strings, following the sysfs
  convention of exporting one simple value per attribute.
- Drop the "enabled (optimized)" vs "enabled (non-optimized)"
  distinction; the ANA access state is already exposed through the
  existing per-path ana_state attribute.
- Add a second patch documenting path_state in the stable NVMe sysfs
  ABI (Documentation/ABI/stable/sysfs-nvme).

Changes since v2:
- Factor path disable checks into nvme_path_get_state() helper returning
  enum nvme_path_state, and rebuild nvme_path_is_disabled() on top of it
  to keep path selection logic and sysfs reporting in sync. (Nilay Shroff)
- Distinguish "enabled (optimized)" vs "enabled (non-optimized)" based on
  ANA state. (Keith Busch)

Changes since v1:
- Show specific disabled reason instead of just "disabled":
  "disabled (ctrl_down)", "disabled (ana_pending)",
  "disabled (ns_not_ready)". (Nilay Shroff)

Guixin Liu (1):
  nvme-multipath: expose path_state via sysfs

 Documentation/ABI/stable/sysfs-nvme | 21 +++++++++++++
 drivers/nvme/host/multipath.c       | 47 +++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h            |  1 +
 drivers/nvme/host/sysfs.c           |  4 ++-
 4 files changed, 66 insertions(+), 7 deletions(-)

-- 
2.43.7


