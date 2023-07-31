Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA193C001DC
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 05:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=kurptu2dBohoWUr/XtYQE5yP71
	u6AtdJxbtVdeE6oIUZZnQOC2BwkL3bZCe828tgQ25b6C2VaYpnbxF1SJ01ogcFeMc28qiYD7KQHok
	GfI+ih3+GZg8UMapHpLxAlvzqzk85+2sKajiYOjeVI7K6o3HjLvB25mGcIYJLUg6SWFbDm7SPCoH/
	hg6b9qHZiun2ZHKmKQEfLMlu/iVG5aV5kY54EeRy+ONJY7tBdZsZfarjHWD6vOUlNoSTQQY9NDi/M
	VGiL8cusgOXGF6zLn9sCAIqNyHEiPdXqn1KRE8874F0E1DykZ4BJj33dnz12r/etRkolGPBE5uU6i
	mPd7Va2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQLt8-00E07Z-1e;
	Mon, 31 Jul 2023 05:56:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQLt2-00E06y-23
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 05:56:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B13E467373; Mon, 31 Jul 2023 07:55:59 +0200 (CEST)
Date: Mon, 31 Jul 2023 07:55:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mark O'Donovan <shiftee@posteo.net>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, kbusch@kernel.org,
	hare@suse.de
Subject: Re: [PATCH 1/2] nvme-auth: unlock mutex in one place only
Message-ID: <20230731055559.GA30150@lst.de>
References: <20230727134748.4163796-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727134748.4163796-1-shiftee@posteo.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230730_225608_837288_18423A7A 
X-CRM114-Status: UNSURE (   9.10  )
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

