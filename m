Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A653C021A6
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 13:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mdpHdSWatrLt0QoL9BxnQE0rENby33Edsza2jAcAgO4=; b=1HBLaV2AIZEAAzN1BXw0KCQ7Om
	cRDXfzhvpQ43ae/kPj3M8duYN9eaLD4QVUpLGbZ8EK5DK1Zs/IrLO/yYfob9r1tm+ZgXsYJqikPCA
	0+EbgaouGz00iL989O8JVvEHoEr13TRofCYZKeFfU1RJYdyO5bNbLS1HIUCjJtf0XlkcyruGAoTZP
	OtNukT/Kdh8v4bt9jkWN4pGneavzxBZW+uIGTy8OLNK4Sj71UUQSt1+M+S1yGONABWdtSHfol9eta
	3Pil8TQbCZJJtobPAmskJWxazV0mtLAMAo0iEVDQwUJOs/md2VA8bESsLMw5JaSy60gDQ1lsg1MZK
	zqKTAJYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmYI1-0000000DoIe-3LrJ;
	Mon, 24 Feb 2025 13:14:29 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmXjT-0000000DiZs-0t3m
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 12:38:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D08F9611B6;
	Mon, 24 Feb 2025 12:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181D8C4CEEA;
	Mon, 24 Feb 2025 12:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740400726;
	bh=z1iAGJL0PqvNItlGc8l+BH7IBbgKXPjm9XylPPQAcH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T546ieACM/nNruVVOtwtpSO0XOhqNlh1DA2669VCaGZYO/0zsCPQTTuufp5bttC5p
	 +Xgde2Ur8O/h1ONQS0ucXoZX0/shkk97UU7gVV2BuhNjozrFR47LvqeSsG/BItrL8B
	 xFGz7ldH2IfNYa8CNZLkDm3fKsyNNVPr6Ujj937dwpOL7jW2rw00jdx98k/uJtf0o3
	 03v2csT+zsZooI0k7aCw8+vLHO2hdLs1Nx56mgA/SfC6MRKEIL82gW1gOj3MQtvXhe
	 f2Mya64SF8c7oeglZbAHzsEzSGkUcIdPP/IJzxLZTKqiPk2mliC2z65g1M9aDOlBw4
	 eUiT5++pP6xDQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 07/10] nvme-fabrics: reset admin connection for secure concatenation
Date: Mon, 24 Feb 2025 13:38:15 +0100
Message-Id: <20250224123818.42218-8-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250224123818.42218-1-hare@kernel.org>
References: <20250224123818.42218-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8b1f4a9025d1..642394409ec3 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2289,6 +2289,16 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 	if (ret)
 		return ret;
 
+	if (ctrl->opts && ctrl->opts->concat && !ctrl->tls_pskid) {
+		/* See comments for nvme_tcp_key_revoke_needed() */
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


