Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C53C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 31 May 2022 05:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xBM3SjSADpCtaGTcU20MqvmhiyUnvgFDR0aC/pBuNI4=; b=beW0kyLC/RAnWv4TYXC4ZXbeYO
	jG4ZVpwsQ3ST7OqXSpqCz7lXgkMEgy4PGAk2hv9BXZFSqnCL3GWz2lmK41ghmSKSYyWXGLm3xsnt4
	X7lrDeL/Q4BJEmbMcCUf+ZYCXf0Tn/Uu3TIG//MNhiMngf71HbECa/rT7fzCdYzII96Ty1TTpYsQq
	nftEv47svaR8azTkRWUaamAjKEUOXkYIqDNyWxFxD4TAyIIIe3sLMGr3f0xRYaBGe6YvmN+HT4T+j
	RkyjLtGykscHi3dZXmcv5hnEOhk2IOQVbS52ySlAY1e9oXB/c/rxPPJGxS9EECgfhVvMYb44rYq3G
	0ZiBjZqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nvueT-009OxE-UK; Tue, 31 May 2022 05:42:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nvueQ-009OwH-Ub
	for linux-nvme@lists.infradead.org; Tue, 31 May 2022 05:42:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 64A1768BEB; Tue, 31 May 2022 07:42:39 +0200 (CEST)
Date: Tue, 31 May 2022 07:42:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Niklas Cassel <niklas.cassel@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: set controller enable bit in a separate write
Message-ID: <20220531054238.GB20486@lst.de>
References: <20220526135721.390434-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526135721.390434-1-niklas.cassel@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220530_224243_165640_CF0ECA28 
X-CRM114-Status: UNSURE (   8.81  )
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

Thanks,

applied to nvme-5.19.

