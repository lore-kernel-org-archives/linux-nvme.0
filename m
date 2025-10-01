Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C6DCCD180
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Oct 2025 15:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mbP1v76hrpDctldIlbQRcGD4CVyigVeTGEqhJ+nAjLw=; b=jb8UWDJ5OAqKli7lBppLTyNTvF
	5vi6uEKyBNZfugLf1b7F/QTepnHyUKNeGo3Zi/fYLLLFQaJMWL/zkJqDhJGvP8amKd5JtaEY0tgvv
	wyeQaKLRdxD+N7X2L5pJoVWtjTJvJSNQ7JaUDmybIgjxN2dnOpPCNDnM0/XRLRBnikTBql5feeBEc
	jTBpF06gJ53Bgfai33jWGfW/RHGzaRtsILir+SJcaqgfDWIkMh2OzJyDmbTms7HuvMaFxzuQBnCqI
	2KVLsDe+HMLFVycfGskhNh9bjY/lLEY7lhbMCClEFMF/RmseGxxEU0aqAtA3EWRG9uV4qGeomQKFc
	uw7IE29w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3yWv-00000008LWm-48ml;
	Wed, 01 Oct 2025 15:14:09 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3yWv-00000008LW4-0P0r
	for linux-nvme@lists.infradead.org;
	Wed, 01 Oct 2025 15:14:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8853B61E59;
	Wed,  1 Oct 2025 15:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A93C4CEF1;
	Wed,  1 Oct 2025 15:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759331648;
	bh=ARDdG0837CtFtbinMnPgptYJEc/mrXLp+xMOcchDCkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LuH+uW/eSjGPWw1mwl6gA++MaNU/4FRfXkDVFiXdV3PikwjJ8PmaKGWTNuD6cyBUo
	 /37ruAliAngsjbSlSztgonLqj9DxcB43x9hfRl/MBbodR+n2nSTDgq2VkVPdh1D/Tj
	 DKPJwJkxOpBDkJTCaWpDpFnf1BPIyEOKRUeBEKZA1no3FySpjblbMrjIHekwLFK1Jd
	 2eTOFedgn24E8bJRA/3qndcpgP6Zl1TDWhVG/9GSUs+zFDBB/F70z/fyVd40QcNiVT
	 gMzKpSTWNkpp41q6ZP4edILqyGCGNQr1PcRpyk7cI1ZI+99uUZzd9aGJ/TepNqtCT6
	 O4eUUlfQhZEbA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 4/4] nvme-keyring: fixup declaration of nvme_dhchap_psk_hash()
Date: Wed,  1 Oct 2025 17:13:51 +0200
Message-ID: <20251001151351.121181-5-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001151351.121181-1-hare@kernel.org>
References: <20251001151351.121181-1-hare@kernel.org>
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

Fixup stub declaration of nvme_dhchap_psk_hash() to avoid kbuild
warnings.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 include/linux/nvme-keyring.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
index 6115bf5cf346..4bdac22b3cbb 100644
--- a/include/linux/nvme-keyring.h
+++ b/include/linux/nvme-keyring.h
@@ -54,7 +54,7 @@ static inline struct key *nvme_dhchap_psk_lookup(struct key *keyring,
 {
 	return ERR_PTR(-ENOTSUPP);
 }
-u8 nvme_dhchap_psk_hash(struct key *key)
+static inline u8 nvme_dhchap_psk_hash(struct key *key)
 {
 	return 0;
 }
-- 
2.43.0


