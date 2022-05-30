Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DBFC47088
	for <linux-nvme@archiver.kernel.org>; Mon, 30 May 2022 14:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gC/+Gxwu1O9TO/1LkTFuXvYVtjfQN8PAHVFlYLlR0oA=; b=u/PZHfXkCU98TVyIbSyMlv0akh
	P6bcBWw4zqUxHC/Haaz7+xnvvyO48HK/jSozkG9INpCqjWvHL3YXCrvDvIdqleg3DfAIS96CI9K4C
	JNn9uvp+0S6DM/q+vWtld9sIWiUFXQNMl3SGk5omhjbZcjxc9nTT6cGMGnE16x0zekCPl92L9WZKd
	J2qqsrmw8MM2haAB5HgAfNxq5oONW4utr37O1RJnkVPb9Qp6XpRo2wVE1w8QLWD5UuqYQFZSTHO/J
	S3Lr40i5xwXjBwmnd5ziuyJ1KGYwytkbwRq/Slm2gvzpON8YVGtSUJm30QKnkuEYB6QJI8GEev4Ew
	qwvsUwbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nvgGk-0079uJ-BI; Mon, 30 May 2022 14:21:18 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nvfn8-006uM9-0X
	for linux-nvme@lists.infradead.org; Mon, 30 May 2022 13:50:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id A445FB80D84;
	Mon, 30 May 2022 13:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF08C3411A;
	Mon, 30 May 2022 13:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1653918639;
	bh=Lb86gbWhs67kFs4GNtIrQ2Ttz7LliZiZmer+S4h4N0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RvBn1voBxSUk3AGnhCN0ihqv2vTEeckSs5ahmNXivwcqdjDVFEBExaWzs5OzlMAgD
	 0tFDTeWno68ODto2PPS796PRrDdeTy8+eHox/mQH4Rs2PeN66ZVj8dQ661Efc4isGQ
	 iNAsc1eYh4aHxI0hBKhhqeQIEhSARFqfjLiBcJC6GM4crtfxkfYY9qNCTalHyJscu2
	 Z5EXgvGc0qeV2MBHdS0MVWOGDX6M2dQyLugBd02KFJW+uiXPfx2qhTwZap0HFrPmz4
	 fq6Km+DZUZY0lwB16P/P/g4e8Hb5jiI9hEicHmBe+MAkyU+wwpO//uMIVkrVr1cP78
	 s6ue27Wg8AmWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Smith, Kyle Miller (Nimble Kernel)" <kyles@hpe.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 31/38] nvme-pci: fix a NULL pointer dereference in nvme_alloc_admin_tags
Date: Mon, 30 May 2022 09:49:17 -0400
Message-Id: <20220530134924.1936816-31-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220530134924.1936816-1-sashal@kernel.org>
References: <20220530134924.1936816-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220530_065042_373104_EC63F42A 
X-CRM114-Status: GOOD (  14.72  )
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

From: "Smith, Kyle Miller (Nimble Kernel)" <kyles@hpe.com>

[ Upstream commit da42761181627e9bdc37d18368b827948a583929 ]

In nvme_alloc_admin_tags, the admin_q can be set to an error (typically
-ENOMEM) if the blk_mq_init_queue call fails to set up the queue, which
is checked immediately after the call. However, when we return the error
message up the stack, to nvme_reset_work the error takes us to
nvme_remove_dead_ctrl()
  nvme_dev_disable()
   nvme_suspend_queue(&dev->queues[0]).

Here, we only check that the admin_q is non-NULL, rather than not
an error or NULL, and begin quiescing a queue that never existed, leading
to bad / NULL pointer dereference.

Signed-off-by: Kyle Smith <kyles@hpe.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d7cf3202cdd3..b06d2b6bd3fe 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1522,6 +1522,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 		dev->ctrl.admin_q = blk_mq_init_queue(&dev->admin_tagset);
 		if (IS_ERR(dev->ctrl.admin_q)) {
 			blk_mq_free_tag_set(&dev->admin_tagset);
+			dev->ctrl.admin_q = NULL;
 			return -ENOMEM;
 		}
 		if (!blk_get_queue(dev->ctrl.admin_q)) {
-- 
2.35.1


