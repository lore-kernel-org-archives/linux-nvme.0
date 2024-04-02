Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFD3C6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 19:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mpHtBjRg7UFcQ4jPoLoPLvGCQjYHQt6F/2MbARq/xHM=; b=oJnBN5WBhoT+lbFzbtvc4MGDJm
	gGVloNCnFZM5dw+9HhhNdBLj6DxCbBCjKXke0X94rMH2V4x3DLi9tA3TP5I5RoUUayhcWxmxVFBhq
	evAkmmeO+PC77DjKqt72uQDdHJH7YtcTgbdQA+X1MFInZvzcnavpHD9+jHsQMb2Hu9MfqBtZL5y6Q
	EAVa9IbfDsa5VyhyRtFYnkic4mJWE46nzdiQ7G06W/ugPhDcB0X90Uv0spxAuO1vRYvB+Fh53Ppre
	Q2eez12M24/TjymOIvJh+W3OvRoN02N0se/K7/d2xY9cNHBZtvItSh6fnj09Utve7tQl55A9IS94f
	C9Rfpy0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrkHD-0000000Cbug-3mN1;
	Tue, 02 Apr 2024 19:58:35 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrkHB-0000000Cbtz-0VA9
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 19:58:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5E4FA61007;
	Tue,  2 Apr 2024 19:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A420AC433C7;
	Tue,  2 Apr 2024 19:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712087908;
	bh=TUcXUcmmubYBTZ++26LYOwQPxGeMN8T19SrSIJ0qmoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oJxMqoOfSJnSLv+xzQvKaFL1i89vTkk0HDngz4VYBBVGrBIBnqWg93iCOyECy5Geq
	 0kvBUwFNc4PEsPAt1fus1sft1BnfQZyPwWZs3uTQMo5MKWYaocPJ9ZU4Qo+pGgSzpJ
	 AX8FUHaxdLO0o/BnMOCOb+sTu4ywxq9vKe2b1+JcZy+0tQzFwLAqYdV80LKN8TxW2W
	 3O3FwmuBjd9FCQYBzSYPpqF9THkuLyl6g4t9TjtCIXJlQK67KV3LichopK8oFW4Bx9
	 +VkbEYkz8U2YNyVy06KFPC7BfSjRSAzduE+8hD+Zt0U2P/Ftrx+26fNuooHmu/yFC7
	 XlnfqRL1LaJ7Q==
Date: Tue, 2 Apr 2024 13:58:25 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v2] nvme: split nvme_update_zone_info
Message-ID: <ZgxjYbm0j-4GgVAr@kbusch-mbp.dhcp.thefacebook.com>
References: <20240402144754.751976-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402144754.751976-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_125833_305485_C1FD991E 
X-CRM114-Status: UNSURE (   9.23  )
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

On Tue, Apr 02, 2024 at 04:47:54PM +0200, Christoph Hellwig wrote:
> +	lim->chunk_sectors = ns->head->zsze =
> +		nvme_lba_to_sect(ns->head, zi->zone_size);

Hey, since chuck_sectors is only 32 bits and zone_size is 64, do we need
to worry about massive zones breaking this limit? Unlikely as we are to
see a multi-terabyte zone, it's easy enough to check. We never have
before though, so I guess we're confident it won't happen?

