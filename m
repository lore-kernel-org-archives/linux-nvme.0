Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA15CC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jan 2022 17:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5c0Y3QAkQ4LSuU0ZEb1Fuu3N7J9nMI3w/zaNGJEvChM=; b=qNRgeCnz4ywOqEgsAy2rPnDXjl
	rS7TOtDc5jItwRB131uP5l1UDAUZ6KcSiORcmpW3iB0g2sxU559ppYA1jOGVnMDV5WpWjysjolmPe
	IYkYSw0nz3njHvdFwciwO+PQxwIzVD6NyPsWn9GNg0i0ncP/P7ib3xj1OT+JHGR6BcoVgsPS5Ifj5
	LxlS5NoQgrPyH9VOjlETmfBy3tCDdpIJjZ33B89up5cB2B9p1UORjsKsTERhGW0CrWsblcYNz/nXT
	NQin4U2FQmv+pYNeiyvGhwW3gGyaTHqeqo10sg5UC525EPjBHGZ09j3wzU7g7KMl11PzxYpoMcfED
	XKd7Mcew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n59jI-00FPd8-Ck; Wed, 05 Jan 2022 17:05:40 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n59j5-00FPYz-PB
 for linux-nvme@lists.infradead.org; Wed, 05 Jan 2022 17:05:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 52780B81CB8;
 Wed,  5 Jan 2022 17:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAD1C36AE9;
 Wed,  5 Jan 2022 17:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641402325;
 bh=WC9QR45b9hMLbj6d6HxZ8ypkwBnGddX9RlV4N19YuXs=;
 h=From:To:Cc:Subject:Date:From;
 b=X5zo9rSHRZkW+2OBJ/lxCHzmmzG8R21+rDn96plb9ETPb2CJS0KDyknFy7vDWwNce
 D0bhNXtZi/nZFSR499r6OwZpLBoV9oIu7bG0gZnBr+P1gtPZ8Vum8RQ8tGJvvixPpa
 IUMMtJLLH/8vLIzNTcT3i0SR51AHsE7vgQXIebk3ARLcLtyFk+YjSHgjaamWgDeiar
 jwwHPGQxllzvK6TdyYzv1ctFYZqzYbnyBvBxIHb2n3ggSL0wqMMsdnu3IXprG3O7H1
 R5vhgFGVSDM/jzkOC89KPyV9umH7KKompzwuq/WydwMr3JWw/F4HvL22Iy/viQA9Ef
 PsGNzRw/ZKlMA==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, mgurtovoy@nvidia.com,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 0/4] queue_rqs error handling
Date: Wed,  5 Jan 2022 09:05:14 -0800
Message-Id: <20220105170518.3181469-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220105_090527_987289_838F9061 
X-CRM114-Status: UNSURE (   9.57  )
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

The only real change since v2 is a prep patch that relocates the rq list
macros to blk-mq.h since that's where 'struct request' is defined.

Patch 3 removes the 'next' parameter since it is trivially obtainable
via 'rq->rq_next' anyway.

Otherwise, the series is the same as v2 and tested with lots of random
error injection in the prep path. The same errors would have lost
requests in the current driver, but is successful with this series.

Keith Busch (4):
  block: move rq_list macros to blk-mq.h
  block: introduce rq_list_for_each_safe macro
  block: introduce rq_list_move
  nvme-pci: fix queue_rqs list splitting

 drivers/nvme/host/pci.c | 28 +++++++++++------------
 fs/io_uring.c           |  2 +-
 include/linux/blk-mq.h  | 50 +++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h  | 29 ------------------------
 4 files changed, 65 insertions(+), 44 deletions(-)

-- 
2.25.4


