Return-Path: <SRS0=9ZED=LE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE047C48BDF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 21:44:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E200613CA
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 21:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E200613CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=UWgsxhMQyJCY12CoUWlTy2QIadqzYGsXwjzTqSlioE4=; b=cuydYMV3oCTmH8
	NwEY9wME0mQPyYb7YJey+IRMtlqhiYuu86sTrGH4In9Q7CGLGx20++ImY7BwxokuWZzuDBDRyPs64
	33mHQlRXDdYaMA+ZxrBwTOmVqNevE/rypb4LJzYA8BBl5nX6UMo0dw1j09z/Aphd6G2xycq753Jv2
	QCiF9s8HWsO5Yrg4aXZwRmPjzuWgjbDUfJmfYCc5/ohduw29qG/d97AjtUOqcCySlPiuUQe3Uf0+9
	/3IwKVLj2CCATxTEtntGTS6vcJm6rUb9lbjZVyiqEAVayON8EoxR4QXdUd5pseoSqlFJprbMyTfnF
	dBRKf+9glTj0uPh7k1nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lrSTu-002ZtH-OA; Thu, 10 Jun 2021 21:44:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lrSTs-002ZrX-FH
 for linux-nvme@lists.infradead.org; Thu, 10 Jun 2021 21:44:53 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C93E61404;
 Thu, 10 Jun 2021 21:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623361492;
 bh=Nm2lG9+SJgKjIstjugCTUl6kie9LX9Danvpz1BD7x3o=;
 h=From:To:Cc:Subject:Date:From;
 b=hvTbuus3egZkN0mDA5ZGbn+7ZHya0BQXs1jLjULpxHS1tQ4iBAwpqyKcXWEVIGaAx
 MkSSS9Cy9RGes0b/QeG49wRfeI9d9IvD71yTSjUYWhnRBf+xJ1opkvLLpf79O/APbw
 QehY9AjE5P8sbKu4MJP+/o93bC4QTflfa/dqtGywVlH5V7U4c+IcKe0UeN0dVM6Cfz
 4lvZYGcIbZF1x80XySArWoTwxKEgXNKoX7wyecEKDod1WAu9lWUGhYBdssQDK2z/17
 pUDtDCzT2mkg/psigFoWU4IteNhB060YPp6KneBtQaTGfEHw9wsrVHFFcKxweUv8Ti
 0vo0+ocfQv6Kw==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 linux-block@vger.kernel.org
Cc: axboe@kernel.dk, Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>, Ming Lei <ming.lei@redhat.com>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 0/4] block and nvme passthrough error handling
Date: Thu, 10 Jun 2021 14:44:33 -0700
Message-Id: <20210610214437.641245-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210610_144452_546465_85FA97BF 
X-CRM114-Status: UNSURE (   7.62  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This series has blk_execute_rq() return queueing errors so the caller
may know if their request wasn't dispatched, and adds polled hctx
support.

Chances since v3:

  Added recieved "Reviewed-by:" tags.

  Retain the REQ_HIPRI flag for nvme polled passthrough requests
  (patch 2)

  Combined nvme request dispatch with the status decoding into single
  function (patch 4)

Keith Busch (4):
  block: support polling through blk_execute_rq
  nvme: use blk_execute_rq() for passthrough commands
  block: return errors from blk_execute_rq()
  nvme: use return value from blk_execute_rq()

 block/blk-exec.c               | 25 +++++++++++--
 drivers/nvme/host/core.c       | 65 +++++++++++++++-------------------
 drivers/nvme/host/fabrics.c    | 13 ++++---
 drivers/nvme/host/fabrics.h    |  2 +-
 drivers/nvme/host/fc.c         |  2 +-
 drivers/nvme/host/ioctl.c      |  6 +---
 drivers/nvme/host/nvme.h       |  4 +--
 drivers/nvme/host/rdma.c       |  3 +-
 drivers/nvme/host/tcp.c        |  2 +-
 drivers/nvme/target/loop.c     |  2 +-
 drivers/nvme/target/passthru.c |  8 ++---
 include/linux/blkdev.h         |  4 ++-
 12 files changed, 72 insertions(+), 64 deletions(-)

-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
