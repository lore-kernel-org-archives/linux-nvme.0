Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87762C4706C
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Jan 2024 07:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JGR9rjoNjjh8K8pC43OJ6+NykYZV2SDmP+E3zAx6RAc=; b=rQnSBoLO5IW1kjZCxQw9H4BkOT
	BZs3aMcPiLgquZmR24oUNzsyDuj0DJVx/F5qMEgH+OystAQjGAER79Jv3nTVYiS05XLF31o6RX9f9
	gNdXtKWRfw215GOoVxVzfwmmZZNgEK/zRq+hC4OK6zc5JdAeZzNHxfE1y1z3nTu8QSPpwmwio5rpc
	a51r+ABNx26WvHmYf9Nkt+qOn/igBiv3iqjM/cfjXFKYTYAg0zmtKZhsCiTOWX6Grnso7Mbz4k102
	JFyzFwf4wI5NuTf7DLMo9kpOGpAazwpl30Sap+TBLyfHMpuwn3owf+C3wlRLYG0zA/iaddeQj1paE
	IuZtFAFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rOBsn-0024kI-1x;
	Fri, 12 Jan 2024 07:23:13 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rOBsk-0024iO-0a
	for linux-nvme@lists.infradead.org;
	Fri, 12 Jan 2024 07:23:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8A095CE20A4;
	Fri, 12 Jan 2024 07:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2DAC433C7;
	Fri, 12 Jan 2024 07:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705044187;
	bh=Jv/2GTgtoRDF8LDjOFfK4uYDuPdBi8I5Q+EwB62iSE4=;
	h=From:To:Cc:Subject:Date:From;
	b=AJzW79BVVvgmJOpUbvm1a0rW1p46F6V9lYVPbjTwQvLE7efyiZ6RbQsnN0BRm8JNY
	 buUL98/Uu4i3yjJeBb1q7n0x0oU2APdZ1GkHeY8TBuLlRMCq5nieNSx2zetbHZg0nZ
	 zuSVlF3Dmjf2mXKbhL2oflxnhO7j/D3ZJcnnf/UPjqNOi73tbgOOT/TdNW6Bpt9hmc
	 //JfB4iJcowrvm0sgDYXqiMMuFNHOe8tXYm+ZfhRkrv35jgveZfKienRMEOit2ptjU
	 C0zZkjKXF8zn+3BEOzTEjrpLba1O4gb0a46oaFz9bf9jed3coiSCbqyyTHnrgN8JAR
	 byV+ypCI3brug==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvmet-tcp: do not continue for invalid icreq
Date: Fri, 12 Jan 2024 08:23:03 +0100
Message-Id: <20240112072303.141891-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240111_232310_390438_A3C2C753 
X-CRM114-Status: UNSURE (   8.57  )
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

From: Hannes Reinecke <hare@suse.de>

When the length check for an icreq sqe fails we should not
continue processing but rather return immediately as all
other contents of that sqe cannot be relied on.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/tcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 6a1e6bb80062..3d606ab01506 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -898,6 +898,7 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 		pr_err("bad nvme-tcp pdu length (%d)\n",
 			le32_to_cpu(icreq->hdr.plen));
 		nvmet_tcp_fatal_error(queue);
+		return -EPROTO;
 	}
 
 	if (icreq->pfv != NVME_TCP_PFV_1_0) {
-- 
2.35.3


