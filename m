Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF6CC531FA
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2026 09:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yNFpQGw8J1YJZeASf8Y81LTx2txWaNrPtqvcrLmJGnE=; b=oBZM+qlZ5EqJWHOoJNoy3ilNxf
	He7i9F4xVxZwg5LQbADR8fxmF+2rMh2yMtPI48sY/3it7bcdE6HGL2sQR2R0dDB3+i2HQRl/zHNMN
	LEKPqDuJ99HV9wNvQURyvn0qNrJGz+fbhpnPrAMPKolu4oFx50CWPKYAfZWg1oo1S+hozhEM5SXol
	tu9Un8/DS7IuqDS+yvgPCP0PSZCC03rzvwwV/5KbFH03AvQ64c7f52LxUqdQRJ0ynvaScef2l50cB
	FJSf/Pw1GsVnhDsQoqhNNFn9lhtS96HnXbnFg+m/K2xVDXQBmUcBNKSAlxENA+NVK8yi/hitgcQbd
	x2eV7MpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnBlY-0000000FtX6-3jmp;
	Fri, 24 Jul 2026 09:00:24 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnBlU-0000000FtVD-2EHC
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jul 2026 09:00:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784883614; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=yNFpQGw8J1YJZeASf8Y81LTx2txWaNrPtqvcrLmJGnE=;
	b=J1IdU24NHGHhDyCF5O6/GYosaItZQlvQ5PtHrN55d6zKRSVDAxD6i3O8fSOMgQzu0undIiZpwUsYLCStmjlJ275b5fSDHrUI5jZIzERrSrw0ycgOakihAoYdQ4fZQvWWKS5HjFVdlQh2RvC41wpBiaqCGR4meJYSEpaXNBEJrgo=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X7iifep_1784883612;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X7iifep_1784883612 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Jul 2026 17:00:13 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	John Garry <john.g.garry@oracle.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v4 0/2] nvme-multipath: expose path_state via sysfs
Date: Fri, 24 Jul 2026 17:00:02 +0800
Message-ID: <20260724090004.1146014-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260724_020021_370827_2C4388FB 
X-CRM114-Status: GOOD (  10.27  )
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

Patch 1 adds the attribute and the helper; patch 2 documents it in the
stable NVMe sysfs ABI file.

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

Guixin Liu (2):
  nvme-multipath: expose path_state via sysfs
  nvme-multipath: document path_state sysfs attribute

 Documentation/ABI/stable/sysfs-nvme | 21 +++++++++++++
 drivers/nvme/host/multipath.c       | 47 +++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h            |  1 +
 drivers/nvme/host/sysfs.c           |  4 ++-
 4 files changed, 66 insertions(+), 7 deletions(-)


base-commit: 7caaa4120d8dd73bb251410e1d007b4131d024c4
-- 
2.43.7


