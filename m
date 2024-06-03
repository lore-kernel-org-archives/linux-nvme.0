Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9387DC25B75
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jun 2024 12:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7tvpUrsJfSB1ywacTZf0xUkGNxPSB2k17odYkwWEv48=; b=XoBJ7d+vuV95QYDxBC+qh0o7+g
	dNzxZeW1mMT9Ljfpzei6vZ0lptaeob/orfeG0OX6uCeqz4cuqYtpI23+oApmaa/16tF0/zbTch2by
	ahOEUltt1WP5qpiiXoN0pmpgDjyTt67ug6BLmqPqq5jr2kH/9eqZGScnuffrkm+4jM8EFHN4F8WJJ
	wB02mru3sfypAm96O1ccdKVObtCu8NXVNyeRDYbYmKOKfJrdYe6lp4D/vGOtnFxBrjLipaEqMwEiY
	cqtK3ftu0h4seY1a2QcOk8KsYQJjiceQxsTa+XUz9cUWGw/nvpmiTdeBk9EA3BCR6JwxAUvASwLKw
	7ped3+cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE7GS-0000000GmGh-0m1O;
	Mon, 03 Jun 2024 12:58:16 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE7GM-0000000GmDm-3eW7
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jun 2024 12:58:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717419480; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=7tvpUrsJfSB1ywacTZf0xUkGNxPSB2k17odYkwWEv48=;
	b=dEuzyOataJmrhAq/Ywsd50k8e+Hyd1vRWpqM5MOR7P/PZzSxGuLW0lIScU5R0MtgfGvUDtnXQg0lQbWiyX5ZKFmgEiEV/hC9krhD0JKD1EjgdNHnl2LJNYg9KqLcwJBPWOeoYB9Pxyv/3K3PhXUn3Q6EWQnzTcD/FAR7dDzwFN0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=huweiwen@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W7nmJ7Z_1717419475;
Received: from localhost.localdomain(mailfrom:huweiwen@linux.alibaba.com fp:SMTPD_---0W7nmJ7Z_1717419475)
          by smtp.aliyun-inc.com;
          Mon, 03 Jun 2024 20:57:56 +0800
From: Weiwen Hu <huweiwen@linux.alibaba.com>
To: linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>
Cc: Mike Christie <michael.christie@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Weiwen Hu <huweiwen@linux.alibaba.com>
Subject: [PATCH v2 0/4] clarify NVMe status symbol names
Date: Mon,  3 Jun 2024 20:56:58 +0800
Message-ID: <20240603125702.97368-1-huweiwen@linux.alibaba.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_055811_150667_0639D2D1 
X-CRM114-Status: GOOD (  11.43  )
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

This patchset clarifies the NVMe status related symbol names.
- status: the u16 field in the struct nvme_request.
- SC:     status code,      status & 0x00FF
- SCT:    status code type, status & 0x0700
This should match the NVMe spec and most of the existing code.
The exceptions are unified in this patchset.

It may be a little bit strange that we should use NVME_SCT_SC_MASK when
matching the NVME_SC_* codes. But changing all the codes to NVME_SCT_SC_*
requires too much changes, and making the names too long.
So I choose to keep them.

The previous version is:
https://lore.kernel.org/linux-nvme/20240529122300.92377-1-huweiwen@linux.alibaba.com/T

Changes in v2:
- Add a mailmap entry for myself.
- Rebased on nvme-6.10, dropped the patch that is already applied.
- The parameter of nvme_status_to_pr_err is renamed to "status", to make it
  shorter and matching the existing code.

Weiwen Hu (4):
  nvme: rename nvme_sc_to_pr_err to nvme_status_to_pr_err
  nvme: fix status magic numbers
  nvme: rename CDR/MORE/DNR to NVME_STATUS_*
  mailmap: add entry for Weiwen Hu

 .mailmap                               |  1 +
 drivers/nvme/host/constants.c          |  2 +-
 drivers/nvme/host/core.c               | 40 +++++++++++-----------
 drivers/nvme/host/fabrics.c            | 10 +++---
 drivers/nvme/host/fault_inject.c       |  2 +-
 drivers/nvme/host/fc.c                 |  6 ++--
 drivers/nvme/host/multipath.c          |  2 +-
 drivers/nvme/host/nvme.h               |  6 ++--
 drivers/nvme/host/pr.c                 | 10 +++---
 drivers/nvme/target/admin-cmd.c        | 24 +++++++-------
 drivers/nvme/target/core.c             | 46 +++++++++++++-------------
 drivers/nvme/target/discovery.c        | 14 ++++----
 drivers/nvme/target/fabrics-cmd-auth.c | 16 ++++-----
 drivers/nvme/target/fabrics-cmd.c      | 36 ++++++++++----------
 drivers/nvme/target/io-cmd-bdev.c      | 12 +++----
 drivers/nvme/target/passthru.c         | 10 +++---
 drivers/nvme/target/rdma.c             | 10 +++---
 drivers/nvme/target/tcp.c              |  4 +--
 drivers/nvme/target/zns.c              | 30 ++++++++---------
 include/linux/nvme.h                   | 16 +++++++--
 20 files changed, 154 insertions(+), 143 deletions(-)

-- 
2.45.1


