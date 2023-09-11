Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BD6CA0EC6
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Sep 2023 23:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CPZZ9N1inWoD/M9vxwWn673i9niYy2+pVc94FmBiiJU=; b=JGKuE96OEcEhQJEpzwYUcYpkFZ
	DVW5m+a5tc6qG41MFsWc5pK2DUKHYsaF2339OF7+IFUZLawHsOs/u81YXwJWpUw/z4wYWGYashYiV
	Uz9AhRU4QGldq5pqCxNEa0jJ6HdMOddYiheXf/bTzG8Edd2MaEfthRwyDD64oeRLUdCCSsgp2Bx7G
	atUVDEGPCiNWOskSeb48/NeJbTufgv9h5QQVsgtQ2wK5+hNklGCFPpxfdHK6X39a1bvE798t26nKz
	W7vOTT/z4OV6BP4v9KqH43pQwf5JdGs7vVyKuo5hOmVklVNACMFLM3V/Jn9zlep6D6/TS+84SbZlH
	BhpHQnHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfptl-001ZSu-2g;
	Mon, 11 Sep 2023 23:00:53 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfptg-001ZRw-2u
	for linux-nvme@lists.infradead.org;
	Mon, 11 Sep 2023 23:00:50 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3591761473;
	Mon, 11 Sep 2023 23:00:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62466C116A1;
	Mon, 11 Sep 2023 23:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694473244;
	bh=4t1Rotwjd0kPAr8x16QEIpXqAf/qksX10Q+H2SVT2F4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dEgLYmxbB/d6gCzzPDBlBwEKakUUj6SQeXdRGz+a5eRXIaYlxifcvZjtAeyWax4HC
	 RW06DzV4t51ouN59aehj4AteyKLpAYlCGhASP5QJzy2hjWDMWZgJhOMHVbfHQUv2B9
	 btdZ+7p+8IgQFQzRyae6vuKPBYvuM/R5lkDoBaG3y8aGtumwRSdYjW0W4RgaKnmwTc
	 nM9tX19DQolDcnXGNMQgHEFC0xwP/BdEEjpYpo6m8ynTosKZhm6wrSs2HbHwaT01qu
	 UZJkGF75nKHYhEt6J2hiSaqeq0VGuNspQwFnef8iolMWSV9E0a9zq/xRdfUtfpJsiM
	 hnzxJ2QjnXjIQ==
Date: Mon, 11 Sep 2023 16:00:42 -0700
From: Keith Busch <kbusch@kernel.org>
To: Felix Yan <felixonmars@archlinux.org>
Cc: highenthalpyh@gmail.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, xuwd1@hotmail.com
Subject: Re: [PATCH] nvme-pci: ignore bogus CRTO according to NVME 2.0 spec
Message-ID: <ZP-cGgPzIX7WkNRb@kbusch-mbp.dhcp.thefacebook.com>
References: <20230908155442.31423-1-felixonmars@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908155442.31423-1-felixonmars@archlinux.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_160049_023260_BEF4B8C3 
X-CRM114-Status: GOOD (  23.48  )
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

On Fri, Sep 08, 2023 at 06:54:42PM +0300, Felix Yan wrote:
> NVME 2.0 spec section 3.1.3 suggests that "Software should not rely on
> 0h being returned". Here we should safeguard timeout reads when CRTO is 0 and
> fallback to the old NVME 1.4 compatible field.
> 
> Fixes 4TB SSD initialization issues with MAXIO MAP1602 controller, including
> Lexar NM790, AIGO P7000Z, Fanxiang S790, Acer Predator GM7, etc.
> 
> ----------
> nvme nvme1: Device not ready; aborting initialisation, CSTS=0x0
> ----------
> 
> Signed-off-by: Felix Yan <felixonmars@archlinux.org>
> ---
>  drivers/nvme/host/core.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f3a01b79148c..8ec28b1016ca 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2255,11 +2255,17 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
>  			return ret;
>  		}
>  
> -		if (ctrl->cap & NVME_CAP_CRMS_CRIMS) {
> -			ctrl->ctrl_config |= NVME_CC_CRIME;
> -			timeout = NVME_CRTO_CRIMT(crto);
> +		if (crto == 0) {
> +			timeout = NVME_CAP_TIMEOUT(ctrl->cap);
> +			dev_warn(ctrl->device, "Ignoring bogus CRTO (0), falling back to NVME_CAP_TIMEOUT (%u)\n",
> +				timeout);
>  		} else {
> -			timeout = NVME_CRTO_CRWMT(crto);
> +			if (ctrl->cap & NVME_CAP_CRMS_CRIMS) {
> +				ctrl->ctrl_config |= NVME_CC_CRIME;
> +				timeout = NVME_CRTO_CRIMT(crto);
> +			} else {
> +				timeout = NVME_CRTO_CRWMT(crto);
> +			}
>  		}
>  	} else {
>  		timeout = NVME_CAP_TIMEOUT(ctrl->cap);

What do you think about this change instead? We don't need to print a
warning on every device reset, but we should probably add a comment
explaining why this is happening.

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 37b6fa7466620..b4577a860e677 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2245,6 +2245,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	else
 		ctrl->ctrl_config = NVME_CC_CSS_NVM;
 
+	timeout = NVME_CAP_TIMEOUT(ctrl->cap);
 	if (ctrl->cap & NVME_CAP_CRMS_CRWMS) {
 		u32 crto;
 
@@ -2257,12 +2258,15 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 
 		if (ctrl->cap & NVME_CAP_CRMS_CRIMS) {
 			ctrl->ctrl_config |= NVME_CC_CRIME;
-			timeout = NVME_CRTO_CRIMT(crto);
+			/*
+			 * CRIMT should always be greater or equal to CAP.TO,
+			 * but some devices are known to get this wrong. Use
+			 * the larger of the two values.
+			 */
+			timeout = max(timeout, NVME_CRTO_CRIMT(crto));
 		} else {
 			timeout = NVME_CRTO_CRWMT(crto);
 		}
-	} else {
-		timeout = NVME_CAP_TIMEOUT(ctrl->cap);
 	}
 
 	ctrl->ctrl_config |= (NVME_CTRL_PAGE_SHIFT - 12) << NVME_CC_MPS_SHIFT;
--

