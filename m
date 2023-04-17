Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A624C77B72
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 13:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3OTwR+cfXo8V6ukYMxUL2sC/EgXUXrfuFTwmmIrIZcw=; b=zfYNhZrokf04cSOzKXhxyKYsIS
	EvYhfop0PQmRA4HUAsWqPzf0WBGIQbDZS6A38wnlIMgN/4JIxjjq0WvEa8uEfU0YvpUnGgOZDYVxl
	Bfv5hAMHqhgDeJZSUNLwvw5yVIxEcyhnbftOuuOqjg7c3kM132yxPYGOEQZqNLMCCST3GIzt+5EPG
	4OARYzyVdqCu6ViBbqQHf5wH7gCTwuNcfE+LGidRX5gFNNQp3UHFjgeP7h+ghJKpaRJoo3srsiqNm
	DOFfuLKWG7orKPw65Swfki1zBgbMu3ic0F+sb94410FH8ky9ffduELMbiR9+4M/7k1hodPwpif0cQ
	Th5EMsxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poOVi-00GHrF-2l;
	Mon, 17 Apr 2023 13:03:10 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poOVd-00GHmQ-1m
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 13:03:08 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 214B81FE0B;
	Mon, 17 Apr 2023 13:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681736584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3OTwR+cfXo8V6ukYMxUL2sC/EgXUXrfuFTwmmIrIZcw=;
	b=09p6CNzcYdQVqsLxWvS5gTk4Zwg4Rx0WTgpfdQ1sH0CMoQ/nn+FS+cFJ8oOiBDSsHMc1e8
	s9xRih12ZjM/6ArkdjXsvCwzw36gV7wzFVLYMtW5xTTQd4KHPyJnBUgRtBEUGD4ZZuosOE
	pj1i0XfMplNL0wudcjIhviA35EelCuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681736584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3OTwR+cfXo8V6ukYMxUL2sC/EgXUXrfuFTwmmIrIZcw=;
	b=t+4fkEKjLFxxD+W3UCvqJIs58uhYclA93FbBRqqJ1NLJzlxfyDEt2jl/e8U1lNEXhQRMEw
	Heh3ytT+FQvA4BCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 0F4EF2C146;
	Mon, 17 Apr 2023 13:03:04 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 01F7851C25A2; Mon, 17 Apr 2023 15:03:04 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 04/18] nvme-tcp: add definitions for TLS cipher suites
Date: Mon, 17 Apr 2023 15:02:48 +0200
Message-Id: <20230417130302.86274-5-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230417130302.86274-1-hare@suse.de>
References: <20230417130302.86274-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_060305_771105_6D490424 
X-CRM114-Status: UNSURE (   9.48  )
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

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 include/linux/nvme-tcp.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/nvme-tcp.h b/include/linux/nvme-tcp.h
index 75470159a194..19ca863813f1 100644
--- a/include/linux/nvme-tcp.h
+++ b/include/linux/nvme-tcp.h
@@ -18,6 +18,12 @@ enum nvme_tcp_pfv {
 	NVME_TCP_PFV_1_0 = 0x0,
 };
 
+enum nvme_tcp_tls_cipher {
+	NVME_TCP_TLS_CIPHER_INVALID     = 0,
+	NVME_TCP_TLS_CIPHER_SHA256      = 1,
+	NVME_TCP_TLS_CIPHER_SHA384      = 2,
+};
+
 enum nvme_tcp_fatal_error_status {
 	NVME_TCP_FES_INVALID_PDU_HDR		= 0x01,
 	NVME_TCP_FES_PDU_SEQ_ERR		= 0x02,
-- 
2.35.3


