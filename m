Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B07C53210
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Jan 2023 17:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eo/S+OaD61wC8nfVCgeTz8PgecwlYC16JvlVCJRJsZo=; b=eC2TCQ6iltN7z3kLZmgfDS8XXy
	FWHJt1SV2qVH2VtqOweHU5Mi42zQNm+zXV2TIdv9PlYpQF2Qc/YNSiaRwJLEl3+NpY+ewwoXQrE3M
	8ewzs8nq1zkFvjUIvrUscmSEgXEO/QX2AmCuiUuQoFNmncq4cjJs996pOLJOZZv41a7o5pkZSL6Tq
	y+kC+wpntR8AB6ddkZzi/NfDLBJugCXtP0Y3j3mNrtg+jng1LDgQRuaXuubVBo/S5MvfZ0PpqE0Xv
	V5u+UawecohUo90YpPlpPL5dhvS2ddAsxypVaFr48cR7kDOGmBDd6aSHhnmsKP/zT62rkC4pKk5Ka
	VeFGazZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEZ6z-00ETfq-8D; Sun, 08 Jan 2023 17:05:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEZ6v-00ETdw-W2
	for linux-nvme@lists.infradead.org; Sun, 08 Jan 2023 17:05:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A532E68AA6; Sun,  8 Jan 2023 18:05:20 +0100 (CET)
Date: Sun, 8 Jan 2023 18:05:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: stop nvme matching for nvmem files
Message-ID: <20230108170520.GA19739@lst.de>
References: <E1pCkft-004hzL-0Q@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1pCkft-004hzL-0Q@rmk-PC.armlinux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230108_090530_202973_1DEB703A 
X-CRM114-Status: GOOD (  13.33  )
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

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0cccd40d7801..64cc6947099e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14711,6 +14711,7 @@ T:	git://git.infradead.org/nvme.git
>  F:	drivers/nvme/host/
>  F:	drivers/nvme/common/
>  F:	include/linux/nvme*
> +X:	include/linux/nvmem*

I think the proper thing to do would to just match the right files
from the start:

F:	include/linux/nvme.h
F:	include/linux/nvme-*.h

is it ok if I commit it with your original attributation with that
change?

