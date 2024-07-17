Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD4BC3DA42
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 09:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KGCDO4OQmfVw5jG4T9+DpwQ0BUJdnA3BjU4sRS6CNWo=; b=cfmG5mDKaUd3ZS97JXO7I9irea
	IQwOwjsI2yY6a6Ugqwv52IF23TBGN9ZPJwadKGdepzybUgt5iRelTpFU25gj0zpiXDiCSuZXNOCAw
	g3iNMCl5v9kCb66irP3WTmFUG8sEuUTHuuxzAq4bVDfykH+m7/+hBqC8Pe6Uf8gb73TMo8CTxVH46
	fvNKScWg/YD9mJonTRbmNaKiWzS9bSMU9MD7aK6Ux5Y4ZSVZBziRwSyB+EF9sY2+DqQfb+eJkyUcq
	Ltv9wlcEdnZNqZe6UFZ27FTr46ZTki8bSlD2QeIT3LM0BjJH7ueEzJbAnFRJn9mTHXUkmqMSiesF1
	SO6hL9OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU0hf-0000000DGSe-3DM5;
	Wed, 17 Jul 2024 09:12:03 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU0h3-0000000DG3h-4068
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 09:11:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 46BD5CE16B5;
	Wed, 17 Jul 2024 09:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C0EC4AF0F;
	Wed, 17 Jul 2024 09:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721207465;
	bh=z4x681Di2mjo7XyYpCtWCfmkNXIC+zNAmPPGArnVRbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ktyhjrfN7Nl0eDVIFt2bbkABRnckCu8lOaBhACh8eJf5ClNn+ul6KWWHcsgtxVQwk
	 VbT4R3xHl3kOcxIuUfr7x6F7ABa4niqfq9Pg+2szi6dfYppLMDcbyOgIWpOep+NNFr
	 AcHKxlLlRwLxsk4PWv4GK+o76tN/0OpCCSJbK45i0NmA3u0nvnFiiI2HG4D8rtuu2D
	 2t9jOoHohDopgVYbpGmMzQ+q8vc9f891xm4Y6io2B1IpOIolJ+tyqtrq5eUD7OTXHd
	 jVp5jHP/7itKp/RrmZfZu7FweBRJ+ioQ1Nsoi5woFk/ggaZ8yEUjhiwHbuvzCF88Gr
	 qu9XEuP2bP/3A==
From: Hannes Reinecke <hare@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 14/16] nvmet-auth: allow to clear DH-HMAC-CHAP keys
Date: Wed, 17 Jul 2024 11:10:29 +0200
Message-Id: <20240717091031.143188-15-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240717091031.143188-1-hare@kernel.org>
References: <20240717091031.143188-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_021126_214492_0B87A7AE 
X-CRM114-Status: GOOD (  12.07  )
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

As we can set DH-HMAC-CHAP keys, we should also be
able to unset them.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/auth.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 7d2633940f9b..aab8a000b733 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -25,6 +25,18 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 	unsigned char key_hash;
 	char *dhchap_secret;
 
+	if (!strlen(secret)) {
+		if (set_ctrl) {
+			kfree(host->dhchap_ctrl_secret);
+			host->dhchap_ctrl_secret = NULL;
+			host->dhchap_ctrl_key_hash = 0;
+		} else {
+			kfree(host->dhchap_secret);
+			host->dhchap_secret = NULL;
+			host->dhchap_key_hash = 0;
+		}
+		return 0;
+	}
 	if (sscanf(secret, "DHHC-1:%hhd:%*s", &key_hash) != 1)
 		return -EINVAL;
 	if (key_hash > 3) {
-- 
2.35.3


