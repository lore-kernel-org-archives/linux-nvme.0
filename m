Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59A0C54E5D
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Mar 2024 15:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D6Mmdf8TTOwR94S1x2bhqYOSNo5XeucO5LtZLDhjKUc=; b=io3mzMqnQN7dQsJz3xMuJc19Eu
	XAhO0JntKlNl4vov97MM75k1HeYtUKyAu4LjJ6o/yZ+owQDl3J4PxOooKDGkSk5Y652mwEc3zfoiN
	ys5acd3iO5J0GLz3TfQvcJanN6EMX9WObK3UxPz5UrKVHRQsyfHBQgLj9ai0bhlZYaKvuaO505Hx4
	tfjBGXqTYNvfePzZQyoTK0wb53s8HMOB/1eu0W6ugrbpiQVn2RE6Ejo4jKkZXqswPbjSbKMUSCdUd
	0FzjYswvNTO8fmeKuBnR5wR/eHgkm8MtOiBbk+8P33t/DRGzsuB/clzR2/q79GVsI5GaxQ6B01gO8
	l1d8KX8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmEWx-00000008uaQ-2lfF;
	Mon, 18 Mar 2024 15:04:03 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmEWh-00000008uKl-4AiK
	for linux-nvme@lists.infradead.org;
	Mon, 18 Mar 2024 15:03:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 34D80CE0AB6;
	Mon, 18 Mar 2024 15:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E0FC43399;
	Mon, 18 Mar 2024 15:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710774225;
	bh=+gJYSM2h3Hq8/ESbSODQo36teKs+aSIkrCru6+4YnkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g/fzyJYjB7qcl6zCb9Xynnceoo/cVzdkjfsD45PYki+1rk3QGBD3pIzfC/WkvMISI
	 fOdfCZpiHxjYBt7vOONTXgeA1B4QeEnd6CjR8uWdvsXOiZQ0B4qcjlNy4ha3h/zG/h
	 p8vBe3azHQ/U2lNw75PzAAJ38sLHW1fc6JQPsEeRYlO9PXvOi4BzOu/b8vrWghdA/x
	 Y/JGy+iCbAGUtqrnN+En2az1idnTn5Exq/QRMtV0pLAJubX+d5OTe37L7qOrBSih6M
	 PlJNClANnpO09Y9qkZE6yZdQx0fXR/bT2FsFwHL1bF5mkBIRTdItX5+13BDiKjc/F3
	 oBjWDNCUU4QRA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 09/17] nvme-tcp: do not quiesce admin queue in nvme_tcp_teardown_io_queues()
Date: Mon, 18 Mar 2024 16:03:08 +0100
Message-Id: <20240318150316.138501-10-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240318150316.138501-1-hare@kernel.org>
References: <20240318150316.138501-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_080348_269340_1307CA75 
X-CRM114-Status: UNSURE (   9.50  )
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

nvme_tcp_teardown_io_queues() is for I/O queues; the admin queue
should be left untouched here.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7018dc0dd026..66675b2dc197 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2173,7 +2173,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 {
 	if (ctrl->queue_count <= 1)
 		return;
-	nvme_quiesce_admin_queue(ctrl);
 	nvme_quiesce_io_queues(ctrl);
 	nvme_sync_io_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
-- 
2.35.3


