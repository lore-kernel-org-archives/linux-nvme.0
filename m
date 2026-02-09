Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE31E7C706
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Feb 2026 08:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vWafjCdJxbGy+zpA6xsUvx187ObMLgA2LLOCgEuhEsU=; b=gTmx8FKzCaPxWRyLkuRbxoUG1+
	8xO2iElmyO59jK9R6c0jXSzSvfiu496TbGbRwnaXIKhFuQzCKYhVcyEPz++GTgNquEFflS3ADv8kR
	0iTAmsfH9UY2xLSG5nisybxmes9u0Z9vnA8eNlJQ545Fb2oSdfg1/qBHgw81X7rTXCZ/4iQxD28Sd
	h7e18DNFpPvY+giQvuvido/4PhjT50BoX+ExBRUakL8xh7nZTmQnGiHKIHoeV5aOiq7i7F4Wi9/GW
	e07Oh2aCjKKNoDEiwT1c3UgJnxWOqknZeVpcakAnA4lEgsPwrAsxToUvC44/clZm2rnviZ4+F87A0
	Mt2ZuIyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpMeh-0000000F1gi-3Uv2;
	Mon, 09 Feb 2026 08:30:03 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpMee-0000000F1fk-1A7N;
	Mon, 09 Feb 2026 08:30:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0B2254454E;
	Mon,  9 Feb 2026 08:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F83DC116C6;
	Mon,  9 Feb 2026 08:29:55 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	sven@kernel.org,
	j@jannau.net,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	neal@gompa.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	yukuai@fnnas.com
Subject: [PATCH 0/4] blk-mq/nvme: fix debugfs creation with frozen queue
Date: Mon,  9 Feb 2026 16:29:49 +0800
Message-ID: <20260209082953.3053721-1-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260209_003000_401029_D4B6AFCA 
X-CRM114-Status: UNSURE (   8.78  )
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

blk_mq_update_nr_hw_queues() freezes and unfreezes queues internally.
When callers pre-freeze the queue before calling this function, the
freeze depth becomes 2. The internal unfreeze only decrements it to 1,
leaving the queue still frozen when debugfs_create_files() is called.

This triggers WARN_ON_ONCE(q->mq_freeze_depth != 0) in
debugfs_create_files() and risks deadlock.

Patch 1-3 fix nvme drivers by moving nvme_unfreeze() before
blk_mq_update_nr_hw_queues() so the queue is unfrozen before the call.

Patch 4 fixes the block layer debugfs_create_files() itself. I checked
all callers of debugfs_create_files():

  - blk_mq_debugfs_register() from blk_register_queue(): queue not frozen
  - blk_mq_debugfs_register_hctx() from blk_mq_debugfs_register_hctxs():
    called after blk_mq_elv_switch_back() which unfreezes the queue
  - blk_mq_debugfs_register_sched() from elv_register_queue():
    called after blk_mq_unfreeze_queue()
  - blk_mq_debugfs_register_rqos() from wbt paths:
    called after blk_mq_unfreeze_queue()

All callers have the queue unfrozen. However, the queue can be frozen
from another context at any time, so the WARN_ON_ONCE check is racy.
Replace it with blk_queue_enter()/blk_queue_exit() which properly waits
for the queue to be unfrozen and prevents new freezes while creating
debugfs files.

Yu Kuai (4):
  nvme-rdma: move blk_mq_update_nr_hw_queues after nvme_unfreeze
  nvme-tcp: move blk_mq_update_nr_hw_queues after nvme_unfreeze
  nvme-apple: move blk_mq_update_nr_hw_queues after nvme_unfreeze
  blk-mq: use blk_queue_enter/exit to protect debugfs file creation

 block/blk-mq-debugfs.c    | 15 ++++++++++-----
 drivers/nvme/host/apple.c |  2 +-
 drivers/nvme/host/rdma.c  |  2 +-
 drivers/nvme/host/tcp.c   |  2 +-
 4 files changed, 13 insertions(+), 8 deletions(-)

--
2.51.0


