Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3543C021A4
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 06:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7r2GjVqVaF5AoTq5DWYzNQ80MNYXBEI1G4QBFmhWkQI=; b=KDg1V2UoSkNW5j5Lwarkje42zk
	szbQN4ckoIRnF/4BnL6n3vAEvdgzDXivoGf4weQz9boyoqiSr1CtNZOvlvVv/oLBsRXqWDLtu8mKl
	Ijv5Ls25sK/hR6SEQa+xCQJyfM8PNz6RLV9r1rsWRRUnBw8EPqnjeh1ZDX5jQetyBbPj7/wXicsBY
	viIwvFpYmyUIj2S8X7apVkAIfQphqOiHPaFktyG+4BKYkZNt7VMUOGfnBFy3yRBRQZ0EAsgw1rUWM
	tb3UpJljUbaBb+bgl313l1Agtw2rXDmvXJ9n2xh7wwkAGTd7ZuT6+zpINw4vQoOXqDDcGoefbQLYW
	oEvRVoPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiSHS-00000009sHb-0l9l;
	Thu, 13 Feb 2025 06:00:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiSHP-00000009sFz-1dhS
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 06:00:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2830767373; Thu, 13 Feb 2025 07:00:52 +0100 (CET)
Date: Thu, 13 Feb 2025 07:00:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/2] nvme: Cleanup the definition of the controller
 config register fields
Message-ID: <20250213060051.GD19506@lst.de>
References: <20250210002935.1744249-1-dlemoal@kernel.org> <20250210002935.1744249-2-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210002935.1744249-2-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_220055_573562_D08F9D43 
X-CRM114-Status: GOOD (  10.92  )
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

> +++ b/include/linux/nvme.h
> @@ -202,24 +202,35 @@ enum {
>  enum {
>  	NVME_CC_ENABLE		= 1 << 0,
>  	NVME_CC_EN_SHIFT	= 0,
> +
>  	NVME_CC_CSS_SHIFT	= 4,
> -	NVME_CC_MPS_SHIFT	= 7,
> -	NVME_CC_AMS_SHIFT	= 11,
> -	NVME_CC_SHN_SHIFT	= 14,
> -	NVME_CC_IOSQES_SHIFT	= 16,
> -	NVME_CC_IOCQES_SHIFT	= 20,
> +	NVME_CC_CSS_MASK	= 7 << NVME_CC_CSS_SHIFT,

While you're at it, maybe use a separate anonymous enum for each
field and a comment about which field it describes?


