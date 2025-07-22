Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45545C83F25
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jul 2025 06:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SBKOdxW28jmuDVPViy2Scq83g0cvOJ2w8ggLjiNpmFA=; b=bHrhDVAiurcOtet186IjB8LLA4
	mRRE1HOaCLwrGJSQGU1I9Xpk+DTzOI+/kP9Z6r1IK7DCUdpcaDeRuDyPVmjq3sS4cC+Q7XR+V4Kqh
	GUfocpzXVVqsKe5/o9rVk/9ZUfM70JzL77Dr6SFTaPip1q4r/Ypz2/tju5MJXCrrhC/vyY8VEUTnz
	EH86SzBFYm6tZDX25TM4/Qr2QSdrTdFPn0GfFsPFBxOQzTRgXRnMoTpEh39aGeHPDzorHFadF9huW
	rFBwa0WhGlcv19KTFOmstZIZe/m3agWA4LMUvLWGWDv5mxcUAoEEUCyS/Q9wmpb8aaeFZggTVajkD
	IyvBORrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue6UY-00000001QSe-3eYt;
	Tue, 22 Jul 2025 06:28:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue6UW-00000001QQO-3Z7g
	for linux-nvme@lists.infradead.org;
	Tue, 22 Jul 2025 06:28:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BA4B468AA6; Tue, 22 Jul 2025 08:28:30 +0200 (CEST)
Date: Tue, 22 Jul 2025 08:28:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, gost.dev@samsung.com,
	nitheshshetty@gmail.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvmet: Add support for FDP in fabrics passthru path
Message-ID: <20250722062830.GA15013@lst.de>
References: <CGME20250716134010epcas5p1c7ca7bcc7addf12c4cab2e4aefb7e020@epcas5p1.samsung.com> <20250716133944.1384388-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716133944.1384388-1-nj.shetty@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_232845_029967_1BCD86BC 
X-CRM114-Status: UNSURE (   8.74  )
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

added to nvme-6.17.


