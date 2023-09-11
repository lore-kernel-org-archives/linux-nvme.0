Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C60CA0EC3
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Sep 2023 23:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0pMQ5nEz3PDPyWX6xH/nQcRfwUknEDWO/EEsxvwrKEE=; b=ws37i2neOuGrT5tf92gRoY16Uy
	3RZaahQA3eaIyXxBP8qSakzJPlV74UpKFDirK8c2NLY5LGrBhqgFuHZWh5Qn51GSEIUJBXvXIHVpJ
	cDCGs0zK+IXxdNn4S3g/xX7rKvNXWlVp2DrFxSH1vRTmkT1dmNCG4ppDZmK2ie7OOWp/T1mR47Fh5
	PB+S4w3QhEtOGQDZMFfZOLBeVFLylEaWBktaBNG3YXOs4Ie0pZhU7o9BWPL3d197qIszWK67jYNTs
	oTg286+18ekqcqKqTNBLgxqa95OGNlvwwuL3gwrjKxYFTqEeckL0XiO89Yvc0lBG9Vopz4l6PQLUZ
	41O3ifKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfq8g-001bJT-26;
	Mon, 11 Sep 2023 23:16:18 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfq8d-001bIm-1I
	for linux-nvme@lists.infradead.org;
	Mon, 11 Sep 2023 23:16:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 91A84CE1800;
	Mon, 11 Sep 2023 23:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6860C116AF;
	Mon, 11 Sep 2023 23:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694474171;
	bh=Oleg9TJC+AKMIQSbLWxgrU0AxqMUMBEa9ZbYFKCkri0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kSdaMriAlU8GQInb0AOV1OrCTNMMt2tUj6Cx9/LGyQUdzT8afM7Ti40wvIH9oaIGY
	 cNydm7/eRwDhhL4viT0P+BazWi/jWTtwGBivEI0xbPvCG17l9J5DM+tIT3fU/NE1e3
	 tlHVzOgLTRg0fVPlhOVudi7e6cjNoiUbqFjoXJGaQFr+WFyX1a6+Jvut+OIEh49Ld3
	 ffyf6OjObXsHY1Mg0qm79IEf8cvVn72HwlLxiVKLFM9ovckbFiLnCbHQ3L+fLtT/4l
	 IuxIyBbJBTLwyboUGIS7o5z8xc3c/LMp4HxPnvI6fRBC0Lr2DtcleWHaUaZNau9Srz
	 xRAleNAf8q0Hg==
Date: Mon, 11 Sep 2023 16:16:09 -0700
From: Keith Busch <kbusch@kernel.org>
To: Felix Yan <felixonmars@archlinux.org>
Cc: highenthalpyh@gmail.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, xuwd1@hotmail.com
Subject: Re: [PATCH] nvme-pci: ignore bogus CRTO according to NVME 2.0 spec
Message-ID: <ZP-fuXyCZvnUbt8K@kbusch-mbp.dhcp.thefacebook.com>
References: <20230908155442.31423-1-felixonmars@archlinux.org>
 <ZP-cGgPzIX7WkNRb@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZP-cGgPzIX7WkNRb@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_161615_608753_AA01ACDC 
X-CRM114-Status: GOOD (  14.29  )
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

On Mon, Sep 11, 2023 at 04:00:42PM -0700, Keith Busch wrote:
> @@ -2257,12 +2258,15 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
>  
>  		if (ctrl->cap & NVME_CAP_CRMS_CRIMS) {
>  			ctrl->ctrl_config |= NVME_CC_CRIME;
> -			timeout = NVME_CRTO_CRIMT(crto);
> +			/*
> +			 * CRIMT should always be greater or equal to CAP.TO,
> +			 * but some devices are known to get this wrong. Use
> +			 * the larger of the two values.
> +			 */
> +			timeout = max(timeout, NVME_CRTO_CRIMT(crto));
>  		} else {
>  			timeout = NVME_CRTO_CRWMT(crto);
>  		}

Er... please pretend I added the "max()" handling in the 'else' case
instead of the CRIMS case.

-- >8 --
@@ -2259,10 +2260,13 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 			ctrl->ctrl_config |= NVME_CC_CRIME;
 			timeout = NVME_CRTO_CRIMT(crto);
 		} else {
-			timeout = NVME_CRTO_CRWMT(crto);
+			/*
+			 * CRWMT should always be greater or equal to CAP.TO,
+			 * but some devices are known to get this wrong. Use
+			 * the larger of the two values.
+			 */
+			timeout = max(timeout, NVME_CRTO_CRWMT(crto));
 		}

