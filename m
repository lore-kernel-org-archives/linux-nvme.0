Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70F3C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Mar 2022 08:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LRNwIfewu1/Ld/75IhXBXJYE1PhXNp3EQqTcQRjDrIU=; b=TVziILzazlcvLsrbbhxFAdauxl
	i+W2NinPyYXccn3pjDlVoOZsdnBtHuSHWGKl5G4+2TJSfrGeItFffmdpY74f7QgmadEtwkfE/tMtz
	Vgbgm6U8rYtltenAf0WLAqPNeYUyFk/qN7pGe7PSu07HxaC4EsdEKTNlm3sZwCCs2FAJ/tprlEnNm
	a6ji43N2i3BU6wtUWMSGu3X9dy9W7MnKkSWXSmzpfXNgnRrHDRohad6Uhp16haIoPRooMNtWpOthw
	2VqGinTLfbpDapCljTjD3HrMAcesiM5UyXD0m+pfN6y0Ivj77uR4rk8Cm61m24dGFKWbtwlnwe5BH
	30ORGyLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nYkR9-007jcf-8b; Mon, 28 Mar 2022 08:09:15 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nYkQn-007jTW-N2
 for linux-nvme@lists.infradead.org; Mon, 28 Mar 2022 08:08:56 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id C1ACD1F380;
 Mon, 28 Mar 2022 08:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648454929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LRNwIfewu1/Ld/75IhXBXJYE1PhXNp3EQqTcQRjDrIU=;
 b=Lc5dw/fAjHePzAoqj/PauRMj4roscSVnEgOXPWigVdDHixVhQWR6jaAuKfUE6am2oXu+Qf
 hDOw6SJl2Ln06VjR8F0dV5lHodxenKT5uix9UTG/nUdo7ft06ygNtZXJ/xq2J8ngo7ka9g
 iHZJJx8XV5s7dkJkXnT4sCIcPqa3pf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648454929;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LRNwIfewu1/Ld/75IhXBXJYE1PhXNp3EQqTcQRjDrIU=;
 b=sjG7IfG4w3SYSTrWA8XqiGarPaG4zghISIxA3GLjapBLfNxAM87ePgNj4SH+HtdadAiSz6
 aq9qaQLTLHupA5CA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id B7ED0A3B9E;
 Mon, 28 Mar 2022 08:08:49 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id A937D519399A; Mon, 28 Mar 2022 10:08:49 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH 02/11] crypto: add crypto_has_kpp()
Date: Mon, 28 Mar 2022 10:08:27 +0200
Message-Id: <20220328080836.72844-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220328080836.72844-1-hare@suse.de>
References: <20220328080836.72844-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220328_010854_017047_E09E5F40 
X-CRM114-Status: UNSURE (   9.82  )
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

Add helper function to determine if a given key-agreement protocol
primitive is supported.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 crypto/kpp.c         | 6 ++++++
 include/crypto/kpp.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/crypto/kpp.c b/crypto/kpp.c
index 7aa6ba4b60a4..678e871ce418 100644
--- a/crypto/kpp.c
+++ b/crypto/kpp.c
@@ -104,6 +104,12 @@ int crypto_grab_kpp(struct crypto_kpp_spawn *spawn,
 }
 EXPORT_SYMBOL_GPL(crypto_grab_kpp);
 
+int crypto_has_kpp(const char *alg_name, u32 type, u32 mask)
+{
+	return crypto_type_has_alg(alg_name, &crypto_kpp_type, type, mask);
+}
+EXPORT_SYMBOL_GPL(crypto_has_kpp);
+
 static void kpp_prepare_alg(struct kpp_alg *alg)
 {
 	struct crypto_alg *base = &alg->base;
diff --git a/include/crypto/kpp.h b/include/crypto/kpp.h
index cccceadc164b..24d01e9877c1 100644
--- a/include/crypto/kpp.h
+++ b/include/crypto/kpp.h
@@ -104,6 +104,8 @@ struct kpp_alg {
  */
 struct crypto_kpp *crypto_alloc_kpp(const char *alg_name, u32 type, u32 mask);
 
+int crypto_has_kpp(const char *alg_name, u32 type, u32 mask);
+
 static inline struct crypto_tfm *crypto_kpp_tfm(struct crypto_kpp *tfm)
 {
 	return &tfm->base;
-- 
2.29.2


