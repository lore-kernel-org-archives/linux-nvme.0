Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F74C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Dec 2022 07:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xtw9z/SPI0t1LoxMjX96bH/gdzT34oDUeG6sSAiMkow=; b=2yqPRSp2iwhQLrJuXwiDU5l26l
	HJtER69XIYndUkgWwi/ztDZJT8XUZZZuY2zInn6kNR+ULS1jw1Ylpi142d+FXntOxIR7XqQAJf3i4
	JzlXvbNRs7sEUNA84poiHOCmpM9qvJPooQCHZdzFmdLRpBwPKFYqN3BOCGxPCtfm5sWGpTvMX3MWy
	szpVWysOUd/fO0DR2ThruzxJu3hdzfVvvex2sH/Yk807DWsU5xTySNKFw0QopGY/MDeuaYfJEVc43
	oJpBA5LSWvgNQ5C7p8rw/IEht3cvi1GI5P8jxSBNq5LOkxHF8TFnfWyc5g6IsCqpxSntrDqMFkFc1
	7XxnaXgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8ckd-004tzj-7a; Fri, 23 Dec 2022 07:45:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8cka-004tyJ-1E
	for linux-nvme@lists.infradead.org; Fri, 23 Dec 2022 07:45:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7CC026732D; Fri, 23 Dec 2022 08:45:46 +0100 (CET)
Date: Fri, 23 Dec 2022 08:45:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: Re: only allow unprivileged passthrough for commands without
 effects v3
Message-ID: <20221223074545.GA5356@lst.de>
References: <CGME20221221145321epcas5p4ff234021b074bf0a513d1cb233135656@epcas5p4.samsung.com> <20221221101050.759606-1-hch@lst.de> <20221222081904.GA4413@green>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222081904.GA4413@green>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221222_234552_247007_1C68F4F7 
X-CRM114-Status: UNSURE (   8.70  )
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

Btw, any chance you could write some tests for blktests to verify
the unprivilged passthrough operations?


