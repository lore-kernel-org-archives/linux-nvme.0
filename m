Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F17C04A94
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Aug 2023 12:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WhusatABSHNLPd4E/4jricI/gtUKlyK2XFGYryjo8Ic=; b=qRKCUTiJ2MZSBKJ/pPIbviMKai
	0Gq3RMxeicmW8TZKjxzyF6eU20vZnBG3tXr9JKDGn2NI32K1CkTYkqiw7EbUxHD+KX7Z6OxdG/rk2
	VOnN+svWQwnM/Z0ZzxCr3Dyk8Y5bIgcCo0GeX7/dHroCVNjXosqHCX7Y9ODVuIgVS3pkp7O4pSynN
	tI1s7zTmNi24CJwuRBA5jLzdH/FrRJ03JejAjle4tYqqgQxt+gzDlY2A56UH7lshSrGsZSxE0a4UD
	ERi0YIHObVIAmHlxzx0/PWQuBTUDM63X7nAwWzDxvjNbL3fLD+0MFZD8kVipUrQazjqYx6B+zgSfW
	JEhm5yQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWFIG-0043pg-30;
	Wed, 16 Aug 2023 12:06:32 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWFI9-0043iL-2Q
	for linux-nvme@lists.infradead.org;
	Wed, 16 Aug 2023 12:06:28 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 035461F8D6;
	Wed, 16 Aug 2023 12:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692187584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WhusatABSHNLPd4E/4jricI/gtUKlyK2XFGYryjo8Ic=;
	b=j7vaSkRHx3VxTEoI851cDyaoAPqQVleYqrq2R0vMqawjjZyLfYebVldP/WRiAUjJ8KiP7O
	NbXlHGUkQ9Vc5GZFPc5VDJLwv0v+FoGrxHIKyPpU+vMGTmi7PjkuCUxeK0Epjdmo/5bBUE
	UgE3hYe1PYmrYGyy3Eoqch/u6T7S5jA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692187584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WhusatABSHNLPd4E/4jricI/gtUKlyK2XFGYryjo8Ic=;
	b=EsXAqqjv17Kcdm5nJKEvy3nelivOUxr+BXX42cdeZOb6fp1VTWoEThyOtRR99MHUSymszA
	LfpotJkIHnARavBQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id D3F6D2C169;
	Wed, 16 Aug 2023 12:06:23 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id C648451CB230; Wed, 16 Aug 2023 14:06:23 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 10/18] nvme-tcp: improve icreq/icresp logging
Date: Wed, 16 Aug 2023 14:06:00 +0200
Message-Id: <20230816120608.37135-11-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230816120608.37135-1-hare@suse.de>
References: <20230816120608.37135-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230816_050625_927030_0A46EB80 
X-CRM114-Status: GOOD (  13.17  )
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

When icreq/icresp fails we should be printing out a warning to
inform the user that the connection could not be established;
without it there won't be anything in the kernel message log,
just an error code returned to nvme-cli.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index e8e408dbb6ad..ef9cf8c7a113 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1403,8 +1403,11 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	iov.iov_base = icreq;
 	iov.iov_len = sizeof(*icreq);
 	ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
-	if (ret < 0)
+	if (ret < 0) {
+		pr_warn("queue %d: failed to send icreq, error %d\n",
+			nvme_tcp_queue_id(queue), ret);
 		goto free_icresp;
+	}
 
 	memset(&msg, 0, sizeof(msg));
 	iov.iov_base = icresp;
@@ -1415,8 +1418,11 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	}
 	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
 			iov.iov_len, msg.msg_flags);
-	if (ret < 0)
+	if (ret < 0) {
+		pr_warn("queue %d: failed to receive icresp, error %d\n",
+			nvme_tcp_queue_id(queue), ret);
 		goto free_icresp;
+	}
 	if (queue->ctrl->ctrl.opts->tls) {
 		ctype = tls_get_record_type(queue->sock->sk,
 					    (struct cmsghdr *)cbuf);
-- 
2.35.3


