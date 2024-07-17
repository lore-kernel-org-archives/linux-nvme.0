Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B7BC3DA42
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 09:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iAtascieQ1TjiOUkuI2gRBz/awV2bZzJ1zpX2b7Fatg=; b=aciapz3rKLuVBv5aHYmewmNPl+
	06rf6UqHJHqb2Hp0g5NE3zAsa3KeGwgL0kymATEW8clyvCLhhgOfTkqjtqUaXMH27e6NtitaHp0op
	cA240kSNqjFGaLz3BbHly9P1431aMHoVOV+jQHdadBO5L7rzJXPevF1PqORL4yEIan2RHJfXPIpir
	rOapnth4sfine7Td9SFScMhtB1GJM+osK+UYZ+rbgkFskGANWHu6RfKHrYLcOOJQvO/IY5sgAITIt
	J49HK9WLeifsG+TepazFYuAxEKIRco3u/8Xczu2ieqlXpF5AnMVwD/ArhJhXJLaSsoTBnJDMZv8Fs
	4BlvzSeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU0hS-0000000DGHh-1sw6;
	Wed, 17 Jul 2024 09:11:50 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU0gk-0000000DFxW-0iGI
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 09:11:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 85A23CE1412;
	Wed, 17 Jul 2024 09:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EBBC4AF09;
	Wed, 17 Jul 2024 09:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721207463;
	bh=VnIVfjuMtA4M9oQP6QXj6VqoMYwa3ZkWFWd2/YJds1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=thrLfELtnh23FysScHnZA/z/K73hy3WV8yZPtGXDzm6cACkQNHtdUcc/sCsck3eWp
	 4kmeoEJBflKqCETgRaI8etS1VX+FfALU/oBZshPagFM4WYbIlhg3KTBxmM+NgRXnef
	 MjdiSnTmuh+4WAfcIVsUtlaT854i1mhynIFjUO0mwThtgoAwW1+KkADYZoC4PcIxRn
	 fzdp5i7M/7hdJMW/xg2JCvrxd7QYFXohJL4SXAQb/vhGvr1wvEWgZ5W9V6ZVwV6KhS
	 jV/whNbX249v2ustwLAhBUXYiIRy5ylLEeOWZmo5vwRHNCAXK27pNwMVcvvkQnuZLZ
	 L06yK2Qz+ceXg==
From: Hannes Reinecke <hare@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 13/16] nvme-fabrics: reset admin connection for secure concatenation
Date: Wed, 17 Jul 2024 11:10:28 +0200
Message-Id: <20240717091031.143188-14-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240717091031.143188-1-hare@kernel.org>
References: <20240717091031.143188-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_021106_412007_E3D7CFD8 
X-CRM114-Status: GOOD (  12.36  )
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

When secure concatenation is requested the connection needs to be
reset to enable TLS encryption on the new cnnection.
That implies that the original connection used for the DH-CHAP
negotiation really shouldn't be used, and we should reset as soon
as the DH-CHAP negotiation has succeeded on the admin queue.

Based on an idea from Sagi.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d6c085ba0114..0873b3949355 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2251,6 +2251,15 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 	if (ret)
 		return ret;
 
+	if (new && ctrl->opts && ctrl->opts->concat && !ctrl->tls_pskid) {
+		dev_dbg(ctrl->device, "restart admin queue for secure concatenation\n");
+		nvme_stop_keep_alive(ctrl);
+		nvme_tcp_teardown_admin_queue(ctrl, false);
+		ret = nvme_tcp_configure_admin_queue(ctrl, false);
+		if (ret)
+			return ret;
+	}
+
 	if (ctrl->icdoff) {
 		ret = -EOPNOTSUPP;
 		dev_err(ctrl->device, "icdoff is not supported!\n");
-- 
2.35.3


