Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAA1CA0EEB
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 15:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5y0Os5X+yj2WxkLYPUl2dzC1PlGEp0X9rrSuZIex9f0=; b=K30NN0eFLRdFmxIkWJ2U333YXe
	rFwiLTPFiK4dbbWRBAnnorw4EMdDBMIk2bsCFBNTO0v+kVJ85Z5KSZ9xII/i2DXr5YbpOJm94PBy0
	p27+rlZF3b7TRShECovHwoNeWoujw/UVtQfo8g13MVjyoLP3jrz+xGp+Aenv7wOACXk6bIQvsKTxE
	TabruC77FihEgXgZ17z264j6S1OcJsZZrCqIKetw+H1d5r1tm4GSXkS6TXtiJa9zt+qu4DPeElFs6
	Cok1BZpXmqdNzWJ23//8Lig5bjfOehiYwVo3lbtqxZQ1PGDm2ii/6DdBihRFh6T3iXKiB8WDs29Nr
	xaWq1fyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg5Yu-003kBk-04;
	Tue, 12 Sep 2023 15:44:24 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg5Yr-003kBB-15
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 15:44:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id D02CDCE1CF7;
	Tue, 12 Sep 2023 15:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3537C433C8;
	Tue, 12 Sep 2023 15:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694533456;
	bh=FB9faDmLpcSa0JecXQWjp3jxJw6ncd3tBo9iq0W/ndk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G3ROnSZ0wldgPfor7Djjw53oxMtHdaFvn9SBrus+adjnAdBAFGBOpfxb5Rl+VrtIW
	 B3BuxPEu6PLfJnxKQ7YMXisyNJrWv5lC4qkt+z52hz7NttDRVUZRY+wIHyCEnzoBvJ
	 zH4N4joww1KzPgmaCmn6HsMdK3+GION+mDc/c9ReY7FEU+ztI9GZyWSWYeLnFjrbTH
	 McgU/GZmTHoBg4kilFgs3NcZ9kh7qe+Ti3z+O0WRCCrRIaiX3iT20kDdAK3nYE5Hc1
	 ebqJ693maBXKn+Z6TWZrRquStWZYPjxC/uvn4fpuY32gb8JKdN2fLyk5/OE9a7Sfbq
	 ZBZyH2z0c4oaA==
Date: Tue, 12 Sep 2023 08:44:11 -0700
From: Keith Busch <kbusch@kernel.org>
To: Felix Yan <felixonmars@archlinux.org>
Cc: highenthalpyh@gmail.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, xuwd1@hotmail.com, hch@lst.de
Subject: Re: [PATCH] nvme-pci: ignore bogus CRTO according to NVME 2.0 spec
Message-ID: <ZQCHS2L59vRNmZbV@kbusch-mbp.dhcp.thefacebook.com>
References: <20230908155442.31423-1-felixonmars@archlinux.org>
 <ZP-cGgPzIX7WkNRb@kbusch-mbp.dhcp.thefacebook.com>
 <0f6ce98c-8f03-4ce1-badd-ae1346456a3e@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f6ce98c-8f03-4ce1-badd-ae1346456a3e@archlinux.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_084421_733448_C78D0F25 
X-CRM114-Status: GOOD (  17.16  )
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

On Tue, Sep 12, 2023 at 09:26:19AM +0300, Felix Yan wrote:
> 
> Should we also apply the same max() on the NVME_CRTO_CRIMT branch though?
> The spec actually says the same thing (Timeout should be FFh) for that too.

The spec is weird here: the CAP.TO value depends on the CC setting, but
we read and cache CAP.TO before setting CC, so TO is always associated
to CRWMT. We'll need to refresh the CAP value after the initial CC
write, but before final CC.EN.

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 37b6fa7466620..4adc0b2f12f1e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2245,25 +2245,8 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	else
 		ctrl->ctrl_config = NVME_CC_CSS_NVM;
 
-	if (ctrl->cap & NVME_CAP_CRMS_CRWMS) {
-		u32 crto;
-
-		ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CRTO, &crto);
-		if (ret) {
-			dev_err(ctrl->device, "Reading CRTO failed (%d)\n",
-				ret);
-			return ret;
-		}
-
-		if (ctrl->cap & NVME_CAP_CRMS_CRIMS) {
-			ctrl->ctrl_config |= NVME_CC_CRIME;
-			timeout = NVME_CRTO_CRIMT(crto);
-		} else {
-			timeout = NVME_CRTO_CRWMT(crto);
-		}
-	} else {
-		timeout = NVME_CAP_TIMEOUT(ctrl->cap);
-	}
+	if (ctrl->cap & NVME_CAP_CRMS_CRWMS && ctrl->cap & NVME_CAP_CRMS_CRIMS)
+		ctrl->ctrl_config |= NVME_CC_CRIME;
 
 	ctrl->ctrl_config |= (NVME_CTRL_PAGE_SHIFT - 12) << NVME_CC_MPS_SHIFT;
 	ctrl->ctrl_config |= NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
@@ -2277,6 +2260,33 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	if (ret)
 		return ret;
 
+	/* CAP value may change after initial CC write */
+	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap);
+	if (ret)
+		return ret;
+
+	timeout = NVME_CAP_TIMEOUT(ctrl->cap);
+	if (ctrl->cap & NVME_CAP_CRMS_CRWMS) {
+		u32 crto;
+
+		ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CRTO, &crto);
+		if (ret) {
+			dev_err(ctrl->device, "Reading CRTO failed (%d)\n",
+				ret);
+			return ret;
+		}
+
+		/*
+		 * CRTO should always be greater or equal to CAP.TO, but some
+		 * devices are known to get this wrong. Use the larger of the
+		 * two values.
+		 */
+		if (ctrl->ctrl_config & NVME_CC_CRIME)
+			timeout = max(timeout, NVME_CRTO_CRIMT(crto));
+		else
+			timeout = max(timeout, NVME_CRTO_CRWMT(crto));
+	}
+
 	ctrl->ctrl_config |= NVME_CC_ENABLE;
 	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
 	if (ret)
--

