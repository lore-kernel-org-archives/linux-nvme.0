Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DAEC636D6
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Feb 2023 14:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gfxX7pCuje8ZaVNssVjcpRd8xyd6j4pb/6ZgmNXTPqY=; b=t3JB39KqZRYhhXRzv7x6sQO3jC
	qWeHSUEtsiQ+8UTbVTB1Ord11EXjkDXDgSOOIg2y5p/VKdlqJjWvsDAXX1YtBd1E/MX3yeF5G+3YF
	441k+HtVdMIg4qBPtSF5RCQ6TNoWHKoP6xxKB+CYNAyIf+0Yp0iJFHnQDrc2e+joIcVDLfDb8ifbr
	L8iCa0quvJaKkL2I+GCurN6HQf1T4mAQ4cQbujuu5J2y+kon2j2WxjNxkPv7naEmm7F7eYGbf6Ppd
	/Bglnl3kqu9MPT5QXtjjmkOi8REfuPPuMFuLlDvuiGA7C5dXG3QjrbVh6onaUcQyLUUW1Nq1VlZxo
	BAbX+JZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPPO2-00Ca8M-9L; Tue, 07 Feb 2023 14:55:58 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPPNz-00Ca7O-Fx
	for linux-nvme@lists.infradead.org; Tue, 07 Feb 2023 14:55:56 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 0B80D5C62E;
	Tue,  7 Feb 2023 14:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675781750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gfxX7pCuje8ZaVNssVjcpRd8xyd6j4pb/6ZgmNXTPqY=;
	b=qq2QUUItKbzNs22veyvCOw7DkfFTqrWg2IqNLoGNgjyMyIggq0SnntirHqGcBHY2NHJX+D
	0YYDCWmIjnJF17gA926yHCF2Sf9AgbO1Dggr2cGtJM7ttDhxw54lvvIFCHwK3g9uQnIrfB
	JaG3VWUuX4HPtsuPuZ5FCTCTfqppKC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675781750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gfxX7pCuje8ZaVNssVjcpRd8xyd6j4pb/6ZgmNXTPqY=;
	b=UD7T9g9Ahb/MQeixI+pCa6bmOeREVrzgZL+KK929Gd14VxYWJ+w3zRpoHlT2LhNCPPwwt2
	jlavQJkONBkfcCAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id C5F392C141;
	Tue,  7 Feb 2023 14:55:49 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id B340C51BCF22; Tue,  7 Feb 2023 15:55:49 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme-tcp: check for allocated queue in nvme_tcp_get_address()
Date: Tue,  7 Feb 2023 15:55:48 +0100
Message-Id: <20230207145548.113618-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230207_065555_710329_E8D1E43D 
X-CRM114-Status: UNSURE (   9.64  )
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

We need to check if the queue is allocated, otherwise we get
a kernel crash as 'queue->sock' is not allocated.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4ddf3e7b252a..487ea3e8b6c4 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2859,6 +2859,9 @@ static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 	struct sockaddr_storage src_addr;
 	int ret, len;
 
+	if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
+		return -EINVAL;
+
 	len = nvmf_get_address(ctrl, buf, size);
 
 	ret = kernel_getsockname(queue->sock, (struct sockaddr *)&src_addr);
-- 
2.35.3


