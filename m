Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E12DC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jul 2022 15:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OKoPl6pkKwqfVXv0tkCsZkhTLVRcHEZ8byA5r6vMqzE=; b=bVzpKVZQQCPtZzgIPVpsrbCpUW
	LxWnnh2un/TTB91HQlpQuuOgbLcBSmaRce0KbZZURU94+CKVqsItX845kXcc6otb52PFZ2RW9KMWd
	GnKKGxnMiXpj8AHUSNY6/HdsZLxizThA6auxbap/joY0Q56ekLcbczgk17/2wfrDVL/v1HPMi5xeY
	8tDIsEWZF75xDSyPcuts+1YtbeH8HzuXB+muoovlqX5Rr3yoHmwLOgRYaRCwcn/ZFHAqqZ2noeRPu
	Wx66XxbLpfTs3aN2L7nwhT/iC3Sv+unAEVKUnNJYjJKC8mVWJGjdQqqBT50D0Njfo2/kVUCgm5mkf
	gPEbkLwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBHwB-00CC6k-Oq; Tue, 12 Jul 2022 15:36:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBHvz-00CByv-O2; Tue, 12 Jul 2022 15:36:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E51BA68AA6; Tue, 12 Jul 2022 17:36:20 +0200 (CEST)
Date: Tue, 12 Jul 2022 17:36:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
	kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	p.zabel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-apple: use nvme core helper to cancel requests in
 tagset
Message-ID: <20220712153620.GD27958@lst.de>
References: <1657249565-89708-1-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657249565-89708-1-git-send-email-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220712_083623_949252_3A9FDBFF 
X-CRM114-Status: UNSURE (   8.11  )
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

applied to nvme-5.20.

