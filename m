Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F18CD4F26
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 06:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=PQQt7e/FXPjj77Bb/puRVuOGXg
	IE66jHMtC47rtRh/4/MPB8eK4qHy4CWgh1K44aFr5tyG1DE18jBxjoILEMWlUCKHbvow9giz468xU
	6hpVqH4tgMVo1R2qGBDPybR+Gyi3/0DaSsFmLvHRipuooPuPe5Gu+XBHsmq+iw237ZRK00qU1Lmsj
	ftgvXIs67Z4TJ0bShSWMCD7j7wydr5xcOBrP8A950QGH9aHr4cMXng8s1g9TO9k86FHQbB09hS4d8
	mVBLBgGN4rkdhcCu1dSo6JWXv+QJyjyGxJeLksZ/Qs3bbJKSzCTVAA5zy4lUpAb1bAQx6bt47sZ7Y
	UC/mI4Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd0Wp-0000000AdKl-3q2i;
	Fri, 26 Jun 2026 06:59:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd0Wn-0000000AdKI-3PBO;
	Fri, 26 Jun 2026 06:59:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0515868B05; Fri, 26 Jun 2026 08:59:00 +0200 (CEST)
Date: Fri, 26 Jun 2026 08:59:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: sven@kernel.org, kbusch@kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, j@jannau.net,
	neal@gompa.dev, asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, baijiaju1990@gmail.com
Subject: Re: [PATCH v2] nvme-apple: Use acquire/release for queue enabled
 state
Message-ID: <20260626065900.GA11368@lst.de>
References: <20260618021543.3866850-1-hanguidong02@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618021543.3866850-1-hanguidong02@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260625_235905_999724_AE546BD7 
X-CRM114-Status: UNSURE (   7.66  )
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


