Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49412EB48F4
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Feb 2026 10:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lc55MufeLpU24ZftEABb3grhkBRFAd1Jlyep8ro3YWk=; b=3YinnvmGWQLs3A9wC7g/HO8txM
	sXljw6k4wUEGuX27A41vSuvEyGTqKg243tjtLAmXz2NLKP6gFpcBzGOGp8mC9Np174/P/etuV8g3Y
	OBdvoA5Z7QanXCDJtz0eMWK1ecAZKZH/zgVl3HnQEb2U74hz0tNVfchyS98eaewf4uqXWZhJDs365
	Ect5Z0yIohod8vBrSDVDYLXwpghGENs5nnZIVd+magBPucjG5C2iiSG+ODRsGD9QHQHVSL7rRkkdF
	yt55GCS/IO9ywPNnQmUEUjL2KU+DgmWktEmcb9qUz5+mLSW6i0gK4hSn/X2E2/3Hup1GANzAkkuqm
	XSkVqzbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqTju-00000001vc3-2w7c;
	Thu, 12 Feb 2026 10:16:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqTjr-00000001vbB-3QNY
	for linux-nvme@lists.infradead.org;
	Thu, 12 Feb 2026 10:16:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 29A3E68D09; Thu, 12 Feb 2026 11:15:54 +0100 (CET)
Date: Thu, 12 Feb 2026 11:15:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linan122@huawei.com, song@kernel.org, yukuai@fnnas.com, hch@lst.de,
	sagi@grimberg.me, axboe@kernel.dk, linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH V4 0/3] block: ignore discard return value
Message-ID: <20260212101553.GB8615@lst.de>
References: <20260211204438.22568-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211204438.22568-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_021600_014452_C22F4E73 
X-CRM114-Status: UNSURE (   9.34  )
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

And maybe Jens can pick this up for 7.0 so that we have a clean
slate for the new merge window?


