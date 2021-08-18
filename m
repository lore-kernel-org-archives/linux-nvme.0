Return-Path: <SRS0=/QSy=NJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831C4C4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 07:43:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4171B60FDA
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 07:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4171B60FDA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=FP8god5Xflh3+YTxAUG8pozKah17A2+mjcanGnC8OkE=; b=z4FuyGHCNUHjT7
	taXGDZsmOVjQCQq2b5gH5Im29++uZPHvJIO29rc/3cVa9qIiSqyIkD4dbZbphwa7hWoN16+P47W0o
	QlhLvzd7jMG7MTt9alIxJqTcM+8eMJGiXem+T4dd0xV8vGVK3zlfbMSZBryvNyW0JdK8fL+i2qeFA
	HX/csvHRj3HmpP3EA0a0KuPj4WABpS0+RTOTR7st/QViZcPZVWuAz6W5pMeLG0ilMNUtCNp87TfJH
	6ArwYld8VzbJDRBVPBLfptuj/Ygwo9Z/Wyc2NuQmaCo8XVz4xyFIj8rH1rBtrBEzCdojFSXzIsPG7
	ZzB9AEMDW9Dzu2Ri8FvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mGGEQ-004WhT-8T; Wed, 18 Aug 2021 07:43:26 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGGEP-004WhE-5x
 for linux-nvme@bombadil.infradead.org; Wed, 18 Aug 2021 07:43:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=nd9cN56HL1mrF6Ir6BjczYHboyzl6QpT6r1kCisX79M=; b=Sm3lxbuRWYc/Ah1Jg+RWWUSmfg
 SYbduEhb0vUznNCzEo2hX6TB6ULEASiIMJ+InCrMHLeK4TAiZ8bEdHjNk6bx53R+tAweaZOqHRGcu
 Bh/F9FypIpTC/YSVQW8Hu9BeLaDJ7jvjfFaQd7YUG7+pRmsXCnnTHCU0F/ZY0H+yp0/EjQU+O1L1e
 xuEsA3c5YM951O2TxxES0TTtnIcAlbWvPlnOXYnmq8sWx4/oqqVYC/dhOapxyGEGzRZHnP2ha6BCc
 bFFTblixdquQtfEoylSS19/p3eAo48NVlI6JtBvKIc5c42G24bx65DzwV8hAII2tppfliCrU3gvr9
 KuHC4aGg==;
Received: from [2001:4bb8:188:1b1:c70:4a89:bc61:2] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGGCo-003WUE-VY; Wed, 18 Aug 2021 07:42:43 +0000
Date: Wed, 18 Aug 2021 09:41:45 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] first round of nvme updates for Linux 5.15
Message-ID: <YRy5uawonM5ERm3D@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The following changes since commit 9ea9b9c48387edc101d56349492ad9c0492ff78d:

  remove the lightnvm subsystem (2021-08-14 15:54:09 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.15-2021-08-18

for you to fetch changes up to 9891668e43c8e9f2d0d50088b151edefc2e560e5:

  nvme: remove the unused NVME_NS_* enum (2021-08-17 06:20:17 +0200)

----------------------------------------------------------------
nvme updates for Linux 5.15.

 - suspend improvements for devices with an HMB (Keith Busch)
 - handle double completions more gacefull (Sagi Grimberg)
 - cleanup the selects for the nvme core code a bit (Sagi Grimberg)
 - don't update queue count when failing to set io queues (Ruozhu Li)
 - various nvmet connect fixes (Amit Engel)
 - cleanup lightnvm leftovers (Keith Busch, me)
 - small cleanups (Colin Ian King, Hou Pu)
 - add tracing for the Set Features command (Hou Pu)
 - CMB sysfs cleanups (Keith Busch)
 - add a mutex_destroy call (Keith Busch)

----------------------------------------------------------------
Amit Engel (3):
      nvmet: pass back cntlid on successful completion
      nvmet: avoid duplicate qid in connect cmd
      nvmet: check that host sqsize does not exceed ctrl MQES

Christoph Hellwig (1):
      nvme: remove the unused NVME_NS_* enum

Colin Ian King (1):
      nvmet: remove redundant assignments of variable status

Hou Pu (3):
      nvme-fabrics: remove superfluous nvmf_host_put in nvmf_parse_options
      nvme: add set feature tracing support
      nvmet: add set feature tracing support

Keith Busch (6):
      nvme-pci: use attribute group for cmb sysfs
      nvme-pci: cmb sysfs: one file, one value
      nvme-pci: disable hmb on idle suspend
      nvme: allow user toggling hmb usage
      nvme-tcp: pair send_mutex init with destroy
      nvme: remove nvm_ndev from ns

Ruozhu Li (2):
      nvme-tcp: don't update queue count when failing to set io queues
      nvme-rdma: don't update queue count when failing to set io queues

Sagi Grimberg (5):
      params: lift param_set_uint_minmax to common code
      nvme-pci: limit maximum queue depth to 4095
      nvme-tcp: don't check blk_mq_tag_to_rq when receiving pdu data
      nvme: code command_id with a genctr for use-after-free validation
      nvme: Have NVME_FABRICS select NVME_CORE instead of transport drivers

 drivers/nvme/host/Kconfig         |   4 +-
 drivers/nvme/host/core.c          |   3 +-
 drivers/nvme/host/fabrics.c       |   1 -
 drivers/nvme/host/nvme.h          |  53 +++++++++--
 drivers/nvme/host/pci.c           | 181 +++++++++++++++++++++++++++++---------
 drivers/nvme/host/rdma.c          |   8 +-
 drivers/nvme/host/tcp.c           |  44 ++++-----
 drivers/nvme/host/trace.c         |  18 +++-
 drivers/nvme/target/Kconfig       |   2 -
 drivers/nvme/target/core.c        |   1 +
 drivers/nvme/target/fabrics-cmd.c |  38 +++++---
 drivers/nvme/target/loop.c        |   4 +-
 drivers/nvme/target/trace.c       |  18 +++-
 drivers/nvme/target/zns.c         |   5 +-
 include/linux/moduleparam.h       |   2 +
 kernel/params.c                   |  18 ++++
 net/sunrpc/xprtsock.c             |  18 ----
 17 files changed, 295 insertions(+), 123 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
