Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B583AD1CA17
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 05:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=j8/i/8PFZOHvzoBvBwagGIXzXY
	K0a67GZZLtS14ahgDWWFKLnmfNisqV4svhpDT9xwYpqpXsmbnL9P2edjEAjMox+gCb20tkcy57z4G
	FYmXaRzQJAwZzyHa4ylL0KlIW6JJy2MhdOFL0gPcsczD6i7zBqdvR9+qr01Jo9kKK1tO/umj9w27r
	ULWTKqfLj+tNagzXXrqrB85ycNflDVxA2xJssjwA5zQ6U2sy40OV919O9rtpUqjitk4CunQYMX9xW
	OizlaRRGJSxEGoac7V602Qf9JCjM4OpTp9QiMpMS2vzUAQHMeQHF/fFu7zXS/duTUc1/LSdud3RBB
	D50TvZ5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8YpZ-00000001tPG-3QLH;
	Wed, 06 Nov 2024 05:43:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8YpW-00000001tOe-0r0D
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 05:43:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1CD7A68AFE; Wed,  6 Nov 2024 06:43:42 +0100 (CET)
Date: Wed, 6 Nov 2024 06:43:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, m@bjorling.me,
	matias.bjorling@wdc.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 05/11] nvmet: implement crto property
Message-ID: <20241106054341.GE31330@lst.de>
References: <20241105174904.3612888-1-kbusch@meta.com> <20241105174904.3612888-6-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105174904.3612888-6-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_214346_414632_57F143CB 
X-CRM114-Status: UNSURE (   8.71  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


