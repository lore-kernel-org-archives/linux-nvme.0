Return-Path: <SRS0=M7ZW=NH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42949C4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Aug 2021 16:25:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D9860FC3
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Aug 2021 16:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 06D9860FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=x34n1Yp9ZHQluuzDSp/wTR+f0A7uY5Ikt/Jby/nwoME=; b=giKLlXyFdf2F2Z
	BZh/wJVHAO5n7D05Q/lJOW+FNtEPf3jIumzzutHx3yw6shPgKPfHum7FgRuC2JA8hmsR3v3+MjZZV
	bLQAR16R29dZm1zgV1xPjqma7Q6YPmEHVix8rf6g2A+PbUH6YNhljw4CZ18dGVR7AutVTUf0I4NoW
	0RJtIdpC1EuyUAu1Y7w9xWN9LVrCEjhPwr44phuVDx1ozfAmYFFf7c6UDS+hnWRednuZAV6TB+0tH
	mMxeGlUXSUyTcSI8efLe0DWdc8cfkE7lnxNgSPjejR+CBE29xPy801pKw8ps3qxNNrctavCk6rTqj
	AyGvq+3Dfr4sZo4F4VeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mFfQA-00HQZo-1C; Mon, 16 Aug 2021 16:25:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mFfQ6-00HQZA-RV
 for linux-nvme@lists.infradead.org; Mon, 16 Aug 2021 16:25:04 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 524FB60F58;
 Mon, 16 Aug 2021 16:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629131101;
 bh=fK/v/mhDX6VEF2jouOsLPQMcp8dXh7iCAFqAwHFrqys=;
 h=From:To:Cc:Subject:Date:From;
 b=V6CQcbzMzQoGTJV57rbhcSpgiq3nblnuXHCmY4l+QvCghVJB8m/M87RaqwRcVJ9fA
 G9gFRICepviB+awmHyEt1hLYbhEk0x3DCUgU91rusA0actKPt7Xj6T6DFKPPZ2y/q1
 Xr+S7ldAijSxAXkzKumQku2VcEDWxadtfikocArQLU9swtFj37fED53zU82lAIcJS7
 S9Z5qR5PBF/pNkqB0Dsxvvhk3KO92idf4Jyv3T4SDA7ysU/H2Becyxeej1CraFINeR
 MxgGWVFO4DPwIUFJdyOMMI+48mNsTnDcxSUzVQzs4D+BtjyIlvHIbHylUVS9sWc5P+
 Cly4S0eGUe8zQ==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: remove nvm_ndev from ns
Date: Mon, 16 Aug 2021 09:24:52 -0700
Message-Id: <20210816162452.223334-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210816_092502_950915_300FCE5D 
X-CRM114-Status: UNSURE (   8.89  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Now that the lightnvm driver is removed, we don't need a pointer to it's
now non-existent struct.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/nvme.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ab803f91ace1..908ddba9e7ef 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -443,7 +443,6 @@ struct nvme_ns {
 	u32 ana_grpid;
 #endif
 	struct list_head siblings;
-	struct nvm_dev *ndev;
 	struct kref kref;
 	struct nvme_ns_head *head;
 
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
