Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45427C46CA0
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Dec 2023 15:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kg1HBqZ/g2XoSE0I82i6SpbSbe2AnqtYknByJtb3vUE=; b=DrsAQr6UiTfUza/qRFFaciTkfo
	c0Gfkhm7FgwXP5HrPaRwN6ylBV//DdCDnohrKEr8OPnwCeNY5GnR8ILvc4m98zvG5Dnz3MP/KJfeg
	yHK7qv/Y6uZ77n6LnnbVXON350Fov53xI8Ng9Pa9zn2ez5+CDpLnYpJJF1/Ha1vFzB3eUVp0i957e
	39rNF7LCRWmu4CQOCvwduoMlil3WOMpHSZ8eGglS216lG7jMbdVbDGmPYzoFiNld2rukqw+lT6L+f
	EOmYxl5pu3npcw2stsT7sn/tMXU/IjdkHNMTqihgDWxdcoJJSxgSkNI/oMketBdY7OPgFoedM5hqX
	+8uJtYOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBGBR-00DAUT-2H;
	Thu, 07 Dec 2023 15:21:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBGBO-00DAS2-10
	for linux-nvme@lists.infradead.org;
	Thu, 07 Dec 2023 15:20:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B2F57227A88; Thu,  7 Dec 2023 16:20:48 +0100 (CET)
Date: Thu, 7 Dec 2023 16:20:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Georg Gottleuber <g.gottleuber@tuxedocomputers.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Werner Sembach <wse@tuxedocomputers.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Georg Gottleuber <ggo@tuxedocomputers.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Add sleep quirk for Kingston drives
Message-ID: <20231207152048.GA20561@lst.de>
References: <20230920085210.22573-1-wse@tuxedocomputers.com> <12d32e8e-e20b-4023-8299-39d2a69c0cd9@tuxedocomputers.com> <20231206092420.GA27348@lst.de> <c930e543-7dab-4559-95d2-270b8df38f3b@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c930e543-7dab-4559-95d2-270b8df38f3b@tuxedocomputers.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231207_072058_494663_AB323F79 
X-CRM114-Status: UNSURE (   9.33  )
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

Ok.  I guess we have to live with this quirk then :(

Reviewed-by: Christoph Hellwig <hch@lst.de>

